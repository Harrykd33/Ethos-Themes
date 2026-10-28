$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
$root = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
$themes = Get-Content -LiteralPath (Join-Path $root 'previews/rc-pilot-palettes.json') -Raw | ConvertFrom-Json
$art = [Drawing.Image]::FromFile((Join-Path $root 'previews/rc-pilot-header-cutout.png'))
function Brush($hex) { return [Drawing.SolidBrush]::new([Drawing.ColorTranslator]::FromHtml("#$hex")) }
$font = [Drawing.Font]::new('Arial', 15, [Drawing.FontStyle]::Bold)
$title = [Drawing.Font]::new('Arial', 16, [Drawing.FontStyle]::Bold)
$small = [Drawing.Font]::new('Arial', 11)
$preview = [Drawing.Bitmap]::new(1620, 1080)
$pg = [Drawing.Graphics]::FromImage($preview)
$pg.Clear([Drawing.Color]::FromArgb(18, 22, 30))
$pg.DrawString('RC PILOT / 8 PALETTE THEMES', $title, [Drawing.Brushes]::White, 20, 12)
for ($i = 0; $i -lt $themes.Count; $i++) {
    $t = $themes[$i]
    $header = [Drawing.Bitmap]::new(784, 50)
    $g = [Drawing.Graphics]::FromImage($header)
    $background = [Drawing.Drawing2D.LinearGradientBrush]::new(
        [Drawing.Rectangle]::new(0, 0, 784, 46),
        [Drawing.ColorTranslator]::FromHtml('#' + $t.colors[5]),
        [Drawing.ColorTranslator]::FromHtml('#' + $t.colors[1]),
        [Drawing.Drawing2D.LinearGradientMode]::Horizontal)
    $g.FillRectangle($background, 0, 0, 784, 46)
    $background.Dispose()
    $g.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    # Center the transparent artwork with no header text.
    $artWidth = [int][Math]::Round(46 * $art.Width / $art.Height)
    $g.DrawImage($art, [Drawing.Rectangle]::new([int]((784 - $artWidth) / 2), 0, $artWidth, 46))
    for ($p = 0; $p -lt $t.palette.Count; $p++) {
        $left = [int][Math]::Floor($p * 784 / $t.palette.Count)
        $right = [int][Math]::Floor(($p + 1) * 784 / $t.palette.Count)
        $b = Brush $t.palette[$p]
        $g.FillRectangle($b, $left, 46, ($right - $left), 4)
        $b.Dispose()
    }
    $header.Save((Join-Path $root ('Themes/' + $t.header)), [Drawing.Imaging.ImageFormat]::Png)
    $x = 20 + ($i % 2) * 800
    $y = 54 + [int][Math]::Floor($i / 2) * 254
    $pg.DrawString($t.name, $title, [Drawing.Brushes]::White, $x, $y)
    $pg.DrawImageUnscaled($header, $x, ($y + 28))
    $bg = Brush $t.colors[5]; $fg = Brush $t.colors[0]; $panel = Brush $t.colors[1]
    $hi = Brush $t.colors[2]; $inv = Brush $t.colors[3]; $secondary = Brush $t.colors[7]
    $pg.FillRectangle($bg, $x, ($y + 78), 784, 148)
    $pg.FillRectangle($panel, ($x + 14), ($y + 91), 350, 116)
    $pg.DrawString('MODEL SETTINGS', $small, $secondary, ($x + 28), ($y + 102))
    $pg.DrawString('Rotor speed     2,150 rpm', $font, $fg, ($x + 28), ($y + 131))
    $pg.FillRectangle($hi, ($x + 390), ($y + 98), 374, 42)
    $pg.DrawString('Selected control', $font, $inv, ($x + 408), ($y + 107))
    $pg.DrawString('Flight mode: Normal', $small, $secondary, ($x + 408), ($y + 157))
    for ($p = 0; $p -lt $t.palette.Count; $p++) {
        $b = Brush $t.palette[$p]
        $pg.FillRectangle($b, ($x + 408 + $p * 60), ($y + 186), 56, 12)
        $b.Dispose()
    }
    foreach ($b in @($bg, $fg, $panel, $hi, $inv, $secondary)) { $b.Dispose() }
    $g.Dispose(); $header.Dispose()
}
$preview.Save((Join-Path $root 'previews/rc-pilot-themes.png'), [Drawing.Imaging.ImageFormat]::Png)
$pg.Dispose(); $preview.Dispose(); $art.Dispose()
$font.Dispose(); $title.Dispose(); $small.Dispose()
Write-Output 'Rendered 8 headers and theme preview.'
