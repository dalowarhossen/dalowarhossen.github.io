# Generates the social share image, favicons and app icons.
# Run from the project root:  powershell -ExecutionPolicy Bypass -File tools/make-images.ps1
Add-Type -AssemblyName System.Drawing

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$imgDir = Join-Path $root 'assets\img'
New-Item -ItemType Directory -Force -Path $imgDir | Out-Null

function C([string]$hex) { [System.Drawing.ColorTranslator]::FromHtml($hex) }

function New-RoundPath([int]$x, [int]$y, [int]$w, [int]$h, [int]$r) {
  $p = New-Object System.Drawing.Drawing2D.GraphicsPath
  $d = $r * 2
  $p.AddArc($x, $y, $d, $d, 180, 90)
  $p.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
  $p.AddArc($x + $w - $d, $y + $h - $d, $d, $d, 0, 90)
  $p.AddArc($x, $y + $h - $d, $d, $d, 90, 90)
  $p.CloseFigure()
  return $p
}

function New-Graphics([System.Drawing.Bitmap]$bmp) {
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  return $g
}

function F([int]$px, [string]$style = 'Regular') {
  return New-Object System.Drawing.Font('Segoe UI', $px, [System.Drawing.FontStyle]::$style, [System.Drawing.GraphicsUnit]::Pixel)
}

# ---------------------------------------------------------------------------
# 1. Open Graph image - 1200 x 630
# ---------------------------------------------------------------------------
$bmp = New-Object System.Drawing.Bitmap 1200, 630
$g = New-Graphics $bmp
$g.Clear((C '#F6F3EC'))

# dot grid
$dot = New-Object System.Drawing.SolidBrush (C '#E4DED0')
for ($x = 24; $x -lt 1200; $x += 26) {
  for ($y = 24; $y -lt 630; $y += 26) { $g.FillEllipse($dot, $x, $y, 2, 2) }
}
$dot.Dispose()

# left accent bar
$accent = C '#A83C17'
$g.FillRectangle((New-Object System.Drawing.SolidBrush $accent), 0, 0, 12, 630)

# top-left label
$inkFaint = C '#7A7468'
$g.DrawString('SEO EXECUTIVE  /  CHITTAGONG, BANGLADESH', (F 19), (New-Object System.Drawing.SolidBrush $inkFaint), 78, 74)

# monogram tile, top right
$tile = New-RoundPath 1030 58 104 104 26
$g.FillPath((New-Object System.Drawing.SolidBrush (C '#14120F')), $tile)
$sfCentre = New-Object System.Drawing.StringFormat
$sfCentre.Alignment = [System.Drawing.StringAlignment]::Center
$sfCentre.LineAlignment = [System.Drawing.StringAlignment]::Center
$g.DrawString('DS', (F 36 'Bold'), (New-Object System.Drawing.SolidBrush (C '#F6F3EC')), (New-Object System.Drawing.RectangleF 1030, 58, 104, 104), $sfCentre)
$tile.Dispose()

# name
$ink = New-Object System.Drawing.SolidBrush (C '#14120F')
$g.DrawString('Dalowar', (F 96 'Bold'), $ink, 74, 158)
$g.DrawString('Hossen Sabuj', (F 96 'Bold'), $ink, 74, 262)

# accent rule + role
$g.FillRectangle((New-Object System.Drawing.SolidBrush $accent), 78, 396, 74, 5)
$g.DrawString('Keyword research  /  Link building  /  SEO reporting', (F 27), (New-Object System.Drawing.SolidBrush (C '#4B463D')), 78, 430)

# bottom line
$g.DrawString('dalowarhossen.github.io', (F 24 'Bold'), (New-Object System.Drawing.SolidBrush (C '#14120F')), 78, 540)
$sfRight = New-Object System.Drawing.StringFormat
$sfRight.Alignment = [System.Drawing.StringAlignment]::Far
$g.DrawString('LinkedIn  /  GitHub  /  Email', (F 22), (New-Object System.Drawing.SolidBrush $inkFaint), (New-Object System.Drawing.RectangleF 400, 540, 722, 40), $sfRight)

$g.Dispose()
$bmp.Save((Join-Path $imgDir 'og-image.png'), [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()

# ---------------------------------------------------------------------------
# 2. App icons
# ---------------------------------------------------------------------------
function New-Icon([int]$size, [string]$file, [double]$radiusRatio = 0.22, [int]$fontSize = 0) {
  $bmp = New-Object System.Drawing.Bitmap $size, $size
  $g = New-Graphics $bmp
  $g.Clear([System.Drawing.Color]::Transparent)
  $r = [int][math]::Round($size * $radiusRatio)
  $path = New-RoundPath 0 0 ($size - 1) ($size - 1) $r
  $g.FillPath((New-Object System.Drawing.SolidBrush (C '#14120F')), $path)
  if ($fontSize -le 0) { $fontSize = [int][math]::Round($size * 0.36) }
  $g.DrawString('DS', (F $fontSize 'Bold'), (New-Object System.Drawing.SolidBrush (C '#F6F3EC')), (New-Object System.Drawing.RectangleF 0, 0, $size, $size), $sfCentre)
  $path.Dispose(); $g.Dispose()
  $bmp.Save((Join-Path $imgDir $file), [System.Drawing.Imaging.ImageFormat]::Png)
  $bmp.Dispose()
}

New-Icon 512 'icon-512.png' 0.22 168
New-Icon 180 'apple-touch-icon.png' 0.22 60
New-Icon 32  'favicon-32.png' 0.24 11

Write-Host 'Images written to assets/img/:'
Get-ChildItem $imgDir | Select-Object Name, @{n = 'KB'; e = { [math]::Round($_.Length / 1KB, 1) } } | Format-Table -AutoSize


