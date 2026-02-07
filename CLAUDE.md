# BMAD Skills Repository

Centre névralgique pour les agents Claude - workflows, commandes et configurations.

**Archon Project ID:** `9d52fe50-d47c-42f5-9081-f922b6845ba9`

## Structure du Repo

```
BMAD-SKills/
├── .claude/
│   └── commands/            # Commandes BMAD installées (slash commands)
├── _bmad/
│   ├── bmb/                 # BMAD Module Builder
│   ├── bmm/                 # BMAD Method
│   ├── cis/                 # Creative & Innovation Skills
│   ├── tea/                 # Testing & Automation
│   └── core/                # Configuration et manifests
├── _bmad-output/            # Outputs générés par BMAD
└── Worktable/               # Zone de travail (pas encore mature)
    └── claude-code-skills/  # [EN COURS] Skills & Hooks Claude Code
```

## Utilisation

### Pour les agents travaillant sur des projets

1. **Copier les commandes** depuis `.claude/commands/` vers le projet cible
2. **Utiliser les workflows BMAD** pour créer/modifier des agents et modules
3. **Consulter `_bmad/`** pour les ressources et templates

### Commandes disponibles (.claude/commands/)

- **BMAD Agents** (`/bmad-agent-*`) - Invoquer des agents spécialisés
- **BMAD Builder** (`/bmad-bmb-*`) - Créer/éditer des agents, modules, workflows
- **BMAD Method** (`/bmad-bmm-*`) - Workflows de développement (PRD, stories, sprints)
- **Creative & Innovation** (`/bmad-cis-*`) - Brainstorming, storytelling, design thinking
- **Testing** (`/bmad-tea-*`) - Test architecture et automatisation

---

## Worktable (Zone de travail)

Contenu **pas encore mature** - en cours de développement/test.

### claude-code-skills/ (anciennement bmad-skills repo)

Système de gestion du contexte Claude Code avec alertes proactives.

**Contenu:**
- `hooks/` - Scripts PowerShell (statusline, stop-handler, precompact, session-start)
- `commands/` - /update, /followup, /followup_doctor, /setup-agent-browser
- `skills/` - iterate-workflow, project-state-management, agent-browser, ralph-workflow
- `docs/` - Documentation agent-browser Windows/WSL
- `_archive/` - Anciens workflows archivés

**Status:** En test - à intégrer proprement après validation.

---

## Conventions

- Les agents consultent ce repo comme référence centrale
- `Worktable/` = staging zone pour éléments non matures
- Seul le contenu hors Worktable est considéré "stable"
