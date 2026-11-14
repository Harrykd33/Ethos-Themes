"""Rebuild four reference-palette themes using the supplied OMP M5 photo."""
from pathlib import Path
import json
from PIL import Image, ImageDraw
from check_battery_contrast import contrast, themes
from build_studio_previews import render

ROOT = Path(__file__).resolve().parents[2]
SLOTS = ['PRIMARY_COLOR','SECONDARY_BGCOLOR','HIGHLIGHT_COLOR','HIGHLIGHT_INVERT_COLOR','DISABLE_COLOR','PRIMARY_BGCOLOR','OVERLAY_COLOR','SECONDARY_COLOR','SAFE_COLOR','PAGE_BGCOLOR','ERROR_COLOR','ACTIVE_COLOR','INACTIVE_COLOR','BUTTON_BORDER_ACTIVE_COLOR','BUTTON_BORDER_COLOR','WARNING_COLOR','SAFE_CONTRASTING_COLOR','TOPLCD_BGCOLOR']
DATA = [
 ('Vibrant Fest', True, 'FBD071 FC4AA1 322D60 75B2A2', '322D60', '454074', 'FBD071', '211D40', 'FFFFFF', '75B2A2', '534B80'),
 ('Charcoal Silence', True, '48465B 8E7073 A6A5A1 838486 272727', '272727', '48465B', 'DDD2D1', '272727', 'FFFFFF', 'DDD2D1', '8E7073'),
 ('Soft Macaron', False, 'F2EFA4 F8C3A6 D287B5 BDAAD0 EDE8DC', 'EDE8DC', 'F2EFA4', 'BDAAD0', '302B40', '302B40', '694873', 'BDAAD0'),
 ('Blue Ion', True, '36E1ED 28BFEF 2960FA 2824C9 3D109E', '211050', '321877', '36E1ED', '16103C', 'FFFFFF', '36E1ED', '2960FA'),
]

def build():
    source = Image.open(ROOT/'previews/omp-m5-cutout.png').convert('RGBA')
    # Preserve the cutout alpha and all visible rotor, tail and skid details.
    photo = source.crop(source.getbbox())
    photo.thumbnail((100, 46), Image.Resampling.LANCZOS)
    blocks, manifest = [], []
    for i, (name, dark, swatches, bg, panel, accent, inverse, fg, secondary, border) in enumerate(DATA, 1):
        slug = name.lower().replace(' ', '-')
        colors = [fg,panel,accent,inverse,'A6A5B3' if dark else '786B80',bg,'000000',fg,
                  '244E59' if dark else 'C5E5CE',bg,'702C3D' if dark else 'F1B1BE',
                  secondary,'A6A5B3' if dark else '786B80',fg,border,
                  '684000' if dark else 'F8C3A6',fg,bg]
        header = Image.new('RGB',(784,50),'#'+bg)
        header.paste(photo,((784-photo.width)//2,(46-photo.height)//2),photo)
        draw = ImageDraw.Draw(header)
        palette = swatches.split()
        for j, color in enumerate(palette):
            draw.rectangle((j*784//len(palette),47,(j+1)*784//len(palette)-1,49),fill='#'+color)
        header_name = f'header-{slug}.png'
        header.save(ROOT/'Themes'/header_name)
        lines = ['    system.registerTheme({', f'        key = "OMPP{i}",',f'        name = "{name}",',f'        -- studio-branding: {name}',f'        -- studio-preview: previews/{slug}.png',f'        darkMode = {str(dark).lower()},','        roundButtons = true,','        focusStyle = "invert",','        borderWidth = 3,','        colors = {']
        for color, slot in zip(colors,SLOTS):
            lines.append('            lcd.RGB('+', '.join('0x'+color[j:j+2] for j in (0,2,4))+f'), -- {slot}')
        lines += ['        },',f'        toolbarBackground = lcd.loadBitmap("{header_name}"),','        toolbarLogo = "none",','    })']
        blocks.append('\n'.join(lines))
        rgb = [tuple(bytes.fromhex(c)) for c in colors]
        # Audit Ethos RGB565 colors, actual header pixels at the battery,
        # and normal/warning/critical text plus both outline/detail slots.
        ratios = {}
        pixels = set(header.crop((580,2,646,34)).get_flattened_data())
        ratios['header outline'] = min(contrast(rgb[13],p) for p in pixels)
        for label, slot in [('normal',8),('warning',15),('critical',10)]:
            for detail in (0,7,13,16):
                ratio = contrast(rgb[detail],rgb[slot])
                assert ratio >= 4.5, (name,label,detail,ratio)
                ratios[f'{label} detail {SLOTS[detail]}'] = round(ratio,2)
        assert ratios['header outline'] >= 3
        render(name,rgb,header_name,ROOT/f'previews/{slug}.png')
        manifest.append(dict(name=name,palette=palette,colors=colors,battery_contrast=ratios))
    path = ROOT/'Themes/main.lua'
    text = path.read_text(encoding='utf-8')
    begin, end = '    -- BEGIN OMP PALETTE THEMES','    -- END OMP PALETTE THEMES'
    if begin in text:
        start = text.index(begin)
        stop = text.index(end,start)+len(end)
        text = text[:start]+text[stop:]
    offset = text.rindex('\nend\n')
    text = text[:offset].rstrip()+'\n\n'+begin+'\n'+'\n\n'.join(blocks)+'\n'+end+'\n'+text[offset:]
    path.write_text(text,encoding='utf-8',newline='\n')
    (ROOT/'previews/omp-palettes.json').write_text(json.dumps(manifest,indent=2)+'\n')
    sheet = Image.new('RGB',(1568,720))
    for i,item in enumerate(manifest):
        with Image.open(ROOT/('previews/'+item['name'].lower().replace(' ','-')+'.png')) as im:
            sheet.paste(im,(i%2*784,i//2*360))
    sheet.save(ROOT/'previews/omp-palette-themes.png')
    print('Built four themes; normal, warning, critical and actual header battery contrast checks passed.')

if __name__ == '__main__':
    build()
