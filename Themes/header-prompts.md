# RFsuite theme headers

Created with the built-in image generation tool, using `blueslogo.png` as the
edit reference. Final PNGs are 784 x 50, with the generated logo fitted into
a centered 200 x 46 area on the theme's panel background.

The existing Teal RFs, Pu RFs, Blu Rfs and Yelo Rfs headers are retained.
Every theme loads its bitmap in `main.lua` and sets `toolbarLogo = "none"`.

## Prompt set

The following prompt was used separately for each palette below:

> Edit this RFsuite transmitter toolbar bitmap. Output exactly 784 x 50 pixels;
> preserve original aspect ratio and exact centered RFsuite wordmark and
> helicopter line art positions and shapes. Change only palette: flat background
> {background}, helicopter outline and suite lettering {ink}, RF lettering
> {accent}, final accent {tail}. No additional text, decorations, labels,
> padding or borders. This is the {theme} theme header.

| Theme | File | Background | Ink | Accent | Tail |
| --- | --- | --- | --- | --- | --- |
| KvnD | header-kvnd.png | #1C0F44 | #FFFFFF | #AA66FF | #00FFA3 |
| Ocean | header-ocean.png | #2C4468 | #E8F4FF | #88BBDD | #84C30F |
| Cyberpunk | header-cyberpunk.png | #211B38 | #EAF6FF | #00E5FF | #FF4FD8 |
| Silver Flame | header-silver-flame.png | #D7DEDF | #20282D | #006DB5 | #FF4B19 |
| Porcelain Tide | header-porcelain-tide.png | #D5E8E7 | #16323D | #2159B5 | #20734D |
| Apricot Atelier | header-apricot-atelier.png | #F3D9C8 | #3D2A30 | #873664 | #2C704D |
| Alpine Linen | header-alpine-linen.png | #DDE5D3 | #28362C | #2D6349 | #655930 |
| Ember Obsidian | header-ember-obsidian.png | #362A25 | #FFF0DD | #FFA062 | #DCBC91 |
| Aurora Noir | header-aurora-noir.png | #193532 | #E1FAF2 | #72ECBB | #A3D8ED |
| Velvet Orbit | header-velvet-orbit.png | #362745 | #F7EBFF | #D0AFFF | #EFB4D0 |

Generation can introduce padding or change the canvas size. The exported
headers remove that padding, center the logo without stretching it, and use
the exact background colors above.
