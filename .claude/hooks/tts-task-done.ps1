# tts-task-done.ps1
# Hook TTS - ecrit un fichier signal pour le service TTS

$claudeDir = "C:\Users\aland\.claude"
$signalFile = "$claudeDir\tts-signal.txt"

try {
    # Lire stdin
    $jsonText = @($input) -join "`n"

    # Parser le JSON
    $data = $jsonText | ConvertFrom-Json -ErrorAction Stop

    $projectName = "Inconnu"
    if ($data.cwd) {
        $projectName = Split-Path -Leaf $data.cwd
    }

    $projectName = $projectName -replace '[_-]', ' '
    $projectName = $projectName -replace "'", ""
    $projectName = $projectName -replace '"', ""

    $message = "Projet $projectName. Tache Terminee!"

} catch {
    # En cas d'erreur de parsing, utiliser message par defaut
    $message = "Tache Terminee!"
}

# Ecrire le signal (toujours)
[System.IO.File]::WriteAllText($signalFile, $message)

@{ continue = $true } | ConvertTo-Json -Compress | Write-Output
