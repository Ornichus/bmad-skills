# PreCompact Hook Handler
# Declenche automatiquement la sequence de sauvegarde avant compactage

$message = @"
=== SEQUENCE AUTO-CONTEXT MANAGEMENT ===

Le contexte approche sa limite. AVANT le compactage automatique:

**ETAPE 1 - EXECUTEZ:** /update
   -> Synchronise Archon MCP et project-state.xml

**ETAPE 2 - EXECUTEZ:** /followup_doctor
   -> Verifie la coherence des donnees

**ETAPE 3 - COMPACTAGE** (automatique apres vos actions)

**ETAPE 4 - APRES REPRISE, EXECUTEZ:** /followup
   -> Reprend le contexte du projet

====================================
"@

$response = @{
    continue = $true
    systemMessage = $message
} | ConvertTo-Json -Compress

Write-Output $response
