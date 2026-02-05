# SessionStart Hook Handler
# Rappelle d'executer /followup apres une reprise de session

$message = @"
=== SESSION DEMARREE/REPRISE ===

**RECOMMANDATION:** Executez /followup pour:
- Afficher l'etat actuel du projet (Archon MCP + project-state.xml)
- Identifier les taches en cours et a faire
- Reprendre le contexte de travail

====================================
"@

$response = @{
    continue = $true
    systemMessage = $message
} | ConvertTo-Json -Compress

Write-Output $response
