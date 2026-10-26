from pathlib import Path
import sys
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from core import Catalog, Theme, categorized_themes


class CategoryTests(unittest.TestCase):
    def test_actual_themes_are_partitioned_and_sorted(self):
        themes = Catalog.from_folder(Path(__file__).resolve().parents[2] / "Themes").themes
        dark = categorized_themes(themes, "Dark")
        light = categorized_themes(themes, "Light")
        all_themes = categorized_themes(themes)
        self.assertEqual({t.key for t in dark}, {"KvnD", "Ocean", "CyberPn"})
        self.assertEqual({t.key for t in dark} | {t.key for t in light}, {t.key for t in themes})
        self.assertFalse({t.key for t in dark} & {t.key for t in light})
        self.assertEqual([t.name for t in all_themes], sorted([t.name for t in themes], key=str.casefold))

    def test_explicit_mode_wins_over_brightness_and_comments(self):
        theme = Theme("test", "Test", "-- darkMode = true\nsystem.registerTheme({darkMode=false})", (), ("#000000",) * 18)
        self.assertEqual(theme.category, "Light")

    def test_brightness_fallback(self):
        dark = Theme("test", "Dark", "", (), ("#000000",) * 18)
        light = Theme("test2", "Light", "", (), ("#ffffff",) * 18)
        self.assertEqual(dark.category, "Dark")
        self.assertEqual(light.category, "Light")
