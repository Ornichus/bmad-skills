# BMAD Skills

Centre névralgique pour les agents Claude Code - workflows, commandes, skills et configurations.

## Structure

```
bmad-skills/
├── .claude/commands/        # Commandes slash installées
├── _bmad/                   # BMAD Framework
│   ├── bmb/                 # Module Builder (agents, modules, workflows)
│   ├── bmm/                 # BMAD Method (PRD, stories, sprints)
│   ├── cis/                 # Creative & Innovation Skills
│   ├── tea/                 # Testing & Automation
│   └── core/                # Configuration et manifests
├── _bmad-output/            # Artifacts générés
├── Worktable/               # Zone de travail (en développement)
│   └── claude-code-skills/  # Hooks & Skills Claude Code
└── CLAUDE.md                # Instructions pour Claude
```

## Utilisation

### Installation rapide

```bash
# Cloner le repo
git clone https://github.com/Ornichus/bmad-skills.git

# Copier les commandes vers votre projet
cp -r bmad-skills/.claude/commands/ VOTRE_PROJET/.claude/commands/
```

### Commandes disponibles

| Catégorie | Préfixe | Description |
|-----------|---------|-------------|
| **Agents BMAD** | `/bmad-agent-*` | Invoquer des agents spécialisés |
| **Builder** | `/bmad-bmb-*` | Créer/éditer agents, modules, workflows |
| **Method** | `/bmad-bmm-*` | PRD, stories, sprints, reviews |
| **Creative** | `/bmad-cis-*` | Brainstorming, storytelling, innovation |
| **Testing** | `/bmad-tea-*` | Test architecture et automatisation |

## Worktable

Le dossier `Worktable/` contient des éléments **en cours de développement** :

- **claude-code-skills/** - Hooks et skills pour Claude Code (statusline, alertes contexte, etc.)

Ces éléments ne sont pas encore matures et seront intégrés proprement après validation.

## Documentation

Voir [CLAUDE.md](CLAUDE.md) pour les instructions détaillées destinées aux agents Claude.

## Prérequis

- Claude Code CLI
- PowerShell (Windows) pour les hooks
- [Archon MCP Server](https://github.com/anthropics/archon) (optionnel)

## License

MIT
