# Stop Hook Handler
# Verifie le niveau de contexte et agit selon le mode de workflow
# - Mode iterate-test-fix: ordonne a l'agent d'executer /update + /compact + /followup
# - Mode normal: alerte l'utilisateur

# Configuration
$contextFile = "$env:USERPROFILE\.claude\context-level.txt"
$workflowModeFile = "$env:USERPROFILE\.claude\workflow-mode.txt"
$threshold = 90  # Seuil d'alerte en pourcentage

# Detecter le mode de workflow
$isIterateMode = $false
if (Test-Path $workflowModeFile) {
    $mode = (Get-Content -Path $workflowModeFile -Raw).Trim()
    if ($mode -eq "iterate") {
        $isIterateMode = $true
    }
}

# Message par defaut
$message = "RAPPEL: Pensez a /update si des changements significatifs ont ete faits."

# Verifier le niveau de contexte
if (Test-Path $contextFile) {
    try {
        $contextPct = [int](Get-Content -Path $contextFile -Raw)

        if ($contextPct -ge $threshold) {
            $remaining = 100 - $contextPct

            if ($isIterateMode) {
                # Mode iterate: l'agent execute automatiquement
                $message = @"
=== AUTO-CONTEXT MANAGEMENT (Mode Iterate) ===

Memoire contextuelle: $contextPct% utilisee ($remaining% restant)

**EXECUTION AUTOMATIQUE REQUISE - NE PAS DEMANDER A L'UTILISATEUR:**

1. EXECUTEZ IMMEDIATEMENT: /update
   (Synchronise Archon MCP + project-state.xml)

2. PUIS EXECUTEZ: /compact
   (Libere la memoire contextuelle)

3. APRES COMPACT, EXECUTEZ: /followup
   (Reprend le contexte du projet)

**IMPORTANT:** Continuez le workflow iterate-test-fix apres ces actions.
Notez l'etat actuel avant compact:
- Grande Etape en cours
- Sous-etape courante
- Iteration et status

================================================
"@
            } else {
                # Mode normal: alerter l'utilisateur
                $message = @"
=== ALERTE CONTEXTE CRITIQUE ===

Memoire contextuelle: $contextPct% utilisee ($remaining% restant)

ACTION REQUISE - DEMANDEZ A L'UTILISATEUR:
1. Executez /update (sync Archon + project-state.xml)
2. Executez /compact (liberation memoire)

Si workflow iterate-test-fix actif, notez l'etat avant compact:
- Grande Etape: [nom]
- Sous-etape: [N/total]
- Status: PASS/FAIL/ITERATING

=====================================
"@
            }
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
