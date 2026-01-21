# Stop Hook Handler
# Verifie le niveau de contexte et alerte si >= seuil configurable
# Fonctionne avec statusline.ps1 qui ecrit le % dans context-level.txt

# Configuration
$contextFile = "$env:USERPROFILE\.claude\context-level.txt"
$threshold = 90  # Seuil d'alerte en pourcentage

# Message par defaut
$message = "RAPPEL: Pensez a /update si des changements significatifs ont ete faits."

# Verifier le niveau de contexte
if (Test-Path $contextFile) {
    try {
        $contextPct = [int](Get-Content -Path $contextFile -Raw)

        if ($contextPct -ge $threshold) {
            $remaining = 100 - $contextPct
            $message = @"
=== ALERTE CONTEXTE CRITIQUE ===

Memoire contextuelle: $contextPct% utilisee ($remaining% restant)

ACTION REQUISE MAINTENANT:
1. Executez /update (sync Archon + project-state.xml)
2. Executez /compact (liberation memoire)

Si workflow iterate-test-fix actif, notez l'etat avant compact:
- Grande Etape: [nom]
- Sous-etape: [N/total]
- Status: PASS/FAIL/ITERATING

=====================================
"@
        }
    } catch {
        # En cas d'erreur de lecture, utiliser message par defaut
    }
}

$response = @{
    continue = $true
    systemMessage = $message
} | ConvertTo-Json -Compress

Write-Output $response
