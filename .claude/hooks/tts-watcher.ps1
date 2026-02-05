# tts-watcher.ps1
# Service TTS - surveille le fichier signal et joue le TTS
# Lancer dans une fenetre PowerShell separee: .\tts-watcher.ps1

$signalFile = "$env:USERPROFILE\.claude\tts-signal.txt"

Write-Host "=== TTS Watcher Service ===" -ForegroundColor Cyan
Write-Host "Surveillance de: $signalFile" -ForegroundColor Yellow
Write-Host "Ctrl+C pour arreter" -ForegroundColor Yellow
Write-Host ""

# Supprimer l'ancien signal s'il existe
Remove-Item -Path $signalFile -Force -ErrorAction SilentlyContinue

while ($true) {
    if (Test-Path $signalFile) {
        $message = Get-Content -Path $signalFile -Raw -Encoding UTF8
        $message = $message.Trim()

        if ($message) {
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] TTS: $message" -ForegroundColor Green

            # Jouer le TTS
            $voice = New-Object -ComObject SAPI.SpVoice
            $voice.Rate = 2
            $voice.Speak($message) | Out-Null
        }

        # Supprimer le signal
        Remove-Item -Path $signalFile -Force -ErrorAction SilentlyContinue
    }

    Start-Sleep -Milliseconds 500
}
