"""Install header sharing for an older RFSuite KevD dashboard (SD scripts root)."""
from pathlib import Path
import argparse
import shutil
ROOT = Path(__file__).resolve().parents[2]

def install(scripts):
    folder = Path(scripts) / 'rfsuite/widgets/dashboard/themes/kevd'
    if not folder.is_dir():
        print('No KevD dashboard installed; skipping header integration.')
        return
    updates = []
    for phase in ('preflight', 'inflight', 'postflight'):
        path = folder / (phase + '.lua')
        text = path.read_text(encoding='utf-8')
        if 'theme_header.lua' in text or 'themes/kevd/header.lua' in text:
            continue
        marker = '        header_boxes_cache = boxes'
        if text.count(marker) != 1:
            raise ValueError(f'Unsupported dashboard layout: {path}; no files changed')
        anchor = 'local colorMode = utils.themeColors()'
        if text.count(anchor) != 1:
            raise ValueError(f'Unsupported theme setup: {path}; no files changed')
        text = text.replace(anchor, anchor+'\nlocal applyThemeHeader = assert(loadfile("SCRIPTS:/rfsuite/widgets/dashboard/themes/kevd/theme_header.lua"))()')
        text = text.replace(marker, '        applyThemeHeader(boxes, colorMode.bgcolor)\n'+marker)
        updates.append((path,text))
    shutil.copy2(ROOT/'Themes/header_bridge.lua', folder/'header_bridge.lua')
    shutil.copy2(ROOT/'integrations/rfsuite/theme_header.lua', folder/'theme_header.lua')
    for path,text in updates:
        backup = path.with_suffix('.lua.before-theme-header')
        if not backup.exists(): shutil.copy2(path,backup)
        path.write_text(text,encoding='utf-8',newline='\n')
        path.with_suffix('.luac').unlink(missing_ok=True)
    print(f'Installed KevD header sharing; updated {len(updates)} pages.')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('scripts',type=Path)
    install(parser.parse_args().scripts)
