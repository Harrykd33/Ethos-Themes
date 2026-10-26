from dataclasses import asdict
import io
import json
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch
import zipfile

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from core import install
from packages import ScriptPackage, WIZARD, parse_catalog, remote_packages, discover_package, unpack_source, package_files

PACKAGE = ScriptPackage("Example", "owner/example", "scripts/demo", "demo", "stable")


def source_zip(extra=None):
    files = {"owner-example-123/README.md": b"repository readme",
             "owner-example-123/scripts/demo/main.lua": b"return {}",
             "owner-example-123/scripts/demo/lib/helper.lua": b"helper",
             "owner-example-123/scripts/demo/main.luac": b"stale"}
    files.update(extra or {})
    data = io.BytesIO()
    with zipfile.ZipFile(data, "w") as archive:
        for name, content in files.items():
            archive.writestr(name, content)
    return data.getvalue()


class PackageTests(unittest.TestCase):
    def test_catalog_additions_are_data_driven(self):
        document = {"schema_version": 1, "packages": [asdict(WIZARD), asdict(PACKAGE)]}
        self.assertEqual(parse_catalog(json.dumps(document)), [WIZARD, PACKAGE])

    def test_catalog_rejects_conflicts_and_reserved_folders(self):
        for item in [asdict(PACKAGE), {**asdict(PACKAGE), "repository": "another/repo"}, {**asdict(PACKAGE), "folder": "../models"}, {**asdict(PACKAGE), "folder": "Themes"}]:
            with self.subTest(item=item), self.assertRaises(ValueError):
                parse_catalog({"schema_version": 1, "packages": [asdict(PACKAGE), item]})

    def test_remote_catalog_is_only_from_owner_repository_and_pinned(self):
        revision = "a" * 40
        def fake_download(url, **kwargs):
            self.assertTrue(url.startswith("https://api.github.com/repos/Harrykd33/Ethos-Themes/"))
            if "/commits/main" in url:
                return {"sha": revision}
            self.assertIn(f"script-packages.json?ref={revision}", url)
            return json.dumps({"schema_version": 1, "packages": [asdict(PACKAGE)]}).encode()
        with patch("packages.download", side_effect=fake_download):
            self.assertEqual(remote_packages(), [PACKAGE])

    def test_author_helper_reads_manifest_and_default_branch(self):
        def fake_download(url, **kwargs):
            if url.endswith("/owner/example"):
                return {"default_branch": "stable"}
            if "/commits/" in url:
                return {"sha": "a" * 40}
            if "ethos_lua_manifest" in url:
                return json.dumps({"folder": "scripts/demo", "name": "Example"}).encode()
            self.assertIn("scripts/demo/main.lua?ref=", url)
            return b"return {}"
        with patch("packages.download", side_effect=fake_download):
            self.assertEqual(discover_package("https://github.com/owner/example"), PACKAGE)

    def test_source_archive_copies_only_selected_folder(self):
        files = unpack_source(source_zip(), PACKAGE, "revision")
        self.assertEqual(set(files), {"main.lua", "lib/helper.lua", "updater.json"})

    def test_source_archive_rejects_traversal_and_case_duplicates(self):
        for name in ["owner-example-123/scripts/demo/../bad.lua", "owner-example-123/scripts/demo/MAIN.lua"]:
            with self.subTest(name=name), self.assertRaises(ValueError):
                unpack_source(source_zip({name: b"bad"}), PACKAGE, "revision")

    def test_custom_package_download_and_install_keeps_themes(self):
        revision = "a" * 40
        def fake_download(url, **kwargs):
            if "/commits/stable" in url:
                return {"sha": revision}
            self.assertTrue(url.endswith("/zipball/" + revision))
            return source_zip()
        with patch("packages.download", side_effect=fake_download):
            files = package_files(PACKAGE)
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            (root / "models").mkdir()
            (root / "radio.bin").write_bytes(b"radio")
            themes = root / "scripts/Themes"
            themes.mkdir(parents=True)
            (themes / "main.lua").write_bytes(b"unchanged")
            install(root, files, folder=PACKAGE.folder)
            self.assertEqual((root / "scripts/demo/lib/helper.lua").read_bytes(), b"helper")
            self.assertEqual((themes / "main.lua").read_bytes(), b"unchanged")
            self.assertFalse((root / "theme-backups").exists())
