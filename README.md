# Archon Context Management for Claude Code

Hooks, commandes et skills pour la gestion automatique du contexte Claude Code avec integration Archon MCP.

## Fonctionnalites

- **Hooks automatiques** - Declenchement sur PreCompact, SessionStart, Stop
- **Commandes slash** - /update, /followup, /followup_doctor
- **Skills Claude Code** - agent-browser pour l'automatisation navigateur
- **Integration Archon MCP** - Synchronisation des taches
- **project-state.xml** - Etat persistant du projet

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
├── skills/                       # Skills Claude Code
│   └── agent-browser/            # Automatisation navigateur
│       ├── SKILL.md              # Skill pour Claude Code
│       └── DOCUMENTATION.md      # Documentation complete
├── settings-template.json        # Configuration hooks
├── _archive/                     # Ancien contenu (BMAD workflows)
└── README.md
```

## Installation Rapide

### 1. Hooks (global)

```powershell
# Creer le dossier
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

### 3. Skills (par projet ou global)

```powershell
# Par projet
New-Item -ItemType Directory -Force -Path ".claude\skills"
Copy-Item -Recurse .\skills\* ".claude\skills\"

# OU global (tous les projets)
Copy-Item -Recurse .\skills\* "$env:USERPROFILE\.claude\skills\"
```

### 4. Configuration

Fusionner `settings-template.json` dans `~/.claude/settings.json`

## Skills Disponibles

### agent-browser

Automatisation de navigateur pour les agents IA utilisant Vercel Agent Browser CLI.

**Caracteristiques:**
- Taux de reussite 95% (vs 75-80% pour Playwright MCP)
- Systeme de references (`@e1`, `@e2`) pour interactions deterministes
- Optimise pour Windows via WSL

**Usage rapide:**
```bash
wsl -d Ubuntu -- npx agent-browser open <url>
wsl -d Ubuntu -- npx agent-browser snapshot -i
wsl -d Ubuntu -- npx agent-browser click @e1
wsl -d Ubuntu -- npx agent-browser close
```

Voir [skills/agent-browser/DOCUMENTATION.md](skills/agent-browser/DOCUMENTATION.md) pour l'installation complete.

## Commandes

| Commande | Description |
|----------|-------------|
| `/update` | Synchronise Archon MCP et project-state.xml |
| `/followup` | Affiche l'etat actuel du projet |
| `/followup_doctor` | Diagnostic de coherence complet |

## Sequence Auto-Context

Quand le contexte atteint sa limite :

```
1. PreCompact hook -> Rappel /update + /followup_doctor
2. Compactage automatique
3. SessionStart hook -> Rappel /followup
```

## Configuration Requise

- Claude Code CLI avec support hooks
- PowerShell (Windows)
- WSL Ubuntu (pour agent-browser)
- Archon MCP Server (optionnel mais recommande)
- Fichier project-state.xml dans votre projet

## Personnalisation

Dans les fichiers `commands/*.md`, remplacez :
- `YOUR_PROJECT_ID` -> Votre Archon Project ID
- `YOUR_PROJECT_PATH` -> Chemin vers votre projet

## Archive

Les anciens workflows BMAD (session-continue, auto-clear) sont dans `_archive/`.

## License

MIT
