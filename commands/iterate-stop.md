# /iterate-stop - Désactive le mode iterate-test-fix

Désactive le mode workflow iterate-test-fix et revient en mode normal.

## Instructions

1. **Mettre le mode en normal:**
   ```powershell
   "normal" | Out-File -FilePath "$env:USERPROFILE\.claude\workflow-mode.txt" -NoNewline -Force
   ```

2. **Confirmer la désactivation:**
   Afficher: "Mode iterate-test-fix DÉSACTIVÉ. L'utilisateur sera alerté pour la gestion du contexte."

## Comportement en mode normal

Quand le contexte atteint 90%:
- L'utilisateur est alerté
- L'utilisateur décide quand exécuter /update + /compact
