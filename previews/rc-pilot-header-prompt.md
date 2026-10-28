# RC Pilot header artwork

Created with the built-in image_gen tool from `rc pilot.png`. Source illustration
adapted to a horizontal composition; final toolbar assets are resized to fit the
existing 784 x 50 header format, with matching theme backgrounds and palette stripes added by
`.vscode/scripts/build_rc_pilot_headers.ps1`.

## Prompt

Use case: compositing. Asset type: very narrow radio transmitter toolbar artwork.
Adapt this supplied RC pilot and red/white/black helicopter illustration into a
wide horizontal 3:1 banner. Preserve the recognizable original cartoon pilot,
black cap, black helicopter hoodie, handheld transmitter, and same red white
black RC helicopter. Reframe pilot at left as waist-up with controller visible,
helicopter at right, both large and fully readable. Pure black backdrop fading
to pure black at all edges. No text, no added logos, no stripes. Crisp bold
simplified contours to survive display at 46 pixels high. Keep subjects within
central 85% of image. The image will be centered in a 784x50 black toolbar with
empty side margins for radio status icons.

## Transparent cutout revision

Created with the built-in image_gen tool. Saved as `rc-pilot-header-cutout.png`.
The header renderer uses this cutout without any wordmark or header text.

Use case: background-extraction. Edit target: supplied wide RC pilot and
helicopter artwork. Remove only the black backdrop and red atmospheric glow,
replacing with genuine transparency. Preserve the entire cartoon pilot, cap,
black hoodie, hands, controller, and red white black helicopter including rotor
blades, exact horizontal layout and proportions. Keep black pixels within the
subjects opaque. No text, no wordmark, no new elements. Crisp cutout edges.
This cutout will be composited on colored theme toolbar backgrounds.
