import io
import json
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch
import zipfile

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from core import Catalog, WIZARD_FOLDER, install, unpack_wizard, wizard_files


def archive(extra=None):
    files = {"ethos_lua_manifest.json": json.dumps({"folder": WIZARD_FOLDER, "version": "0.7.5"}).encode()}
    for name in ["main.lua", "lib/register_model_wizard.lua", "app/lib/model_wizard.lua"]:
        files[f"{WIZARD_FOLDER}/{name}"] = b"return {}"
    for name in ["icon.png", "legacy-icon.png"]:
        files[f"{WIZARD_FOLDER}/{name}"] = b"\x89PNG\r\n\x1a\nicon"
    files.update(extra or {})
    stream = io.BytesIO()
    with zipfile.ZipFile(stream, "w") as package:
        for name, data in files.items():
            package.writestr(name, data)
    return stream.getvalue()


class WizardTests(unittest.TestCase):
    def test_package_files_and_commit_pinning(self):
        revision = "a" * 40
        def fake_download(url, **kwargs):
            if "/commits/main" in url:
                return {"sha": revision}
            self.assertIn(f"ref={revision}", url)
            self.assertIn("rotorflight-model-wizard-standalone-en.zip", url)
            return archive()
        with patch("core.download", side_effect=fake_download):
            files = wizard_files()
        self.assertIn("app/lib/model_wizard.lua", files)
        self.assertEqual(json.loads(files["updater.json"])["revision"], revision)

    def test_rejects_paths_outside_package_and_windows_aliases(self):
        for path in ["../evil.lua", "rotorflight-model-wizard/../evil.lua", "other/main.lua", "rotorflight-model-wizard/CON.lua", "rotorflight-model-wizard/C:/evil.lua"]:
            with self.subTest(path=path), self.assertRaises(ValueError):
                unpack_wizard(archive({path: b"bad"}), "test")

    def test_drops_compiled_code(self):
        files = unpack_wizard(archive({f"{WIZARD_FOLDER}/main.luac": b"stale"}), "test")
        self.assertNotIn("main.luac", files)

    def test_wizard_install_update_preserves_themes_models_and_suite(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            (root / "models").mkdir()
            (root / "radio.bin").write_bytes(b"radio")
            (root / "models/model.bin").write_bytes(b"model")
            for name in ["Themes", "rfsuite"]:
                target = root / "scripts" / name
                target.mkdir(parents=True)
                (target / "main.lua").write_bytes(b"unchanged")
            old = root / "scripts" / WIZARD_FOLDER
            old.mkdir()
            (old / "main.luac").write_bytes(b"old")
            (old / "obsolete.lua").write_bytes(b"old")
            files = unpack_wizard(archive(), "test")
            install(root, files, folder=WIZARD_FOLDER)
            self.assertEqual((old / "app/lib/model_wizard.lua").read_bytes(), b"return {}")
            self.assertFalse((old / "main.luac").exists())
            self.assertFalse((old / "obsolete.lua").exists())
            self.assertFalse((root / "theme-backups").exists())
            self.assertFalse(list(root.glob(".theme-replacing-*")))
            for name in ["Themes", "rfsuite"]:
                self.assertEqual((root / "scripts" / name / "main.lua").read_bytes(), b"unchanged")
            self.assertEqual((root / "models/model.bin").read_bytes(), b"model")

    def test_failed_activation_restores_existing_wizard(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            (root / "models").mkdir()
            (root / "radio.bin").write_bytes(b"radio")
            old = root / "scripts" / WIZARD_FOLDER
            old.mkdir(parents=True)
            (old / "main.lua").write_bytes(b"old wizard")
            original = Path.rename
            def fail_stage(path, destination):
                if path.name.startswith(".theme-install-"):
                    raise OSError("USB error")
                return original(path, destination)
            with patch.object(Path, "rename", fail_stage), self.assertRaises(OSError):
                install(root, unpack_wizard(archive(), "test"), folder=WIZARD_FOLDER)
            self.assertEqual((old / "main.lua").read_bytes(), b"old wizard")
