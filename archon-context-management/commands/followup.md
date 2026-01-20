---
description: 'Affiche état du projet depuis Archon MCP et project-state.xml'
---

# /followup - Lecture état du projet

Affiche l'état actuel du projet depuis Archon MCP et project-state.xml.

## Instructions

1. **Lire Archon MCP:**
   - `find_projects(project_id="YOUR_PROJECT_ID")` pour le projet
   - `find_tasks(project_id="YOUR_PROJECT_ID", filter_by="status", filter_value="doing")` pour tâches en cours
   - `find_tasks(project_id="YOUR_PROJECT_ID", filter_by="status", filter_value="todo", per_page=10)` pour tâches à faire

2. **Lire project-state.xml:**
   - Fichier: `YOUR_PROJECT_PATH/project-state.xml`
   - Extraire les informations clés

3. **Afficher un résumé structuré**

## Format de sortie

```
# État du Projet: [PROJECT_NAME]

## Objectif Actuel
**[NOM_OBJECTIF]** - Status: [STATUS]

## Tâches en Cours (Archon)
| Tâche | Assignée à | Feature |
|-------|------------|--------|
| ... | ... | ... |

## Prochaines Tâches (Archon)
| Tâche | Priorité | Feature |
|-------|----------|--------|
| ... | ... | ... |

## Tâches en Pause
- ...

## Derniers Événements (project-state.xml)
- [DATE] - Événement 1
- [DATE] - Événement 2
- ...

## Milestones Récents
- [x] Milestone 1
- [x] Milestone 2
- ...

## Ressources Clés
- File1: [STATUS]
- Scripts: [COUNT] scripts
- Documentation: [FILES]
```

## Configuration

Remplacez ces valeurs dans votre copie locale:
- `YOUR_PROJECT_ID`: Votre Archon Project ID
- `YOUR_PROJECT_PATH`: Chemin vers votre projet
