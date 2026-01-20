# Claude Code Skills & Hooks

Collection de skills (commandes) et hooks personnalisés pour Claude Code, optimisés pour la gestion de projet avec Archon MCP.

## Structure

```
archon-context-management/
├── hooks/                    # Scripts PowerShell pour hooks Claude Code
│   ├── context-manager.ps1   # Gestionnaire principal de contexte
│   ├── precompact-handler.ps1  # Handler pour PreCompact
│   └── session-start-handler.ps1  # Handler pour SessionStart
├── commands/                 # Slash commands personnalisées
│   ├── update.md             # /update - Synchronise Archon MCP et project-state.xml
│   ├── followup.md           # /followup - Affiche l'état du projet
│   └── followup_doctor.md    # /followup_doctor - Diagnostic de cohérence
├── settings-template.json    # Template de configuration hooks
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

### 2. Copier les commandes

```powershell
# Copier dans le dossier .claude/commands de votre projet
Copy-Item .\commands\*.md "VOTRE_PROJET\.claude\commands\"
```

### 3. Configurer settings.json

Ajouter ou fusionner le contenu de `settings-template.json` dans `~/.claude/settings.json`

## Hooks disponibles

### PreCompact
Se déclenche automatiquement quand le contexte approche sa limite.
- Rappelle d'exécuter `/update` et `/followup_doctor`
- Assure la sauvegarde des données avant compactage

### SessionStart
Se déclenche au démarrage ou à la reprise d'une session.
- Rappelle d'exécuter `/followup` pour reprendre le contexte

### Stop
Se déclenche à la fin de chaque réponse.
- Rappel léger pour `/update` si changements significatifs

## Commandes disponibles

### /update
Synchronise l'état du projet entre Archon MCP et project-state.xml.
- Met à jour les tâches (statuts, descriptions)
- Met à jour l'historique et les événements
- Crée de nouvelles tâches si nécessaire

### /followup
Affiche l'état actuel du projet.
- Tâches en cours et à faire
- Derniers événements
- Milestones récents

### /followup_doctor
Diagnostic complet de cohérence.
- Vérifie la synchronisation Archon/XML
- Vérifie l'existence des fichiers
- Détecte les anomalies et propose des corrections

## Séquence Auto-Context Management

Quand le contexte est bas (< 10% restant), la séquence suivante est recommandée :

1. **PreCompact hook** déclenche le rappel
2. Exécuter `/update` - Sauvegarder l'état
3. Exécuter `/followup_doctor` - Vérifier la cohérence
4. Compactage automatique
5. Exécuter `/followup` - Reprendre le contexte

## Configuration requise

- Claude Code avec support des hooks
- PowerShell (Windows)
- Archon MCP Server configuré
- Fichier project-state.xml dans votre projet

## Personnalisation

### Modifier le Project ID Archon

Dans les fichiers commands/*.md, remplacez l'UUID :
```
project_id="f4f5ee31-c24c-4a9a-b8f9-2417feee4dba"
```

Par votre propre Project ID Archon.

### Modifier les chemins

Dans followup_doctor.md, ajustez les chemins des fichiers à vérifier selon votre structure de projet.

## License

MIT
