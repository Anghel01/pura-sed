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
      .frame { fill: none; stroke: #1F3A4D; stroke-opacity: .12; stroke-width: 1.5; }
      .ds    { flood-color: #1F3A4D; flood-opacity: .25; }
      
      /* Efervescencia de burbujas en el cuerpo de la cerveza */
      .bubble {
        fill: #FFF9E6;
        opacity: 0;
        animation-name: rise;
        animation-duration: 3.4s;
        animation-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
        animation-iteration-count: infinite;
      }
      .b1 { animation-delay: 0.0s; animation-duration: 2.8s; }
      .b2 { animation-delay: 0.6s; animation-duration: 3.3s; }
      .b3 { animation-delay: 1.2s; animation-duration: 2.9s; }
      .b4 { animation-delay: 1.8s; animation-duration: 3.5s; }
      .b5 { animation-delay: 2.4s; animation-duration: 3.1s; }
      .b6 { animation-delay: 3.0s; animation-duration: 2.7s; }

      /* Destellos de espuma en la corona desbordante */
      .fizz {
        fill: #FFFFFF;
        opacity: 0.2;
        animation: fizzle 2s ease-in-out infinite alternate;
      }
      .fz1 { animation-delay: 0.2s; }
      .fz2 { animation-delay: 0.7s; }
      .fz3 { animation-delay: 1.3s; }

      @keyframes rise {
        0%   { transform: translate(0, 0); opacity: 0; }
        15%  { opacity: 0.85; }
        55%  { transform: translate(2px, -65px); opacity: 0.70; }
        85%  { opacity: 0.45; }
        100% { transform: translate(-1.5px, -135px); opacity: 0; }
      }

      @keyframes fizzle {
        0%   { opacity: 0.25; transform: scale(0.9); }
        50%  { opacity: 0.85; transform: scale(1.2); }
        100% { opacity: 0.40; transform: scale(1.0); }
      }

      @media (prefers-color-scheme: dark) {
        .frame { stroke: #FFFFFF; stroke-opacity: .14; }
        .ds    { flood-color: #000000; flood-opacity: .60; }
      }
      @media (prefers-reduced-motion: reduce) {
        .bubble, .fizz { animation: none; opacity: 0.4; }
      }
    </style>

    <filter id="shadow" x="-3%" y="-6%" width="106%" height="120%">
      <feDropShadow class="ds" dx="0" dy="10" stdDeviation="12"/>
    </filter>

    <clipPath id="round">
      <rect x="20" y="12" width="1600" height="397" rx="20"/>
    </clipPath>

    <clipPath id="glassArea">
      <rect x="260" y="125" width="165" height="205" rx="10"/>
    </clipPath>

    <linearGradient id="seamGradient" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0%" stop-color="#84B8CA" stop-opacity="0.95"/>
      <stop offset="50%" stop-color="#88BDD0" stop-opacity="0.90"/>
      <stop offset="85%" stop-color="#7CAEC2" stop-opacity="0.80"/>
      <stop offset="100%" stop-color="#6F9EB2" stop-opacity="0"/>
    </linearGradient>
    <filter id="seamBlur">
      <feGaussianBlur stdDeviation="3"/>
    </filter>
  </defs>

  <rect x="20" y="12" width="1600" height="397" rx="20" fill="#86BDD0" filter="url(#shadow)"/>

  <g clip-path="url(#round)">
    <image xlink:href="data:image/jpeg;base64,$b64" x="20" y="12" width="1600" height="397" preserveAspectRatio="xMidYMid slice"/>
    <rect x="1305" y="12" width="22" height="295" fill="url(#seamGradient)" filter="url(#seamBlur)" opacity="0.85"/>

    <!-- Efervescencia densa en el vaso de cerveza -->
    <g clip-path="url(#glassArea)">
      <!-- Columna 1 -->
      <circle class="bubble b1" cx="295" cy="305" r="3.2"/>
      <circle class="bubble b3" cx="305" cy="315" r="2.0"/>
      <circle class="bubble b5" cx="300" cy="285" r="2.8"/>
      <!-- Columna 2 -->
      <circle class="bubble b2" cx="325" cy="318" r="2.4"/>
      <circle class="bubble b4" cx="335" cy="295" r="3.6"/>
      <circle class="bubble b6" cx="330" cy="325" r="1.8"/>
      <circle class="bubble b1" cx="342" cy="275" r="3.0"/>
      <!-- Columna 3 -->
      <circle class="bubble b3" cx="355" cy="310" r="4.0"/>
      <circle class="bubble b5" cx="365" cy="288" r="2.2"/>
      <circle class="bubble b2" cx="372" cy="320" r="3.4"/>
      <circle class="bubble b4" cx="360" cy="300" r="1.6"/>
      <!-- Columna 4 -->
      <circle class="bubble b6" cx="385" cy="312" r="3.0"/>
      <circle class="bubble b1" cx="395" cy="282" r="2.5"/>
      <circle class="bubble b3" cx="390" cy="325" r="3.5"/>
      <circle class="bubble b5" cx="405" cy="295" r="2.0"/>

      <!-- Destellos de efervescencia en la espuma superior -->
      <circle class="fizz fz1" cx="325" cy="155" r="2.5"/>
      <circle class="fizz fz2" cx="345" cy="148" r="3.2"/>
      <circle class="fizz fz3" cx="370" cy="152" r="2.8"/>
      <circle class="fizz fz1" cx="390" cy="160" r="3.0"/>
      <circle class="fizz fz2" cx="310" cy="165" r="2.2"/>
      <circle class="fizz fz3" cx="355" cy="162" r="2.6"/>
    </g>
  </g>

  <rect class="frame" x="20.5" y="12.5" width="1599" height="396" rx="19.5"/>
</svg>
"@
    $outBanner = Join-Path $assetsDir "banner.svg"
    [System.IO.File]::WriteAllText($outBanner, $bannerSvg, [System.Text.Encoding]::UTF8)
    Write-Host "Banner SVG con espuma y efervescencia generado en $outBanner"
}

# ==========================================
# 2. GENERACIÓN DE assets/jira-board.svg (Banner visual para Sección Jira)
# ==========================================
Write-Host "Generando assets/jira-board.svg para el tablero Scrum..."
$jiraBanner = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 960 170" width="100%" height="100%" role="img" aria-labelledby="jiraTitle jiraDesc">
  <title id="jiraTitle">Tablero Scrum en Atlassian Jira Software</title>
  <desc id="jiraDesc">Gesti&#243;n &#225;gil del proyecto PuraSed: Sprints semanales, 32 Historias de Usuario priorizadas y seguimiento continuo.</desc>
  <defs>
    <style>
      :root {
        --j-bg: #FFFFFF;
        --j-border: #D0D7DE;
        --j-text: #1F3A4D;
        --j-sub: #57606A;
        --j-chip: #F0F4F8;
      }
      @media (prefers-color-scheme: dark) {
        :root {
          --j-bg: #161B22;
          --j-border: #30363D;
          --j-text: #F0F6FC;
          --j-sub: #8B949E;
          --j-chip: #21262D;
        }
      }
      .j-box { fill: var(--j-bg); stroke: var(--j-border); stroke-width: 1.2; }
      .j-title { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, sans-serif; font-size: 20px; font-weight: 700; fill: var(--j-text); }
      .j-desc { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, sans-serif; font-size: 13px; font-weight: 400; fill: var(--j-sub); }
      .j-badge { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, sans-serif; font-size: 11px; font-weight: 700; fill: #FFFFFF; }
      .j-btn-txt { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, sans-serif; font-size: 12.5px; font-weight: 700; fill: #FFFFFF; }
    </style>
    <filter id="jSh" x="-3%" y="-6%" width="106%" height="120%">
      <feDropShadow flood-color="rgba(0,82,204,0.15)" dx="0" dy="4" stdDeviation="6"/>
    </filter>
  </defs>

  <rect class="j-box" x="10" y="10" width="940" height="150" rx="14" filter="url(#jSh)"/>
  <rect x="10" y="10" width="8" height="150" fill="#0052CC" rx="4"/>

  <!-- Logo Jira Grande -->
  <g transform="translate(36, 42)">
    <circle cx="42" cy="42" r="40" fill="#0052CC"/>
    <path d="M42 16 L57 31 L42 46 L27 31 Z" fill="#2684FF"/>
    <path d="M42 27 L53 38 L42 49 L31 38 Z" fill="#FFFFFF"/>
    <path d="M42 38 L57 53 L42 68 L27 53 Z" fill="#0052CC" opacity="0.4"/>
  </g>

  <!-- Texto Informativo -->
  <g transform="translate(140, 40)">
    <text class="j-title" x="0" y="24">Tablero Oficial Scrum &#183; Atlassian Jira Software</text>
    <text class="j-desc" x="0" y="48">Gesti&#243;n de 32 Historias de Usuario (HU-01 a HU-32), criterios de aceptaci&#243;n y ciclo de 16 semanas.</text>

    <!-- Chips informativos -->
    <rect x="0" y="64" width="130" height="24" rx="12" fill="#E4524F"/>
    <text class="j-badge" x="65" y="80" text-anchor="middle">Sprint 1 &#183; En Curso</text>

    <rect x="140" y="64" width="150" height="24" rx="12" fill="var(--j-chip)" stroke="var(--j-border)"/>
    <text class="j-desc" x="215" y="80" text-anchor="middle" font-weight="600">32 Historias Activas</text>

    <rect x="300" y="64" width="165" height="24" rx="12" fill="var(--j-chip)" stroke="var(--j-border)"/>
    <text class="j-desc" x="382" y="80" text-anchor="middle" font-weight="600">8 M&#243;dulos Funcionales</text>
  </g>

  <!-- Bot&#243;n Acci&#243;n Visual -->
  <g transform="translate(710, 60)">
    <rect x="0" y="0" width="215" height="48" rx="24" fill="#0052CC"/>
    <text class="j-btn-txt" x="107" y="29" text-anchor="middle">Abrir Tablero en Jira &#8594;</text>
  </g>
</svg>
"@
$outJira = Join-Path $assetsDir "jira-board.svg"
[System.IO.File]::WriteAllText($outJira, $jiraBanner, [System.Text.Encoding]::UTF8)
Write-Host "Jira Board SVG generado en $outJira"

# ==========================================
# 3. GENERACIÓN DE TARJETAS VECTORIALES DEL EQUIPO (Clean Entities)
# ==========================================
Write-Host "Regenerando tarjetas vectoriales del equipo con caracteres codificados seguros..."

function Get-AvatarBase64($url) {
    try {
        $wc = New-Object System.Net.WebClient
        $wc.Headers.Add('User-Agent', 'Mozilla/5.0 Antigravity')
        $bytes = $wc.DownloadData($url)
        $ms = New-Object System.IO.MemoryStream(, $bytes)
        $bmp = [System.Drawing.Bitmap]::FromStream($ms)
        $resized = New-Object System.Drawing.Bitmap 120, 120
        $g = [System.Drawing.Graphics]::FromImage($resized)
        $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $g.DrawImage($bmp, 0, 0, 120, 120)
        $outMs = New-Object System.IO.MemoryStream
        $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
        $p = New-Object System.Drawing.Imaging.EncoderParameters 1
        $p.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]90)
        $resized.Save($outMs, $codec, $p)
        $b64 = [Convert]::ToBase64String($outMs.ToArray())
        $g.Dispose(); $resized.Dispose(); $bmp.Dispose(); $ms.Dispose(); $outMs.Dispose(); $wc.Dispose()
        return $b64
    }
    catch {
        Write-Warning "No se pudo descargar avatar de $($url) - $($_)"
        return $null
    }
}

$teamMembers = @(
    @{
        File = "jose-naranjo"
        Name = "Jose Naranjo"
        Role = "PRODUCT OWNER"
        RoleText = "Product Owner"
        Accent = "#E4524F"
        ChipW = 152
        Line1 = "Requerimientos y aceptaci&#243;n"
        Line2 = "de entregables del cliente"
        Foot = "FIEE &#183; EPN"
        Initials = "JN"
        AvatarUrl = $null
    },
    @{
        File = "jannys-garrido"
        Name = "Jannys Garrido"
        Role = "SCRUM MASTER"
        RoleText = "Scrum Master y desarrollo"
        Accent = "#D98C2B"
        ChipW = 148
        Line1 = "Facilitaci&#243;n &#225;gil, remoci&#243;n de"
        Line2 = "impedimentos y desarrollo"
        Foot = "@JannysG1"
        Initials = "JG"
        AvatarUrl = "https://avatars.githubusercontent.com/u/200006982?v=4"
    },
    @{
        File = "angel-chicaiza"
        Name = "Angel Chicaiza"
        Role = "DESARROLLO"
        RoleText = "Equipo de desarrollo"
        Accent = "#3E9A4A"
        ChipW = 135
        Line1 = "Arquitectura de datos, l&#243;gica"
        Line2 = "de backend y base de datos"
        Foot = "@angelch1595-glitch"
        Initials = "AC"
        AvatarUrl = "https://avatars.githubusercontent.com/u/274108894?v=4"
    },
    @{
        File = "angelo-conteron"
        Name = "Angelo Conter&#243;n"
        Role = "DESARROLLO"
        RoleText = "Equipo de desarrollo"
        Accent = "#3D8FAE"
        ChipW = 135
        Line1 = "Interfaces Blazor WASM, UX/UI"
        Line2 = "y control de versiones"
        Foot = "@Anghel01"
        Initials = "AC"
        AvatarUrl = "https://avatars.githubusercontent.com/u/195244904?v=4"
    }
)

foreach ($m in $teamMembers) {
    $avatarB64 = $null
    if ($m.AvatarUrl) {
        $avatarB64 = Get-AvatarBase64 $m.AvatarUrl
    }

    $avatarBlock = ""
    if ($avatarB64) {
        $avatarBlock = @"
  <image clip-path="url(#avatarClip)" xlink:href="data:image/jpeg;base64,$avatarB64" x="48" y="57" width="112" height="112" preserveAspectRatio="xMidYMid slice"/>
"@
    } else {
        $accent = $m.Accent
        $initials = $m.Initials
        $avatarBlock = @"
  <circle cx="104" cy="113" r="56" fill="$accent" fill-opacity=".15"/>
  <text class="mono" x="104" y="126" text-anchor="middle">$initials</text>
"@
    }

    $accentColor = $m.Accent
    $memberName = $m.Name
    $memberRole = $m.Role
    $roleText = $m.RoleText
    $chipW = $m.ChipW
    $line1 = $m.Line1
    $line2 = $m.Line2
    $foot = $m.Foot

    $cardSvg = @"
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 560 230" width="560" height="230" role="img" aria-label="$memberName, $roleText">
  <defs>
    <style>
      :root {
        --card: #FFFFFF;
        --ink: #1F3A4D;
        --muted: #5B7383;
        --line: rgba(31,58,77,.10);
        --frame: rgba(31,58,77,.12);
        --ds: rgba(31,58,77,.14);
      }
      @media (prefers-color-scheme: dark) {
        :root {
          --card: #161B22;
          --ink: #E6EDF3;
          --muted: #8B9BA8;
          --line: rgba(255,255,255,.08);
          --frame: rgba(255,255,255,.10);
          --ds: rgba(0,0,0,.55);
        }
      }
      .card  { fill: var(--card); }
      .hole  { fill: var(--card); }
      .frame { fill: none; stroke: var(--frame); stroke-width: 1; }
      .sep   { stroke: var(--line); stroke-width: 1; }
      .name  { font-family: Georgia, 'Times New Roman', serif; font-size: 28px; font-weight: 600; fill: var(--ink); }
      .role  { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 11.5px; font-weight: 700; letter-spacing: 2px; fill: $accentColor; }
      .txt   { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 15px; font-weight: 400; fill: var(--muted); }
      .foot  { font-family: ui-monospace, SFMono-Regular, Consolas, monospace; font-size: 14px; font-weight: 600; fill: $accentColor; }
      .mono  { font-family: Georgia, 'Times New Roman', serif; font-size: 38px; font-weight: 600; fill: $accentColor; }
      .orbit { transform-origin: 104px 113px; animation: spin 32s linear infinite; }
      @keyframes spin { to { transform: rotate(360deg); } }
      @media (prefers-reduced-motion: reduce) { .orbit { animation: none; } }
    </style>
    <filter id="sh" x="-6%" y="-10%" width="112%" height="128%">
      <feDropShadow flood-color="var(--ds)" dx="0" dy="8" stdDeviation="9"/>
    </filter>
    <clipPath id="cardClip"><rect x="10" y="8" width="540" height="210" rx="20"/></clipPath>
    <clipPath id="avatarClip"><circle cx="104" cy="113" r="56"/></clipPath>
  </defs>

  <rect class="card" x="10" y="8" width="540" height="210" rx="20" filter="url(#sh)"/>
  <g clip-path="url(#cardClip)">
    <rect x="10" y="8" width="188" height="210" fill="$accentColor" fill-opacity=".09"/>
    <rect x="10" y="8" width="5" height="210" fill="$accentColor"/>
  </g>

  <circle class="orbit" cx="104" cy="113" r="70" fill="none" stroke="$accentColor" stroke-width="1.6" stroke-dasharray="2 7" stroke-linecap="round"/>
  <circle class="hole" cx="104" cy="113" r="61"/>
$avatarBlock
  <circle cx="104" cy="113" r="56" fill="none" stroke="$accentColor" stroke-width="3"/>

  <rect x="214" y="32" width="$chipW" height="28" rx="14" fill="$accentColor" fill-opacity=".12"/>
  <text class="role" x="226" y="50.5">$memberRole</text>
  <text class="name" x="214" y="98">$memberName</text>
  <text class="txt" x="214" y="130">$line1</text>
  <text class="txt" x="214" y="154">$line2</text>
  <line class="sep" x1="214" y1="172" x2="526" y2="172"/>
  <text class="foot" x="214" y="196">$foot</text>

  <rect class="frame" x="10.5" y="8.5" width="539" height="209" rx="19.5"/>
</svg>
"@

    $cardPath = Join-Path $teamDir "$($m.File).svg"
    [System.IO.File]::WriteAllText($cardPath, $cardSvg, [System.Text.Encoding]::UTF8)
    Write-Host "Tarjeta limpia generada para $($m.Name) en $cardPath"
}

Write-Host "Generación completada exitosamente."
