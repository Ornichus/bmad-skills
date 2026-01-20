# Archon Context Management for Claude Code

Hooks et commandes pour la gestion automatique du contexte Claude Code avec intégration Archon MCP.

## Fonctionnalités

- **Hooks automatiques** - Déclenchement sur PreCompact, SessionStart, Stop
- **Commandes slash** - /update, /followup, /followup_doctor
- **Intégration Archon MCP** - Synchronisation des tâches
- **project-state.xml** - État persistant du projet

## Structure

```
bmad-skills/
├── hooks/                        # Scripts PowerShell pour Claude Code
│   ├── context-manager.ps1       # Gestionnaire principal
│   ├── precompact-handler.ps1    # Handler PreCompact
│   └── session-start-handler.ps1 # Handler SessionStart
├── commands/                     # Slash commands
│   ├── update.md                 # /update
│   ├── followup.md               # /followup
│   └── followup_doctor.md        # /followup_doctor
├── settings-template.json        # Configuration hooks
├── _archive/                     # Ancien contenu (BMAD workflows)
└── README.md
```

## Installation Rapide

### 1. Hooks (global)

```powershell
# Créer le dossier
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\hooks"

# Copier les scripts
Copy-Item .\hooks\*.ps1 "$env:USERPROFILE\.claude\hooks\"
```

### 2. Commandes (par projet)

```powershell
# Dans votre projet
New-Item -ItemType Directory -Force -Path ".claude\commands"
Copy-Item .\commands\*.md ".claude\commands\"
```

### 3. Configuration

Fusionner `settings-template.json` dans `~/.claude/settings.json`

## Commandes

| Commande | Description |
|----------|-------------|
| `/update` | Synchronise Archon MCP et project-state.xml |
| `/followup` | Affiche l'état actuel du projet |
| `/followup_doctor` | Diagnostic de cohérence complet |

## Séquence Auto-Context

Quand le contexte atteint sa limite :

```
1. PreCompact hook → Rappel /update + /followup_doctor
2. Compactage automatique
3. SessionStart hook → Rappel /followup
```

## Configuration Requise

- Claude Code CLI avec support hooks
- PowerShell (Windows)
- Archon MCP Server (optionnel mais recommandé)
- Fichier project-state.xml dans votre projet

## Personnalisation

Dans les fichiers `commands/*.md`, remplacez :
- `YOUR_PROJECT_ID` → Votre Archon Project ID
- `YOUR_PROJECT_PATH` → Chemin vers votre projet

## Archive

Les anciens workflows BMAD (session-continue, auto-clear) sont dans `_archive/`.

## License

MIT
