"""Build the RC Pilot registrations and manifest (header rendering uses PowerShell)."""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SLOTS = ['PRIMARY_COLOR', 'SECONDARY_BGCOLOR', 'HIGHLIGHT_COLOR',
         'HIGHLIGHT_INVERT_COLOR', 'DISABLE_COLOR', 'PRIMARY_BGCOLOR',
         'OVERLAY_COLOR', 'SECONDARY_COLOR', 'SAFE_COLOR', 'PAGE_BGCOLOR',
         'ERROR_COLOR', 'ACTIVE_COLOR', 'INACTIVE_COLOR',
         'BUTTON_BORDER_ACTIVE_COLOR', 'BUTTON_BORDER_COLOR', 'WARNING_COLOR',
         'SAFE_CONTRASTING_COLOR', 'TOPLCD_BGCOLOR']

# Palette swatches follow the supplied reference; UI shades preserve legibility.
DATA = [
    ('Rangoli', 'Rangoli Spectrum', True,
     'CC6000 F7C313 ED0B8E A500C5 0C0066',
     'FFF8EB 30205A F7C313 211037 9D8EB7 170D39 FFC9EB 10102B ED0B8E A500C5'),
    ('Electric', 'Electric Freedom', True,
     'CC0000 00CED1 FFFF00 D000F5 0033CC',
     'FFFFFF 14265A 00CED1 061C29 939FC0 091435 B8F4FF 050B22 FFFF00 D000F5'),
    ('Steel', 'Steel Interface', True,
     '4B4B4B C5C5C5 B69D4F 40518C',
     'FFFFFF 40518C B69D4F 171C2B A0A7BD 24262D E6D49A 181B22 C5C5C5 B69D4F'),
    ('Rustic', 'Rustic Twilight', True,
     '494773 CFB59D 855B4B 734B3F 552F23',
     'FFF5E8 494773 CFB59D 2B1914 B8A19B 332019 EAD5C5 241511 CFB59D 855B4B'),
    ('Rainbow', '4 Color Rainbow', True,
     '1009D4 20BC20 F2DE18 FF3025',
     'FFFFFF 242078 F2DE18 17143E 939FC0 10103D FFF2A0 080824 65EB65 FF3025'),
    ('Arctic', 'Blue Arctic Camouflage', True,
     '21194D F5F5F5 7E83AF 515E98 303F7C',
     'F5F5F5 303F7C C5C9EF 21194D 949BC3 21194D DDE1FF 151031 C5C9EF 7E83AF'),
    ('Heritage', 'Heritage Canvas', False,
     '802A1E BC6D1B E8D4C9 37597D 31573D',
     '30231E DDC5B7 37597D FFFFFF 887B70 E8D4C9 802A1E F6EAE2 31573D BC6D1B'),
    ('Steel Day', 'Steel Interface (light variant)', False,
     '4B4B4B C5C5C5 B69D4F 40518C',
     '292C35 C5C5C5 40518C FFFFFF 777B88 EEF0F3 5D4B15 FAFAFB 40518C B69D4F'),
]

def build():
    themes, blocks = [], []
    for i, (label, source, dark, swatches, ui) in enumerate(DATA, 1):
        fg, panel, highlight, inverse, disabled, bg, secondary, page, active, border = ui.split()
        colors = [fg, panel, highlight, inverse, disabled, bg, '000000', secondary,
                  'A4E8B2' if dark else '23613C', page,
                  'FFADB5' if dark else '9C192B', active,
                  'C2C5D5' if dark else '5C606D', highlight, border,
                  'FFD18B' if dark else '754000', '102619' if dark else 'FFFFFF', bg]
        slug = label.lower().replace(' ', '-')
        item = dict(name='RC Pilot ' + label, key=f'RCP{i:02}', source=source,
                    dark=dark, palette=swatches.split(), colors=colors,
                    header=f'header-rc-pilot-{slug}.png')
        themes.append(item)
        lines = [f'    -- {item["name"]}: {source}.', '    system.registerTheme({',
                 f'        key = "{item["key"]}",', f'        name = "{item["name"]}",',
                 f'        darkMode = {str(dark).lower()},', '        roundButtons = true,',
                 '        focusStyle = "invert",', '        borderWidth = 3,', '        colors = {']
        for color, slot in zip(colors, SLOTS):
            rgb = ', '.join('0x' + color[j:j+2] for j in (0, 2, 4))
            lines.append(f'            lcd.RGB({rgb}), -- {slot}')
        lines += ['        },', f'        toolbarBackground = lcd.loadBitmap("{item["header"]}"),',
                  '        toolbarLogo = "none",', '    })']
        blocks.append('\n'.join(lines))
    path = ROOT / 'Themes/main.lua'
    text = path.read_text(encoding='utf-8')
    marker = '    -- BEGIN RC PILOT THEMES'
    if marker in text:
        start = text.index(marker)
        end = text.index('    -- END RC PILOT THEMES', start) + len('    -- END RC PILOT THEMES')
        text = text[:start] + text[end:]
    offset = text.rindex('\nend\n')
    text = text[:offset].rstrip() + '\n\n' + marker + '\n' + '\n\n'.join(blocks) + '\n    -- END RC PILOT THEMES\n' + text[offset:]
    path.write_text(text, encoding='utf-8', newline='\n')
    (ROOT / 'previews/rc-pilot-palettes.json').write_text(json.dumps(themes, indent=2) + '\n')
    print('Built 8 RC Pilot themes and palette manifest.')

if __name__ == '__main__':
    build()
