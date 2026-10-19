# Tiny static preview server (no Node/Python needed).
# Usage: powershell -ExecutionPolicy Bypass -File tools/serve.ps1 -Port 8080
param([int]$Port = 8080)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

$types = @{
  '.html'        = 'text/html; charset=utf-8'
  '.css'         = 'text/css; charset=utf-8'
  '.js'          = 'text/javascript; charset=utf-8'
  '.json'        = 'application/json; charset=utf-8'
  '.webmanifest' = 'application/manifest+json'
  '.png'         = 'image/png'
  '.jpg'         = 'image/jpeg'
  '.jpeg'        = 'image/jpeg'
  '.svg'         = 'image/svg+xml'
  '.ico'         = 'image/x-icon'
  '.woff2'       = 'font/woff2'
  '.xml'         = 'application/xml; charset=utf-8'
  '.txt'         = 'text/plain; charset=utf-8'
}

$listener = New-Object System.Net.Sockets.TcpListener([System.Net.IPAddress]::Loopback, $Port)
$listener.Start()
Write-Host "Serving $root"
Write-Host "Open http://localhost:$Port/  (Ctrl+C to stop)"

while ($true) {
  $client = $listener.AcceptTcpClient()
  try {
    $stream = $client.GetStream()
    $reader = New-Object System.IO.StreamReader($stream, [System.Text.Encoding]::ASCII, $false, 1024, $true)

    $requestLine = $reader.ReadLine()
    if ([string]::IsNullOrWhiteSpace($requestLine)) { $client.Close(); continue }

    while ($true) {
      $line = $reader.ReadLine()
      if ([string]::IsNullOrEmpty($line)) { break }
    }

    $rawPath = ($requestLine -split ' ')[1]
    $path = [System.Uri]::UnescapeDataString($rawPath.Split('?')[0])
    if ($path -eq '/') { $path = '/index.html' }

    $relative = $path.TrimStart('/').Replace('/', [System.IO.Path]::DirectorySeparatorChar)
    $file = Join-Path $root $relative
    $status = '200 OK'

    if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {
      $file = Join-Path $root '404.html'
      $status = '404 Not Found'
    }

    $bytes = [System.IO.File]::ReadAllBytes($file)
    $ext = [System.IO.Path]::GetExtension($file).ToLowerInvariant()
    $contentType = $types[$ext]
    if (-not $contentType) { $contentType = 'application/octet-stream' }

    $header = "HTTP/1.1 $status`r`nContent-Type: $contentType`r`nContent-Length: $($bytes.Length)`r`nCache-Control: no-store`r`nConnection: close`r`n`r`n"
    $headerBytes = [System.Text.Encoding]::ASCII.GetBytes($header)

    $stream.Write($headerBytes, 0, $headerBytes.Length)
    $stream.Write($bytes, 0, $bytes.Length)
    $stream.Flush()

    $reader.Dispose()
    $stream.Dispose()
  } catch {
    # A browser closing a tab mid-request is normal; keep serving.
  } finally {
    $client.Close()
  }
}
