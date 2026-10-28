param([switch]$Dark)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
$root = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
$themeName = 'SAB IL Piuma'; $headerColor = '#EEF1F4'; $pageColor = '#EEF1F4'
$textColor = '#304253'; $panelColor = '#DCE2E9'; $accentColor = '#135BA4'
$borderColor = '#154D80'; $inverseColor = '#FFFFFF'
$headerFile = 'header-sab-il-piuma.png'; $previewFile = 'sab-il-piuma.png'
if ($Dark) {
    $themeName = 'SAB IL Piuma Dark'; $headerColor = '#292F37'; $pageColor = '#292F37'
    $textColor = '#F1F5FA'; $panelColor = '#3A4552'; $accentColor = '#FF8A24'
    $borderColor = '#E8EEF5'; $inverseColor = '#292D33'
    $headerFile = 'header-sab-il-piuma-dark.png'; $previewFile = 'sab-il-piuma-dark.png'
}
$artFile = 'previews/sab-il-piuma-cutout.png'
$art = [Drawing.Bitmap]::new((Join-Path $root $artFile))
# Find visible artwork bounds, retaining all rotor and landing gear details.
$left = $art.Width; $top = $art.Height; $right = 0; $bottom = 0
for ($y = 0; $y -lt $art.Height; $y++) {
    for ($x = 0; $x -lt $art.Width; $x++) {
        if ($art.GetPixel($x, $y).A -gt 32) {
            $left = [Math]::Min($left, $x); $right = [Math]::Max($right, $x)
            $top = [Math]::Min($top, $y); $bottom = [Math]::Max($bottom, $y)
        }
    }
}
# Opaque RGB avoids the reduced color precision used for alpha bitmaps in Ethos.
$header = [Drawing.Bitmap]::new(784, 50, [Drawing.Imaging.PixelFormat]::Format24bppRgb)
$g = [Drawing.Graphics]::FromImage($header)
$g.Clear([Drawing.ColorTranslator]::FromHtml($headerColor))
$g.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$source = [Drawing.Rectangle]::new($left, $top, ($right - $left + 1), ($bottom - $top + 1))
$width = [int][Math]::Round(44 * $source.Width / $source.Height)
$g.DrawImage($art, [Drawing.Rectangle]::new([int]((784 - $width) / 2), 1, $width, 44), $source, [Drawing.GraphicsUnit]::Pixel)
$red = [Drawing.SolidBrush]::new([Drawing.ColorTranslator]::FromHtml($accentColor))
$blue = [Drawing.SolidBrush]::new([Drawing.ColorTranslator]::FromHtml('#1577D2'))
$orange = [Drawing.SolidBrush]::new([Drawing.ColorTranslator]::FromHtml('#FF8A24'))
$g.FillRectangle($blue, 0, 47, 392, 3)
$g.FillRectangle($orange, 392, 47, 392, 3)
$header.Save((Join-Path $root ('Themes/' + $headerFile)), [Drawing.Imaging.ImageFormat]::Png)

# Palette/layout preview; the battery illustrates the actual theme border color.
$preview = [Drawing.Bitmap]::new(784, 294)
$pg = [Drawing.Graphics]::FromImage($preview)
$pg.Clear([Drawing.ColorTranslator]::FromHtml($pageColor))
$pg.DrawImageUnscaled($header, 0, 0)
$font = [Drawing.Font]::new('Arial', 15, [Drawing.FontStyle]::Bold)
$small = [Drawing.Font]::new('Arial', 11)
$text = [Drawing.SolidBrush]::new([Drawing.ColorTranslator]::FromHtml($textColor))
$panel = [Drawing.SolidBrush]::new([Drawing.ColorTranslator]::FromHtml($panelColor))
$border = [Drawing.Pen]::new([Drawing.ColorTranslator]::FromHtml($borderColor), 3)
$pg.DrawString($themeName, $font, $text, 18, 72)
$pg.FillRectangle($panel, 18, 112, 354, 130)
$pg.DrawString('MODEL SETTINGS', $small, $red, 32, 128)
$pg.DrawString('Rotor speed: 2,150 rpm', $font, $text, 32, 164)
$pg.DrawString('Flight mode: Normal', $small, $text, 32, 204)
$pg.FillRectangle($red, 394, 112, 370, 46)
$inverse = [Drawing.SolidBrush]::new([Drawing.ColorTranslator]::FromHtml($inverseColor))
$pg.DrawString('Selected control', $font, $inverse, 412, 122)
$pg.DrawString('Battery border', $small, $text, 412, 192)
$battery = [Drawing.SolidBrush]::new([Drawing.ColorTranslator]::FromHtml('#8ED99C'))
$pg.FillRectangle($battery, 742, 16, 25, 13)
$pg.DrawRectangle($border, 740, 14, 29, 17)
$pg.DrawRectangle($border, 770, 19, 3, 7)
$pg.DrawString('PREVIEW', $small, $text, 18, 267)
$preview.Save((Join-Path $root ('previews/' + $previewFile)), [Drawing.Imaging.ImageFormat]::Png)
foreach ($item in @($blue, $orange, $inverse, $battery, $border, $panel, $text, $small, $font, $pg, $preview, $red, $g, $header, $art)) { $item.Dispose() }
Write-Output "Rendered $themeName header and preview."
