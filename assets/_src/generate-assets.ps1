# Script integral de generación de componentes vectoriales PuraSed
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$repoRoot = (Get-Item $PSScriptRoot).Parent.Parent.FullName
$assetsDir = Join-Path $repoRoot "assets"
$teamDir = Join-Path $assetsDir "team"
if (-not (Test-Path $teamDir)) {
    New-Item -ItemType Directory -Path $teamDir | Out-Null
}

Write-Host "Directorio raíz del repositorio: $repoRoot"

# ==========================================
# 1. GENERACIÓN DE assets/banner.svg
# ==========================================
$bannerJpg = Join-Path $assetsDir "banner.jpg"
if (Test-Path $bannerJpg) {
    Write-Host "Generando assets/banner.svg desde banner.jpg..."
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
  <title id="bannerTitle">PuraSed — Bar y Restaurante System</title>
  <desc id="bannerDesc">Plataforma digital para bar nocturno y restaurante: pedidos por mesa, comanda a barra y cocina, y control de jornada.</desc>
  <defs>
    <style>
      .frame { fill: none; stroke: #1F3A4D; stroke-opacity: .12; stroke-width: 1.5; }
      .ds    { flood-color: #1F3A4D; flood-opacity: .25; }
      .bubble {
        fill: #FFF9E6;
        opacity: 0;
        animation-name: rise;
        animation-duration: 3.2s;
        animation-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
        animation-iteration-count: infinite;
      }
      .b1 { animation-delay: 0.0s; }
      .b2 { animation-delay: 0.8s; }
      .b3 { animation-delay: 1.6s; }
      .b4 { animation-delay: 2.4s; }

      @keyframes rise {
        0%   { transform: translate(0, 0); opacity: 0; }
        15%  { opacity: 0.85; }
        55%  { transform: translate(1.8px, -55px); opacity: 0.70; }
        85%  { opacity: 0.45; }
        100% { transform: translate(-1.2px, -115px); opacity: 0; }
      }

      @media (prefers-color-scheme: dark) {
        .frame { stroke: #FFFFFF; stroke-opacity: .14; }
        .ds    { flood-color: #000000; flood-opacity: .60; }
      }
      @media (prefers-reduced-motion: reduce) {
        .bubble { animation: none; opacity: 0; }
      }
    </style>

    <filter id="shadow" x="-3%" y="-6%" width="106%" height="120%">
      <feDropShadow class="ds" dx="0" dy="10" stdDeviation="12"/>
    </filter>

    <clipPath id="round">
      <rect x="20" y="12" width="1600" height="397" rx="20"/>
    </clipPath>

    <clipPath id="glassArea">
      <rect x="270" y="130" width="150" height="190" rx="10"/>
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
    <g clip-path="url(#glassArea)">
      <circle class="bubble b1" cx="310" cy="295" r="3.2"/>
      <circle class="bubble b2" cx="340" cy="305" r="2.4"/>
      <circle class="bubble b3" cx="365" cy="290" r="3.6"/>
      <circle class="bubble b4" cx="385" cy="310" r="2.8"/>
      <circle class="bubble b1" cx="325" cy="315" r="2.0"/>
      <circle class="bubble b2" cx="355" cy="285" r="3.0"/>
      <circle class="bubble b3" cx="375" cy="318" r="2.5"/>
      <circle class="bubble b4" cx="395" cy="298" r="3.4"/>
    </g>
  </g>

  <rect class="frame" x="20.5" y="12.5" width="1599" height="396" rx="19.5"/>
</svg>
"@
    $outBanner = Join-Path $assetsDir "banner.svg"
    [System.IO.File]::WriteAllText($outBanner, $bannerSvg, [System.Text.Encoding]::UTF8)
    Write-Host "Banner SVG generado en $outBanner"
}

# ==========================================
# 2. GENERACIÓN DE assets/tags.svg (Lienzo 1200px)
# ==========================================
Write-Host "Generando assets/tags.svg (Lienzo arquitectónico simétrico de 1200px)..."

$tagsSvg = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 230" width="1200" height="230" role="img" aria-labelledby="tagsTitle tagsDesc">
  <title id="tagsTitle">PuraSed Tech Canvas — Arquitectura y Tecnologías</title>
  <desc id="tagsDesc">Ecosistema técnico integrado: Cliente Blazor WASM en .NET 10, Backend ASP.NET Core Web API, Base de datos SQL Server con EF Core, y gestión Scrum en Jira Software.</desc>
  <defs>
    <style>
      :root {
        --canvas-bg: #F8FAFC;
        --card-bg: #FFFFFF;
        --card-border: rgba(31, 58, 77, 0.12);
        --title-color: #1F3A4D;
        --sub-color: #5B7383;
        --tag-bg: rgba(31, 58, 77, 0.05);
        --tag-border: rgba(31, 58, 77, 0.10);
        --tag-text: #2C4A5E;
        --flow-line: #3D8FAE;
        --flow-wire: rgba(61, 143, 174, 0.28);
        --pill-bg: rgba(31, 58, 77, 0.06);
        --pill-text: #415A6C;
        --card-shadow: rgba(31, 58, 77, 0.08);
      }

      @media (prefers-color-scheme: dark) {
        :root {
          --canvas-bg: #0D1117;
          --card-bg: #161B22;
          --card-border: rgba(255, 255, 255, 0.10);
          --title-color: #F0F6FC;
          --sub-color: #8B949E;
          --tag-bg: rgba(255, 255, 255, 0.05);
          --tag-border: rgba(255, 255, 255, 0.08);
          --tag-text: #C9D1D9;
          --flow-line: #58A6FF;
          --flow-wire: rgba(88, 166, 255, 0.25);
          --pill-bg: rgba(255, 255, 255, 0.08);
          --pill-text: #8B949E;
          --card-shadow: rgba(0, 0, 0, 0.45);
        }
      }

      .card { fill: var(--card-bg); stroke: var(--card-border); stroke-width: 1; }
      .title { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 22px; font-weight: 700; fill: var(--title-color); }
      .sub { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 13.5px; font-weight: 500; fill: var(--sub-color); }
      .pill-lbl { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 10px; font-weight: 700; letter-spacing: 1.5px; fill: var(--pill-text); }
      .tag-lbl { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 11px; font-weight: 600; fill: var(--tag-text); }
      .proto-lbl { font-family: ui-monospace, SFMono-Regular, Consolas, monospace; font-size: 9px; font-weight: 700; letter-spacing: 0.5px; fill: var(--sub-color); }

      @keyframes flowData {
        from { stroke-dashoffset: 24; }
        to   { stroke-dashoffset: 0; }
      }

      .flow-active {
        stroke: var(--flow-line);
        stroke-width: 2.2;
        stroke-dasharray: 6 5;
        animation: flowData 1.4s linear infinite;
      }

      .flow-sync {
        stroke: var(--flow-line);
        stroke-width: 1.8;
        stroke-dasharray: 4 4;
        opacity: 0.75;
        animation: flowData 2.2s linear infinite;
      }

      @media (prefers-reduced-motion: reduce) {
        .flow-active, .flow-sync { animation: none; }
      }
    </style>

    <filter id="cardSh" x="-4%" y="-6%" width="108%" height="116%">
      <feDropShadow flood-color="var(--card-shadow)" dx="0" dy="5" stdDeviation="6"/>
    </filter>
  </defs>

  <!-- LÍNEAS CONECTORAS INTER-BLOQUES (FLUJO DE DATOS) -->
  <!-- Conector 1 -> 2 (Cliente a Servidor) -->
  <line x1="288" y1="115" x2="320" y2="115" stroke="var(--flow-wire)" stroke-width="2.2"/>
  <line class="flow-active" x1="288" y1="115" x2="320" y2="115"/>
  <polygon points="318,111 325,115 318,119" fill="var(--flow-line)"/>
  <text class="proto-lbl" x="304" y="104" text-anchor="middle">HTTPS</text>

  <!-- Conector 2 -> 3 (Servidor a Datos) -->
  <line x1="584" y1="115" x2="616" y2="115" stroke="var(--flow-wire)" stroke-width="2.2"/>
  <line class="flow-active" x1="584" y1="115" x2="616" y2="115"/>
  <polygon points="614,111 621,115 614,119" fill="var(--flow-line)"/>
  <text class="proto-lbl" x="600" y="104" text-anchor="middle">TDS</text>

  <!-- Conector 3 -> 4 (Datos a Gestión Agile) -->
  <line x1="880" y1="115" x2="912" y2="115" stroke="var(--flow-wire)" stroke-width="1.8"/>
  <line class="flow-sync" x1="880" y1="115" x2="912" y2="115"/>
  <circle cx="896" cy="115" r="3.2" fill="var(--flow-line)"/>
  <text class="proto-lbl" x="896" y="104" text-anchor="middle">SYNC</text>

  <!-- BLOQUE 1: CLIENTE (SPA) -->
  <g transform="translate(24, 20)">
    <rect class="card" x="0" y="0" width="264" height="190" rx="14" filter="url(#cardSh)"/>
    <rect x="0" y="0" width="264" height="4" rx="2" fill="#E4524F"/>
    
    <rect x="18" y="18" width="112" height="22" rx="11" fill="var(--pill-bg)"/>
    <text class="pill-lbl" x="74" y="33" text-anchor="middle">CLIENTE · SPA</text>
    
    <text class="title" x="18" y="74">.NET 10.0</text>
    <text class="sub" x="18" y="98">Blazor WebAssembly</text>
    
    <rect x="18" y="116" width="138" height="24" rx="12" fill="var(--tag-bg)" stroke="var(--tag-border)" stroke-width="1"/>
    <text class="tag-lbl" x="87" y="132" text-anchor="middle">C# Nativo (WASM)</text>
    
    <rect x="18" y="148" width="162" height="24" rx="12" fill="var(--tag-bg)" stroke="var(--tag-border)" stroke-width="1"/>
    <text class="tag-lbl" x="99" y="164" text-anchor="middle">Vistas por Rol (Mobile QR)</text>
  </g>

  <!-- BLOQUE 2: SERVIDOR (API) -->
  <g transform="translate(320, 20)">
    <rect class="card" x="0" y="0" width="264" height="190" rx="14" filter="url(#cardSh)"/>
    <rect x="0" y="0" width="264" height="4" rx="2" fill="#512BD4"/>
    
    <rect x="18" y="18" width="126" height="22" rx="11" fill="var(--pill-bg)"/>
    <text class="pill-lbl" x="81" y="33" text-anchor="middle">SERVIDOR · API</text>
    
    <text class="title" x="18" y="74">ASP.NET Core</text>
    <text class="sub" x="18" y="98">Web API &amp; SignalR</text>
    
    <rect x="18" y="116" width="152" height="24" rx="12" fill="var(--tag-bg)" stroke="var(--tag-border)" stroke-width="1"/>
    <text class="tag-lbl" x="94" y="132" text-anchor="middle">RESTful &amp; OpenAPI v1</text>
    
    <rect x="18" y="148" width="166" height="24" rx="12" fill="var(--tag-bg)" stroke="var(--tag-border)" stroke-width="1"/>
    <text class="tag-lbl" x="101" y="164" text-anchor="middle">Comandas en Tiempo Real</text>
  </g>

  <!-- BLOQUE 3: DATOS (PERSISTENCIA) -->
  <g transform="translate(616, 20)">
    <rect class="card" x="0" y="0" width="264" height="190" rx="14" filter="url(#cardSh)"/>
    <rect x="0" y="0" width="264" height="4" rx="2" fill="#0078D4"/>
    
    <rect x="18" y="18" width="154" height="22" rx="11" fill="var(--pill-bg)"/>
    <text class="pill-lbl" x="95" y="33" text-anchor="middle">DATOS · PERSISTENCIA</text>
    
    <text class="title" x="18" y="74">SQL Server</text>
    <text class="sub" x="18" y="98">Entity Framework Core</text>
    
    <rect x="18" y="116" width="156" height="24" rx="12" fill="var(--tag-bg)" stroke="var(--tag-border)" stroke-width="1"/>
    <text class="tag-lbl" x="96" y="132" text-anchor="middle">Code-First Migrations</text>
    
    <rect x="18" y="148" width="150" height="24" rx="12" fill="var(--tag-bg)" stroke="var(--tag-border)" stroke-width="1"/>
    <text class="tag-lbl" x="93" y="164" text-anchor="middle">Inventario &amp; Facturación</text>
  </g>

  <!-- BLOQUE 4: GESTIÓN (AGILE) -->
  <g transform="translate(912, 20)">
    <rect class="card" x="0" y="0" width="264" height="190" rx="14" filter="url(#cardSh)"/>
    <rect x="0" y="0" width="264" height="4" rx="2" fill="#0052CC"/>
    
    <rect x="18" y="18" width="128" height="22" rx="11" fill="var(--pill-bg)"/>
    <text class="pill-lbl" x="82" y="33" text-anchor="middle">GESTIÓN · AGILE</text>
    
    <text class="title" x="18" y="74">Jira Software</text>
    <text class="sub" x="18" y="98">Atlassian Scrum Board</text>
    
    <rect x="18" y="116" width="160" height="24" rx="12" fill="var(--tag-bg)" stroke="var(--tag-border)" stroke-width="1"/>
    <text class="tag-lbl" x="98" y="132" text-anchor="middle">32 Historias de Usuario</text>
    
    <rect x="18" y="148" width="144" height="24" rx="12" fill="var(--tag-bg)" stroke="var(--tag-border)" stroke-width="1"/>
    <text class="tag-lbl" x="90" y="164" text-anchor="middle">Sprints Semanales</text>
  </g>
</svg>
"@

$outTags = Join-Path $assetsDir "tags.svg"
[System.IO.File]::WriteAllText($outTags, $tagsSvg, [System.Text.Encoding]::UTF8)
Write-Host "Tags SVG generado en $outTags"

# ==========================================
# 3. GENERACIÓN DE TARJETAS VECTORIALES DEL EQUIPO (assets/team/)
# ==========================================
Write-Host "Generando tarjetas vectoriales simétricas del Scrum Team..."

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
        Line1 = "Requerimientos y aceptación"
        Line2 = "de entregables del cliente"
        Github = ""
        Foot = "FIEE · EPN"
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
        Line1 = "Facilitación ágil, remoción de"
        Line2 = "impedimentos y desarrollo"
        Github = "JannysG1"
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
        Line1 = "Arquitectura de datos, lógica"
        Line2 = "de backend y base de datos"
        Github = "angelch1595-glitch"
        Foot = "@angelch1595-glitch"
        Initials = "AC"
        AvatarUrl = "https://avatars.githubusercontent.com/u/274108894?v=4"
    },
    @{
        File = "angelo-conteron"
        Name = "Angelo Conterón"
        Role = "DESARROLLO"
        RoleText = "Equipo de desarrollo"
        Accent = "#3D8FAE"
        ChipW = 135
        Line1 = "Interfaces Blazor WASM, UX/UI"
        Line2 = "y control de versiones"
        Github = "Anghel01"
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
    Write-Host "Tarjeta generada para $($m.Name) en $cardPath"
}

Write-Host "Todos los componentes vectoriales han sido generados con éxito."
