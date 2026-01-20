# Claude Code Context Manager Hook Script
# Gere automatiquement le contexte et declenche les commandes appropriees

param(
    [Parameter(Mandatory=$false)]
    [string]$HookEvent = "Unknown",

    [Parameter(Mandatory=$false)]
    [string]$TranscriptPath = ""
)

# Configuration
$CONFIG = @{
    ContextThreshold = 0.10  # 10% restant = 90% utilise
    MaxTranscriptSizeKB = 500  # Estimation taille max avant compact
}

# Fonction pour estimer l'utilisation du contexte
function Get-ContextUsage {
    param([string]$TranscriptPath)

    if (-not $TranscriptPath -or -not (Test-Path $TranscriptPath)) {
        return 0.5  # 50% par defaut si pas de transcript
    }

    $fileInfo = Get-Item $TranscriptPath
    $sizeKB = $fileInfo.Length / 1KB
    $usage = [Math]::Min(1.0, $sizeKB / $CONFIG.MaxTranscriptSizeKB)

    return $usage
}

# Fonction pour creer la reponse JSON
function New-HookResponse {
    param(
        [bool]$Continue = $true,
        [string]$SystemMessage = "",
        [string]$Decision = "",
        [string]$Reason = ""
    )

    $response = @{
        continue = $Continue
    }

    if ($SystemMessage) {
        $response.systemMessage = $SystemMessage
    }

    if ($Decision) {
        $response.decision = $Decision
        if ($Reason) {
            $response.reason = $Reason
        }
    }

    return ($response | ConvertTo-Json -Compress)
}

# Logique principale basee sur l'evenement
switch ($HookEvent) {
    "PreCompact" {
        # Le contexte est bas - declencher la sequence de sauvegarde
        $message = @"
SEQUENCE AUTO-CONTEXT MANAGEMENT ACTIVEE (contexte < 10%):

**ACTIONS REQUISES AVANT COMPACTAGE:**

1. EXECUTEZ IMMEDIATEMENT `/update` pour synchroniser:
   - Archon MCP (taches, statuts)
   - project-state.xml (historique, evenements)

2. PUIS EXECUTEZ `/followup_doctor` pour:
   - Verifier la coherence des donnees

3. LE COMPACTAGE PROCEDERA ENSUITE AUTOMATIQUEMENT

4. APRES LE COMPACTAGE, EXECUTEZ `/followup` pour:
   - Reprendre le contexte du projet

**IMPORTANT:** Ne pas ignorer ces etapes pour preserver la continuite du projet.
"@
        Write-Output (New-HookResponse -Continue $true -SystemMessage $message)
    }

    "SessionStart" {
        # Nouvelle session ou reprise apres compact
        $message = @"
SESSION DEMARREE/REPRISE

**RECOMMANDATION:** Executez `/followup` pour:
- Voir l'etat actuel du projet
- Reprendre le contexte des taches en cours
- Identifier les prochaines actions
"@
        Write-Output (New-HookResponse -Continue $true -SystemMessage $message)
    }

    "Stop" {
        # Fin de reponse - rappel leger
        $message = "RAPPEL: Pensez a `/update` si des changements significatifs ont ete faits."
        Write-Output (New-HookResponse -Continue $true -SystemMessage $message)
    }

    default {
        # Evenement non gere - continuer normalement
        Write-Output (New-HookResponse -Continue $true)
    }
}
