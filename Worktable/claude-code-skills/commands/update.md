---
description: 'Met à jour Archon MCP et project-state.xml avec les changements récents'
---

# /update - Mise à jour Archon et Project State

Met à jour le suivi du projet dans Archon MCP et le fichier project-state.xml.

## Instructions

1. **Demander un résumé** à l'utilisateur de ce qui a été accompli (si pas déjà clair du contexte)

2. **Mettre à jour Archon MCP:**
   - Utiliser `find_tasks(project_id="YOUR_PROJECT_ID")` pour voir les tâches actuelles
   - Mettre à jour les tâches avec `manage_task("update", task_id="...", status="done", description="...")`
   - Créer de nouvelles tâches si nécessaire avec `manage_task("create", ...)`

3. **Mettre à jour project-state.xml:**
   - Lire le fichier: `YOUR_PROJECT_PATH/project-state.xml`
   - Mettre à jour:
     - `<last-updated>` avec la date/heure actuelle (format ISO 8601)
     - `<session-id>` si nouvelle session
     - `<current-objective>` si l'objectif a changé
     - `<tasks>` statuts des sous-tâches
     - `<history>` ajouter les événements récents
     - `<completed-milestone>` si un milestone est terminé
   - Sauvegarder les modifications

4. **Confirmer** les mises à jour effectuées à l'utilisateur

## Format de sortie

```
## Mise à jour effectuée

### Archon MCP
- [x] Tâche XXX marquée comme terminée
- [x] Nouvelle tâche YYY créée
- ...

### project-state.xml
- [x] Objectif actuel: ...
- [x] Événements ajoutés: ...
- [x] Statuts mis à jour: ...

### Prochaines étapes
- ...
```

## Configuration

Remplacez ces valeurs dans votre copie locale:
- `YOUR_PROJECT_ID`: Votre Archon Project ID
- `YOUR_PROJECT_PATH`: Chemin vers votre projet
