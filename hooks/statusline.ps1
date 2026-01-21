# Claude Code Statusline
# Affiche le modele et le pourcentage de contexte utilise
# Ecrit le % dans context-level.txt pour le hook Stop

$inputData = [Console]::In.ReadToEnd()
$json = $inputData | ConvertFrom-Json

$model = $json.model.display_name

# Context usage calculation
$contextPct = 0
if ($json.context_window -and $json.context_window.current_usage) {
    $usage = $json.context_window.current_usage
    $current = $usage.input_tokens + $usage.cache_creation_input_tokens + $usage.cache_read_input_tokens
    $total = $json.context_window.context_window_size
    if ($total -gt 0) {
        $contextPct = [math]::Round(($current / $total) * 100)
    }
}

# Progress bar (20 chars wide)
$barWidth = 20
$filled = [math]::Round($barWidth * $contextPct / 100)
$empty = $barWidth - $filled
$bar = ("#" * $filled) + ("-" * $empty)

# Sauvegarder le % dans un fichier pour le hook Stop
$contextFile = "$env:USERPROFILE\.claude\context-level.txt"
$contextPct | Out-File -FilePath $contextFile -NoNewline -Force

Write-Host "$model | Context: [$bar] $contextPct%" -NoNewline
