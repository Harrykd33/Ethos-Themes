from pathlib import Path
import sys
import unittest
from PIL import Image, ImageColor

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from core import Catalog
from preview import ThemePreview

ROOT = Path(__file__).resolve().parents[2]


class PreviewTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.themes = {theme.key: theme for theme in Catalog.from_folder(ROOT / "Themes").themes}

    def test_palette_retains_named_and_grayscale_slots(self):
        dark, teal = self.themes["KvnD"], self.themes["Teal"]
        self.assertEqual(len(dark.colors), 18)
        self.assertEqual(dark.colors[6], "#000000")
        self.assertEqual(dark.colors[8], "#00ffa3")
        self.assertEqual(teal.colors[6], "#606060")
        self.assertEqual(teal.colors[17], "#ffffff")

    def test_both_screens_change_with_theme_and_preserve_source(self):
        for mode, filename in [("Dashboard", "preview-dashboard.png"), ("Model menu", "preview-model-menu.png")]:
            with self.subTest(mode=mode), Image.open(ROOT / "updater/assets" / filename) as source:
                original = source.tobytes()
                renderer = ThemePreview(source, mode)
                dark = renderer.render(self.themes["KvnD"].colors)
                light = renderer.render(self.themes["Teal"].colors)
                self.assertNotEqual(dark.tobytes(), light.tobytes())
                self.assertEqual(source.tobytes(), original)
                self.assertEqual(dark.size, source.size)
                self.assertEqual(dark.getchannel("A").tobytes(), source.getchannel("A").tobytes())

    def test_background_and_safety_gauge_use_correct_roles(self):
        with Image.open(ROOT / "updater/assets/preview-dashboard.png") as source:
            renderer = ThemePreview(source, "Dashboard")
            colors = self.themes["KvnD"].colors
            result = renderer.render(colors)
            self.assertEqual(result.getpixel((10, 100))[:3], ImageColor.getrgb(colors[5]))
            self.assertEqual(result.getpixel((35, 480))[:3], ImageColor.getrgb(colors[8]))


if __name__ == "__main__":
    unittest.main()
