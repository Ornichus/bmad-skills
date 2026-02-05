# /iterate-start - Active le mode iterate-test-fix

Active le mode workflow iterate-test-fix pour la gestion automatique du contexte.

## Instructions

1. **Créer le fichier de mode:**
   ```powershell
   "iterate" | Out-File -FilePath "$env:USERPROFILE\.claude\workflow-mode.txt" -NoNewline -Force
   ```

2. **Confirmer l'activation:**
   Afficher: "Mode iterate-test-fix ACTIVÉ. La gestion du contexte sera automatique."

## Comportement en mode iterate

Quand le contexte atteint 90%:
- L'agent exécute automatiquement /update, /compact, /followup
- PAS de demande à l'utilisateur
- Le workflow continue après les actions

## Pour désactiver

Utilisez `/iterate-stop` pour revenir en mode normal.
