import hashlib
import json
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from core import Catalog, install, parse_themes

THEMES = Path(__file__).resolve().parents[2] / "Themes"


class CatalogTests(unittest.TestCase):
    def setUp(self):
        self.catalog = Catalog.from_folder(THEMES)

    def test_all_eight_themes_and_assets(self):
        self.assertEqual(len(self.catalog.themes), 8)
        files = self.catalog.files([theme.key for theme in self.catalog.themes])
        self.assertEqual(len(parse_themes(files["main.lua"].decode())), 8)
        self.assertNotIn("main.luac", files)
        metadata = json.loads(files["updater.json"])
        for name, digest in metadata["sha256"].items():
            self.assertEqual(hashlib.sha256(files[name]).hexdigest(), digest)

    def test_selected_package_excludes_other_themes_and_images(self):
        files = self.catalog.files(["Teal"])
        self.assertEqual([theme.key for theme in parse_themes(files["main.lua"].decode())], ["Teal"])
        self.assertEqual(set(files), {"main.lua", "teal1.5.png", "updater.json"})

    def test_ignores_comments_strings_and_nested_braces(self):
        lua = '''-- system.registerTheme({key="fake",name="Fake"})
        system.registerTheme({key="Real",name="A } theme", colors={1,2}, toolbarBackground="dark"})'''
        result = parse_themes(lua)
        self.assertEqual(len(result), 1)
        self.assertEqual(result[0].name, "A } theme")

    def test_rejects_asset_traversal_and_duplicate_keys(self):
        with self.assertRaises(ValueError):
            parse_themes('system.registerTheme({key="evil",name="Evil",image=lcd.loadBitmap("../x.png")})')
        theme = 'system.registerTheme({key="same",name="Same"})'
        with self.assertRaises(ValueError):
            parse_themes(theme + theme)

    def test_github_downloads_assets_from_catalog_commit(self):
        revision = "a" * 40
        source = (THEMES / "main.lua").read_bytes()
        requests = []
        def fake_download(url, **kwargs):
            requests.append(url)
            if "/commits/" in url:
                return {"sha": revision}
            if "main.lua?" in url:
                return source
            return (THEMES / "teal1.5.png").read_bytes()
        with patch("core.download", side_effect=fake_download):
            catalog = Catalog.from_github()
            catalog.files(["Teal"])
        self.assertTrue(all(f"ref={revision}" in url for url in requests[1:]))


class InstallerTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        (self.root / "radio.bin").write_bytes(b"radio settings")
        (self.root / "models").mkdir()
        (self.root / "models/model.bin").write_bytes(b"my model")
        self.files = Catalog.from_folder(THEMES).files(["Teal", "SilvFlm"])

    def original_themes(self):
        target = self.root / "scripts/Themes"
        target.mkdir(parents=True)
        (target / "main.lua").write_text("original themes")
        (target / "main.luac").write_bytes(b"old compiled code")
        return target

    def test_update_deletes_old_package_and_preserves_unrelated_radio_data(self):
        target = self.original_themes()
        other = self.root / "scripts/Telemetry"
        other.mkdir()
        (other / "main.lua").write_text("return {}")
        (target / "removed-image.png").write_bytes(b"obsolete image")
        self.assertIsNone(install(self.root, self.files))
        self.assertFalse((self.root / "theme-backups").exists())
        self.assertFalse(list(self.root.glob(".theme-replacing-*")))
        self.assertFalse((target / "removed-image.png").exists())
        self.assertFalse((target / "main.luac").exists())
        self.assertEqual((target / "main.lua").read_bytes(), self.files["main.lua"])
        self.assertEqual((self.root / "radio.bin").read_bytes(), b"radio settings")
        self.assertEqual((self.root / "models/model.bin").read_bytes(), b"my model")
        self.assertEqual((other / "main.lua").read_text(), "return {}")

    def test_new_install_without_backup(self):
        self.assertIsNone(install(self.root, self.files))
        self.assertTrue((self.root / "scripts/Themes/updater.json").is_file())

    def test_wrong_root_rejected_without_writes(self):
        (self.root / "radio.bin").unlink()
        with self.assertRaises(ValueError):
            install(self.root, self.files)
        self.assertFalse((self.root / "scripts").exists())

    def test_disconnect_during_staging_keeps_original(self):
        target = self.original_themes()
        with patch("core.os.fsync", side_effect=OSError("USB disconnected")):
            with self.assertRaises(OSError):
                install(self.root, self.files)
        self.assertEqual((target / "main.lua").read_text(), "original themes")
        self.assertEqual(list((self.root / "scripts").iterdir()), [target])

    def test_activation_failure_restores_original(self):
        target = self.original_themes()
        rename = Path.rename
        def fail_activation(path, destination):
            if path.name.startswith(".theme-install-"):
                raise OSError("Cannot activate")
            return rename(path, destination)
        with patch.object(Path, "rename", fail_activation):
            with self.assertRaises(OSError):
                install(self.root, self.files)
        self.assertEqual((target / "main.lua").read_text(), "original themes")
        self.assertFalse(list(self.root.glob(".theme-replacing-*")))

    def test_deletion_failure_reports_that_new_package_is_active(self):
        self.original_themes()
        with patch("core.remove_install_folder", side_effect=OSError("USB disconnected")):
            with self.assertRaisesRegex(OSError, "New themes are installed"):
                install(self.root, self.files)
        self.assertEqual((self.root / "scripts/Themes/main.lua").read_bytes(), self.files["main.lua"])

    def test_removal_rejects_paths_outside_install_root(self):
        from core import remove_install_folder
        with self.assertRaises(ValueError):
            remove_install_folder(self.root / "models", self.root, ".theme-replacing-")
        self.assertTrue((self.root / "models/model.bin").exists())

    def test_duplicate_themes_elsewhere_rejected(self):
        other = self.root / "scripts/OldThemes"
        other.mkdir(parents=True)
        (other / "main.lua").write_bytes(self.files["main.lua"])
        with self.assertRaisesRegex(ValueError, "Duplicate themes"):
            install(self.root, self.files)
        self.assertFalse((self.root / "scripts/Themes").exists())


if __name__ == "__main__":
    unittest.main()
