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
     - `<last-conversation>` avec les 3 derniers messages échangés (voir ci-dessous)
   - Sauvegarder les modifications

4. **Capturer les 3 derniers messages de la conversation:**
   - Remonter dans le contexte de conversation actuel
   - Identifier les 3 derniers messages échangés entre l'utilisateur et l'agent (AVANT l'appel à /update)
   - Ne PAS inclure le message /update lui-même
   - Écrire ces messages dans la section `<last-conversation>` du XML
   - Format:
     ```xml
     <last-conversation updated="[ISO 8601 datetime]">
       <message role="user|assistant" index="1">[Résumé concis du message - max 200 chars]</message>
       <message role="user|assistant" index="2">[Résumé concis du message - max 200 chars]</message>
       <message role="user|assistant" index="3">[Résumé concis du message - max 200 chars]</message>
     </last-conversation>
     ```
   - Les messages sont ordonnés chronologiquement (1 = le plus ancien des 3, 3 = le plus récent)
   - Résumer chaque message de façon concise mais fidèle (max 200 caractères)
   - Si un message contient du code ou des résultats d'outils, résumer l'action et le résultat

5. **Confirmer** les mises à jour effectuées à l'utilisateur

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
- [x] Dernière conversation capturée (3 messages)

### Prochaines étapes
- ...
```

## Configuration

Remplacez ces valeurs dans votre copie locale:
- `YOUR_PROJECT_ID`: Votre Archon Project ID
- `YOUR_PROJECT_PATH`: Chemin vers votre projet
