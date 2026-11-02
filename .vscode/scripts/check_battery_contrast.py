"""Audit the colors used by the RFSuite dashboard and Ethos toolbar batteries.

Only normal fill/outline checks are enforced. Warning and critical measurements
are recorded for review; those colors are intentionally left unchanged.
"""
import csv
import re
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[2]


def rendered(rgb):
    """Quantize to Ethos RGB565, then expand to display RGB."""
    r, g, b = rgb
    return ((r >> 3) * 255 / 31, (g >> 2) * 255 / 63, (b >> 3) * 255 / 31)


def luminance(rgb):
    values = [v / 255 for v in rendered(rgb)]
    values = [v / 12.92 if v <= .04045 else ((v + .055) / 1.055) ** 2.4
              for v in values]
    return sum(v * w for v, w in zip(values, (.2126, .7152, .0722)))


def contrast(a, b):
    low, high = sorted((luminance(a), luminance(b)))
    return (high + .05) / (low + .05)


def themes():
    text = (ROOT / 'Themes/main.lua').read_text(encoding='utf-8')
    for block in text.split('system.registerTheme({')[1:]:
        name = re.search(r'name\s*=\s*"([^"]+)"', block)[1]
        colors = []
        for line in re.search(r'colors\s*=\s*{(.*?)}', block, re.S)[1].splitlines():
            match = re.search(r'lcd.RGB\(([^)]+)\)', line)
            if match:
                colors.append(tuple(int(x.strip(), 0) for x in match[1].split(',')))
            elif 'lcd.GREY' in line:
                value = int(re.search(r'lcd.GREY\(([^)]+)\)', line)[1], 0)
                colors.append((value,) * 3)
            elif 'BLACK' in line:
                colors.append((0, 0, 0))
            elif 'WHITE' in line:
                colors.append((255, 255, 255))
        assert len(colors) == 18, (name, len(colors))
        header = re.search(r'loadBitmap\("([^"]+)"', block)[1]
        yield name, colors, header


def check():
    items = list(themes())
    rows = []
    for name, c, header in items:
        # The header artwork is 784 x 50. Sample the toolbar battery footprint,
        # away from the central logo and the decorative bottom palette stripe.
        with Image.open(ROOT / 'Themes' / header) as image:
            pixels = set(image.convert('RGB').crop((580, 2, 646, 34)).get_flattened_data())
        values = {
            'text/fill': contrast(c[0], c[8]),
            'dashboard outline/fill': contrast(c[7], c[8]),
            'toolbar outline/fill': contrast(c[13], c[8]),
            'toolbar outline/artwork': min(contrast(c[13], bg) for bg in pixels),
            'dashboard header outline/background': contrast(c[13], c[9]),
        }
        for label, ratio in values.items():
            assert ratio >= (4.5 if label == 'text/fill' else 3), (name, label, ratio)
        rows.append({'theme': name, 'normal fill': '#%02X%02X%02X' % c[8],
                     **{key: f'{value:.2f}' for key, value in values.items()},
                     'warning text/fill (unchanged)': f'{contrast(c[0], c[15]):.2f}',
                     'critical text/fill (unchanged)': f'{contrast(c[0], c[10]):.2f}'})
    with (ROOT / 'previews/battery-contrast.csv').open('w', newline='', encoding='utf-8') as stream:
        writer = csv.DictWriter(stream, fieldnames=rows[0].keys())
        writer.writeheader()
        writer.writerows(rows)
    preview(items)
    print(f'{len(rows)} themes passed normal battery text, fill/outline, and header outline checks.')
    print('Warning/critical colors are unchanged; their measurements are informational.')


def preview(items):
    width, height = 460, 168
    canvas = Image.new('RGB', (width * 3, height * ((len(items) + 2) // 3)), '#E4E4E4')
    draw = ImageDraw.Draw(canvas)
    font_path = Path('C:/Windows/Fonts/segoeui.ttf')
    title = ImageFont.truetype(str(font_path), 19)
    value = ImageFont.truetype(str(font_path), 22)
    small = ImageFont.truetype(str(font_path), 14)
    for index, (name, c, _) in enumerate(items):
        x, y = index % 3 * width, index // 3 * height
        rgb = lambda i: tuple(round(v) for v in rendered(c[i]))
        draw.rectangle((x + 3, y + 3, x + width - 3, y + height - 3), fill=rgb(5))
        draw.text((x + 15, y + 10), name, fill=rgb(0), font=title)
        rect = (x + 18, y + 48, x + width - 25, y + 113)
        draw.rectangle(rect, fill=rgb(8), outline=rgb(7), width=4)
        draw.rectangle((x + width - 25, y + 68, x + width - 18, y + 94), fill=rgb(7))
        draw.text((x + 29, y + 53), '25.2v / 4.20v (6S)', fill=rgb(0), font=value)
        draw.text((x + 29, y + 80), '100%                    0 mah', fill=rgb(0), font=value)
        note = f'Text {contrast(c[0], c[8]):.1f}:1   Outline {contrast(c[7], c[8]):.1f}:1'
        draw.text((x + 18, y + 127), note, fill=rgb(0), font=small)
    canvas.save(ROOT / 'previews/battery-contrast.png')


if __name__ == '__main__':
    check()
