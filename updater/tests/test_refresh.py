from pathlib import Path
import sys
from types import SimpleNamespace
import unittest
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from app import App


class RefreshTests(unittest.TestCase):
    def run_refresh(self):
        results = []
        app = SimpleNamespace(report=lambda *args: None, run_worker=lambda operation, kind: results.append((kind, operation())))
        App.refresh(app)
        return results[0][1]

    def test_refresh_fetches_both_catalogs(self):
        with patch("app.Catalog.from_github", return_value="themes") as themes, patch("app.remote_packages", return_value="scripts") as scripts:
            result = self.run_refresh()
        self.assertEqual(result, {"themes": "themes", "scripts": "scripts", "errors": []})
        themes.assert_called_once()
        scripts.assert_called_once()

    def test_failed_themes_does_not_skip_script_refresh(self):
        with patch("app.Catalog.from_github", side_effect=ValueError("unavailable")), patch("app.remote_packages", return_value="scripts") as scripts:
            result = self.run_refresh()
        self.assertEqual(result["scripts"], "scripts")
        self.assertIsNone(result["themes"])
        self.assertEqual(len(result["errors"]), 1)
        scripts.assert_called_once()

    def test_failed_scripts_still_returns_updated_themes(self):
        with patch("app.Catalog.from_github", return_value="themes"), patch("app.remote_packages", side_effect=ValueError("catalog unpublished")):
            result = self.run_refresh()
        self.assertEqual(result["themes"], "themes")
        self.assertIsNone(result["scripts"])
        self.assertIn("catalog unpublished", result["errors"][0])
