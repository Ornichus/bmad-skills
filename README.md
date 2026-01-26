# Claude Code Skills & Hooks

Collection de skills (commandes) et hooks personnalisés pour Claude Code, optimisés pour la gestion de projet avec Archon MCP.

## Architecture du Système de Contexte

```
┌─────────────────────────────────────────────────────────────┐
│                    FLUX DE DONNÉES                          │
├─────────────────────────────────────────────────────────────┤
│  Claude Code API                                            │
│       │                                                     │
│       ▼                                                     │
│  statusline.ps1 ──► context-level.txt (ex: "44")           │
│       │                     │                               │
│       ▼                     ▼                               │
│  [Affichage]         stop-handler.ps1                       │
│  "Model | Context:         │                                │
│   [########----] 44%"      ▼                                │
│                      Si >= 90% ?                            │
│                      ├─ NON → Message standard              │
│                      └─ OUI → ALERTE CRITIQUE               │
│                              "Faites /update + /compact"    │
└─────────────────────────────────────────────────────────────┘
```

## Structure

```
claude-code-skills/
├── hooks/                       # Scripts PowerShell pour hooks Claude Code
│   ├── statusline.ps1           # Affichage + écrit context-level.txt
│   ├── stop-handler.ps1         # Alerte conditionnelle selon % contexte
│   ├── precompact-handler.ps1   # Handler pour PreCompact (100%)
│   ├── session-start-handler.ps1  # Handler pour SessionStart
│   └── context-manager.ps1      # (Legacy) Gestionnaire centralisé
├── commands/                    # Slash commands personnalisées
│   ├── update.md                # /update - Synchronise Archon MCP
│   ├── followup.md              # /followup - Affiche l'état du projet
│   ├── followup_doctor.md       # /followup_doctor - Diagnostic
│   └── setup-agent-browser.md   # /setup-agent-browser - Config Ralphy+WSL
├── docs/                        # Documentation additionnelle
│   └── AGENT-BROWSER-WINDOWS-WSL.md  # Config agent-browser Windows/WSL
├── settings-template.json       # Template de configuration hooks
└── README.md
```

## Installation

### 1. Copier les hooks

```powershell
# Créer le dossier hooks
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\hooks"

# Copier les scripts
Copy-Item .\hooks\*.ps1 "$env:USERPROFILE\.claude\hooks\"
```

### 2. Configurer la statusline

```powershell
# Copier la statusline
Copy-Item .\hooks\statusline.ps1 "$env:USERPROFILE\.claude\statusline.ps1"
```

### 3. Copier les commandes

```powershell
# Copier dans le dossier .claude/commands de votre projet
Copy-Item .\commands\*.md "VOTRE_PROJET\.claude\commands\"
```

### 4. Configurer settings.json

Ajouter ou fusionner le contenu de `settings-template.json` dans `~/.claude/settings.json`

## Hooks disponibles

### Stop (NOUVEAU - Proactif)
Se déclenche à la fin de chaque réponse.
- **Lit le niveau de contexte** depuis `context-level.txt`
- **Si >= 90%** → Alerte critique demandant `/update` + `/compact`
- **Si < 90%** → Rappel standard léger
- **Seuil configurable** dans le script (variable `$threshold`)

### PreCompact
Se déclenche automatiquement quand le contexte atteint 100%.
- Rappelle d'exécuter `/update` et `/followup_doctor`
- Assure la sauvegarde des données avant compactage

### SessionStart
Se déclenche au démarrage ou à la reprise d'une session.
- Rappelle d'exécuter `/followup` pour reprendre le contexte
- Rappelle le workflow iterate-test-fix si actif

## Statusline

La statusline affiche en temps réel:
```
Claude Opus 4.5 | Context: [##########----------] 44%
```

Elle écrit également le pourcentage dans `~/.claude/context-level.txt` pour permettre au hook Stop de le lire.

## Commandes disponibles

### /update
Synchronise l'état du projet entre Archon MCP et project-state.xml.

### /followup
Affiche l'état actuel du projet (tâches, événements, milestones).

### /followup_doctor
Diagnostic complet de cohérence Archon/XML.

### /setup-agent-browser
Configure agent-browser (Vercel) pour fonctionner avec Ralphy sur Windows/WSL.
Crée les wrappers nécessaires et vérifie l'installation.

## Séquence Auto-Context Management

### AVANT (Réactif - trop tard)
```
Contexte 100% → PreCompact → Alerte → Compactage → Perte potentielle
```

### APRÈS (Proactif - nouveau système)
```
Chaque réponse → Stop hook lit context-level.txt
    │
    ├─ < 90% → Message standard
    │
    └─ >= 90% → ALERTE CRITIQUE
                   │
                   └─ Utilisateur fait /update + /compact
                      AVANT d'atteindre 100%
```

## Configuration requise

- Claude Code avec support des hooks
- PowerShell (Windows)
- Archon MCP Server configuré (optionnel)
- Fichier project-state.xml dans votre projet (optionnel)

## Personnalisation

### Modifier le seuil d'alerte

Dans `hooks/stop-handler.ps1`, modifiez la variable:
```powershell
$threshold = 90  # Changez pour 80, 85, etc.
```

### Modifier le Project ID Archon

Dans les fichiers commands/*.md, remplacez l'UUID par votre propre Project ID Archon.

## Integration Ralphy

Ces skills sont compatibles avec [Ralphy](https://github.com/michaelshimeles/ralphy) pour l'execution autonome de taches.

### Agent-Browser sur Windows/WSL

Pour utiliser `ralphy --browser` sur Windows avec agent-browser dans WSL:

```powershell
# Voir la documentation complete
docs/AGENT-BROWSER-WINDOWS-WSL.md
```

**Resume rapide:**
1. Installer agent-browser dans WSL: `wsl -d Ubuntu -- npm install -g agent-browser`
2. Creer un wrapper `C:\Users\<USER>\bin\agent-browser.cmd`:
   ```batch
   @echo off
   wsl.exe -d Ubuntu -- npx agent-browser %*
   ```
3. Tester: `agent-browser --version`

## License

MIT
