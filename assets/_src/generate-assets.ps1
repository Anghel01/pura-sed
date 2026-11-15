# Script integral de generación de componentes vectoriales PuraSed (100% Clean Entities & High Fidelity)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$repoRoot = (Get-Item $PSScriptRoot).Parent.Parent.FullName
$assetsDir = Join-Path $repoRoot "assets"
$teamDir = Join-Path $assetsDir "team"
if (-not (Test-Path $teamDir)) {
    New-Item -ItemType Directory -Path $teamDir | Out-Null
}

Write-Host "Generando recursos vectoriales de alta fidelidad..."

# ==========================================
# 1. GENERACIÓN DE assets/banner.svg (Efervescencia y Espuma Mejorada)
# ==========================================
$bannerJpg = Join-Path $assetsDir "banner.jpg"
if (Test-Path $bannerJpg) {
    Write-Host "Generando assets/banner.svg con efervescencia reforzada..."
    $origBmp = [System.Drawing.Bitmap]::FromFile($bannerJpg)
    $targetW = 1600
    $targetH = 397
    $resized = New-Object System.Drawing.Bitmap $targetW, $targetH
    $g = [System.Drawing.Graphics]::FromImage($resized)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.DrawImage($origBmp, 0, 0, $targetW, $targetH)

    $ms = New-Object System.IO.MemoryStream
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
    $p = New-Object System.Drawing.Imaging.EncoderParameters 1
    $p.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]92)
    $resized.Save($ms, $codec, $p)
    $b64 = [Convert]::ToBase64String($ms.ToArray())

    $g.Dispose()
    $resized.Dispose()
    $origBmp.Dispose()
    $ms.Dispose()

    $bannerSvg = @"
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 1640 420" width="1640" height="420" role="img" aria-labelledby="bannerTitle bannerDesc">
  <title id="bannerTitle">PuraSed &#8212; Bar y Restaurante System</title>
  <desc id="bannerDesc">Plataforma digital para bar nocturno y restaurante: pedidos por mesa, comanda a barra y cocina, y control de jornada.</desc>
  <defs>
    <style>
      svg {
        --card: #FFFFFF;
        --panel: #F3F1EC;
        --ink: #1C1917;
        --muted: #57534E;
        --line: #E2DFD7;
        --frame: #D4D4D8;
        --accent: $lightAccent;
        --chip-bg: #F3F1EC;
      }
      @media (prefers-color-scheme: dark) {
        svg {
          --card: #292826;
          --panel: #2B2A28;
          --ink: #F5F4EF;
          --muted: #B0ADA6;
          --line: #45433F;
          --frame: #444448;
          --accent: $darkAccent;
          --chip-bg: #33322E;
        }
        .ds { flood-color: #000000; flood-opacity: .55; }
      }
      .ds     { flood-color: #18181B; flood-opacity: .12; }
      .card   { fill: var(--card); }
      .panel  { fill: var(--panel); }
      .hole   { fill: var(--card); }
      .frame  { fill: none; stroke: var(--frame); stroke-width: 1.2; }
      .sep    { stroke: var(--line); stroke-width: 1; }
      .rail   { fill: var(--accent); }
      .chip   { fill: var(--chip-bg); stroke: var(--line); stroke-width: 1; }
      .mono-bg { fill: var(--accent); fill-opacity: .14; }
      .ring   { fill: none; stroke: var(--accent); stroke-width: 2.8; }
      .orbit  { fill: none; stroke: var(--accent); stroke-width: 1.6; stroke-dasharray: 2 7; stroke-linecap: round; transform-box: fill-box; transform-origin: center; animation: spin 32s linear infinite; }
      .dot    { fill: var(--accent); transform-box: fill-box; transform-origin: center; animation: pulse 2.6s ease-in-out infinite; }
      .name   { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Inter, Helvetica, sans-serif; font-size: 25px; font-weight: 800; fill: var(--ink); letter-spacing: -0.45px; }
      .role   { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 10.5px; font-weight: 800; letter-spacing: 1.5px; fill: var(--accent); }
      .txt    { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 14px; font-weight: 400; fill: var(--muted); }
      .foot   { font-family: ui-monospace, SFMono-Regular, Consolas, monospace; font-size: 13px; font-weight: 700; fill: var(--accent); }
      .mono   { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Inter, sans-serif; font-size: 34px; font-weight: 800; fill: var(--accent); letter-spacing: -1px; }
      @keyframes spin { to { transform: rotate(360deg); } }
      @keyframes pulse { 0%, 100% { opacity: 1; transform: scale(1); } 50% { opacity: 0.45; transform: scale(0.78); } }
      @media (prefers-reduced-motion: reduce) { .orbit, .dot { animation: none; } }
    </style>
    <filter id="sh" x="-6%" y="-10%" width="112%" height="128%">
      <feDropShadow class="ds" dx="0" dy="8" stdDeviation="9"/>
    </filter>
    <clipPath id="cardClip"><rect x="10" y="8" width="540" height="210" rx="10"/></clipPath>
    <clipPath id="avatarClip"><circle cx="104" cy="113" r="56"/></clipPath>
  </defs>

  <rect class="card" x="10" y="8" width="540" height="210" rx="10" filter="url(#sh)"/>
  <g clip-path="url(#cardClip)">
    <rect class="panel" x="10" y="8" width="188" height="210"/>
    <line class="sep" x1="198" y1="8" x2="198" y2="218"/>
    <rect class="rail" x="10" y="8" width="6" height="210"/>
  </g>

  <circle class="orbit" cx="104" cy="113" r="70"/>
  <circle class="hole" cx="104" cy="113" r="61"/>
$avatarBlock
  <circle class="ring" cx="104" cy="113" r="56"/>

  <rect class="chip" x="218" y="30" width="$chipW" height="26" rx="13"/>
  <circle class="dot" cx="231" cy="43" r="3.2"/>
  <text class="role" x="242" y="47">$memberRole</text>
  <text class="name" x="218" y="96">$memberName</text>
  <text class="txt" x="218" y="128">$line1</text>
  <text class="txt" x="218" y="151">$line2</text>
  <line class="sep" x1="218" y1="171" x2="526" y2="171"/>
  <text class="foot" x="218" y="196">$foot</text>

  <rect class="frame" x="10.5" y="8.5" width="539" height="209" rx="9.5"/>
</svg>
"@

    $cardPath = Join-Path $teamDir "$($m.File).svg"
    [System.IO.File]::WriteAllText($cardPath, $cardSvg, [System.Text.Encoding]::UTF8)
    Write-Host "Tarjeta limpia generada para $($m.Name) en $cardPath"
}

Write-Host "Generación completada exitosamente."
