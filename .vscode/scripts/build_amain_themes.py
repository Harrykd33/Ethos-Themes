"""Build four AMain themes, opaque toolbar headers, and a comparison preview.

Logo source: https://www.amainhobbies.com/content/skins/amainhobbies/images/site-logo.png
Transparent logo variants are composited directly onto each header. Dark
variants use the white-outlined logo; light variants use the plain cutout.
"""
import json
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[2]
SLOTS = ['PRIMARY_COLOR', 'SECONDARY_BGCOLOR', 'HIGHLIGHT_COLOR',
         'HIGHLIGHT_INVERT_COLOR', 'DISABLE_COLOR', 'PRIMARY_BGCOLOR',
         'OVERLAY_COLOR', 'SECONDARY_COLOR', 'SAFE_COLOR', 'PAGE_BGCOLOR',
         'ERROR_COLOR', 'ACTIVE_COLOR', 'INACTIVE_COLOR',
         'BUTTON_BORDER_ACTIVE_COLOR', 'BUTTON_BORDER_COLOR', 'WARNING_COLOR',
         'SAFE_CONTRASTING_COLOR', 'TOPLCD_BGCOLOR']

THEMES = [
    dict(name='AMain Carbon Dark', key='AMnCD', slug='amain-carbon-dark', dark=True,
         colors=('F7FAFC 293744 FF681B 172A35 8799AA 131C25 000000 F87418 '
                 '326C96 131C25 B73D4B FF681B 91A4B7 F87418 F87418 986000 '
                 'F7FAFC 131C25').split()),
    dict(name='AMain Cobalt Dark', key='AMnBD', slug='amain-cobalt-dark', dark=True,
         colors=('FFFFFF 183C68 FF771F 102940 8BA8C9 091D3B 000000 F87418 '
                 '2F6387 091D3B B73D4B 479DFF 9AB6D8 F87418 F87418 986000 '
                 'FFFFFF 091D3B').split()),
    dict(name='AMain Orange Light', key='AMnOL', slug='amain-orange-light', dark=False,
         colors=('172A35 DCE3E8 FF681B 172A35 73818C F1F4F6 677886 F87418 '
                 'A2D2F0 F1F4F6 F58C91 D94A00 657687 F87418 F87418 F2BA59 '
                 '172A35 F1F4F6').split()),
    dict(name='AMain Blue Light', key='AMnBL', slug='amain-blue-light', dark=False,
         colors=('102940 D4E5F5 0756AC FFFFFF 6E88A0 F4F9FE 6684A0 F87418 '
                 'ADD9F5 F4F9FE F58C91 0756AC 5D7793 F87418 F87418 F2BA59 '
                 '102940 F4F9FE').split()),
]


def color(hex_value):
    return tuple(bytes.fromhex(hex_value))


def font(size, bold=False):
    return ImageFont.truetype('C:/Windows/Fonts/segoeuib.ttf' if bold
                              else 'C:/Windows/Fonts/segoeui.ttf', size)


def header(theme, logo):
    c = theme['colors']
    image = Image.new('RGB', (784, 50), color(c[5]))
    draw = ImageDraw.Draw(image)
    # The artwork already contains its alpha and, for dark themes, white stroke.
    mark = logo.copy()
    mark.thumbnail((170, 40), Image.Resampling.LANCZOS)
    x, y = (784 - mark.width) // 2, (46 - mark.height) // 2
    image.paste(mark, (x, y), mark)
    # Orange, white, cobalt and navy racing trim follows the second reference.
    for left, right, hex_value in [(0, 312, 'FF681B'), (312, 392, 'FFFFFF'),
                                    (392, 704, '0756AC'), (704, 784, '172A35')]:
        draw.rectangle((left, 47, right - 1, 49), fill=color(hex_value))
    image.save(ROOT / 'Themes' / theme['header'])
    return image


def preview(theme, toolbar):
    c = theme['colors']
    image = Image.new('RGB', (784, 360), color(c[5]))
    image.paste(toolbar, (0, 0))
    draw = ImageDraw.Draw(image)
    draw.text((18, 62), theme['name'], font=font(22, True), fill=color(c[0]))
    draw.rounded_rectangle((18, 105, 365, 324), radius=9, fill=color(c[1]))
    draw.text((34, 121), 'MODEL SETTINGS', font=font(16, True), fill=color(c[7]))
    draw.text((34, 159), 'Rotor speed     2,150 rpm', font=font(21), fill=color(c[0]))
    draw.text((34, 204), 'Flight mode: Normal', font=font(18), fill=color(c[0]))
    draw.rounded_rectangle((34, 252, 348, 299), radius=6, fill=color(c[2]))
    draw.text((49, 261), 'Selected control', font=font(20, True), fill=color(c[3]))
    draw.text((391, 108), 'BATTERY / NORMAL', font=font(15, True), fill=color(c[7]))
    draw.rectangle((391, 141, 754, 216), fill=color(c[8]), outline=color(c[7]), width=4)
    draw.rectangle((754, 164, 763, 192), fill=color(c[7]))
    draw.text((405, 147), '25.2v / 4.20v (6S)', font=font(23), fill=color(c[0]))
    draw.text((405, 178), '100%                 0 mah', font=font(23), fill=color(c[0]))
    for x, slot, label in [(391, 15, 'WARNING'), (580, 10, 'CRITICAL')]:
        draw.rectangle((x, 242, x + 174, 297), fill=color(c[slot]),
                       outline=color(c[7]), width=3)
        draw.text((x + 12, 257), label, font=font(16, True), fill=color(c[0]))
    draw.text((391, 314), 'Orange / cobalt / silver / charcoal', font=font(16), fill=color(c[0]))
    # The toolbar transmitter battery uses the theme's active border color.
    draw.rectangle((584, 7, 632, 34), fill=color(c[8]), outline=color(c[13]), width=3)
    draw.rectangle((633, 15, 638, 26), fill=color(c[13]))
    image.save(ROOT / 'previews' / (theme['slug'] + '.png'))
    return image


def build():
    logos = {}
    for dark, filename in [(False, 'amain-logo-transparent.png'),
                           (True, 'amain-logo-white-outline.png')]:
        with Image.open(ROOT / 'previews' / filename) as source:
            logo = source.convert('RGBA')
            logos[dark] = logo.crop(logo.getchannel('A').getbbox())
    blocks, previews = [], []
    for theme in THEMES:
        theme['header'] = 'header-' + theme['slug'] + '.png'
        previews.append(preview(theme, header(theme, logos[theme['dark']])))
        lines = ['    system.registerTheme({', f'        key = "{theme["key"]}",',
                 f'        name = "{theme["name"]}",',
                 '        -- studio-branding: AMain',
                 f'        darkMode = {str(theme["dark"]).lower()},',
                 '        roundButtons = true,', '        focusStyle = "invert",',
                 '        borderWidth = 3,', '        colors = {']
        for hex_value, slot in zip(theme['colors'], SLOTS):
            rgb = ', '.join('0x' + hex_value[i:i + 2] for i in (0, 2, 4))
            lines.append(f'            lcd.RGB({rgb}), -- {slot}')
        lines += ['        },', f'        toolbarBackground = lcd.loadBitmap("{theme["header"]}"),',
                  '        toolbarLogo = "none",', '    })']
        blocks.append('\n'.join(lines))
    path = ROOT / 'Themes/main.lua'
    text = path.read_text(encoding='utf-8')
    start_marker, end_marker = '    -- BEGIN AMAIN THEMES', '    -- END AMAIN THEMES'
    if start_marker in text:
        start = text.index(start_marker)
        end = text.index(end_marker, start) + len(end_marker)
        text = text[:start] + text[end:]
    offset = text.rindex('\nend\n')
    text = (text[:offset].rstrip() + '\n\n' + start_marker + '\n' +
            '\n\n'.join(blocks) + '\n' + end_marker + '\n' + text[offset:])
    path.write_text(text, encoding='utf-8', newline='\n')
    sheet = Image.new('RGB', (1568, 720))
    for i, image in enumerate(previews):
        sheet.paste(image, (i % 2 * 784, i // 2 * 360))
    sheet.save(ROOT / 'previews/amain-themes.png')
    (ROOT / 'previews/amain-palettes.json').write_text(json.dumps(THEMES, indent=2) + '\n')
    print('Built two dark and two light AMain themes, headers, and previews.')


if __name__ == '__main__':
    build()
