"""Create missing individual Studio previews and assign them in theme metadata.

Run after adding/rebuilding themes. Existing previews are preserved; --check
validates every assignment without writing. Requires Pillow, like the other
theme builders. These are palette/layout illustrations, not radio screenshots.
"""
import argparse
import re
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

from check_battery_contrast import rendered, themes

ROOT = Path(__file__).resolve().parents[2]
PREVIEW = re.compile(r"(?m)^[ \t]*-- studio-preview:[ \t]*([^\r\n]+)")


def font(size, bold=False):
    filename = 'segoeuib.ttf' if bold else 'segoeui.ttf'
    for directory in (Path('C:/Windows/Fonts'), Path('/usr/share/fonts/truetype/dejavu')):
        path = directory / (filename if directory.name == 'Fonts' else
                            ('DejaVuSans-Bold.ttf' if bold else 'DejaVuSans.ttf'))
        if path.exists():
            return ImageFont.truetype(str(path), size)
    return ImageFont.load_default(size=size)


def render(name, colors, header, destination):
    # Show the same RGB565 palette expansion used by the battery audit.
    c = [tuple(round(v) for v in rendered(rgb)) for rgb in colors]
    image = Image.new('RGB', (784, 360), c[9])
    with Image.open(ROOT / 'Themes' / header) as source:
        image.paste(source.convert('RGB').resize((784, 50)), (0, 0))
    draw = ImageDraw.Draw(image)
    draw.text((18, 62), name.strip(), font=font(23, True), fill=c[0])
    draw.rounded_rectangle((18, 105, 365, 330), radius=9, fill=c[1])
    draw.text((34, 120), 'MODEL SETTINGS', font=font(16, True), fill=c[0])
    draw.text((34, 160), 'Rotor speed    2,150 rpm', font=font(21), fill=c[0])
    draw.text((34, 203), 'Flight mode: Normal', font=font(19), fill=c[0])
    draw.rounded_rectangle((34, 252, 348, 300), radius=6, fill=c[2])
    draw.text((48, 262), 'Selected control', font=font(20, True), fill=c[3])
    draw.text((391, 109), 'BATTERY / NORMAL', font=font(16, True), fill=c[0])
    draw.rectangle((391, 141, 754, 216), fill=c[8], outline=c[7], width=4)
    draw.rectangle((755, 164, 763, 192), fill=c[7])
    draw.text((405, 147), '25.2v / 4.20v (6S)', font=font(23), fill=c[0])
    draw.text((405, 178), '100%                 0 mah', font=font(23), fill=c[0])
    for x, slot, label in ((391, 15, 'WARNING'), (580, 10, 'CRITICAL')):
        draw.rectangle((x, 242, x + 174, 298), fill=c[slot], outline=c[7], width=3)
        draw.text((x + 12, 258), label, font=font(16, True), fill=c[0])
    draw.text((391, 314), 'Theme palette / layout preview', font=font(16), fill=c[0])
    draw.rectangle((584, 7, 632, 34), fill=c[8], outline=c[13], width=3)
    draw.rectangle((633, 15, 638, 26), fill=c[13])
    destination.parent.mkdir(parents=True, exist_ok=True)
    image.save(destination)


def build(check=False):
    path = ROOT / 'Themes/main.lua'
    text = path.read_text(encoding='utf-8')
    blocks = text.split('system.registerTheme({')
    palettes = list(themes())
    if len(blocks) - 1 != len(palettes):
        raise ValueError('Theme/palette count mismatch')
    assigned, created = set(), 0
    for index, (name, colors, header) in enumerate(palettes, 1):
        block = blocks[index]
        match = PREVIEW.search(block)
        preview = match[1].strip() if match else 'previews/' + re.sub(r'^header-', '', header)
        if not re.fullmatch(r'previews/[A-Za-z0-9_-]+\.png', preview):
            raise ValueError(f'{name}: invalid preview path: {preview}')
        if preview.casefold() in assigned:
            raise ValueError(f'{name}: preview assigned more than once: {preview}')
        assigned.add(preview.casefold())
        if not match:
            if check:
                raise ValueError(f'{name}: missing studio-preview metadata')
            block = re.sub(r'(\bname\s*=\s*"[^"\n]+",)',
                           lambda m: m[0] + '\n        -- studio-preview: ' + preview,
                           block, count=1)
            blocks[index] = block
        destination = ROOT / preview
        if not destination.exists():
            if check:
                raise ValueError(f'{name}: missing {preview}')
            render(name, colors, header, destination)
            created += 1
        with Image.open(destination) as image:
            image.verify()
    if not check:
        updated = 'system.registerTheme({'.join(blocks)
        if updated != text:
            path.write_text(updated, encoding='utf-8', newline='\n')
    print(f'{len(palettes)} themes have unique, valid Studio previews; {created} images created.')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true', help='Validate without writing files')
    build(parser.parse_args().check)
