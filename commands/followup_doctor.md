---
description: 'Diagnostic de cohérence entre Archon MCP, project-state.xml et fichiers réels'
---

# /followup_doctor - Diagnostic de cohérence du projet

Vérifie la cohérence entre Archon MCP, project-state.xml et l'état réel du projet.

## Instructions

### 1. Collecter les données

**Archon MCP:**
- `find_projects(project_id="YOUR_PROJECT_ID")`
- `find_tasks(project_id="YOUR_PROJECT_ID", per_page=50)`

**project-state.xml:**
- Lire: `YOUR_PROJECT_PATH/project-state.xml`

**État réel du projet:**
- Vérifier existence des fichiers clés
- Compter les scripts
- Vérifier les dossiers Documentation/
- Vérifier les backups

### 2. Vérifications de cohérence

| Vérification | Description |
|--------------|--------------|
| **SYNC-01** | Les tâches "done" dans Archon sont-elles dans `<completed>` du XML ? |
| **SYNC-02** | L'objectif actuel XML correspond-il aux tâches "doing" Archon ? |
| **SYNC-03** | Les milestones XML correspondent-ils aux tâches Archon ? |
| **FILE-01** | Les fichiers clés existent-ils ? Correspondent au XML ? |
| **FILE-02** | Les scripts mentionnés existent-ils ? |
| **FILE-03** | Les fichiers documentation existent-ils ? |
| **DATE-01** | La date `<last-updated>` est-elle récente ? |
| **TASK-01** | Y a-t-il des tâches "doing" depuis trop longtemps ? |
| **TASK-02** | Y a-t-il des tâches orphelines (dans XML mais pas Archon) ? |

### 3. Générer le rapport

## Format de sortie

```
# Diagnostic de Cohérence - [DATE]

## Résumé
| Catégorie | Status | Issues |
|-----------|--------|--------|
| Synchronisation Archon/XML | ✅/⚠️/❌ | X issues |
| Fichiers projet | ✅/⚠️/❌ | X issues |
| Dates et fraîcheur | ✅/⚠️/❌ | X issues |
| Tâches | ✅/⚠️/❌ | X issues |

## Détails des vérifications

### ✅ Vérifications OK
- [SYNC-01] Tâches synchronisées
- [FILE-01] Fichiers présents
- ...

### ⚠️ Avertissements
- [DATE-01] Dernière mise à jour il y a X jours
- ...

### ❌ Problèmes détectés
- [TASK-02] Tâche "XXX" dans XML mais pas dans Archon
- [FILE-02] Script "YYY" mentionné mais inexistant
- ...

## Actions recommandées
1. [PRIORITÉ HAUTE] ...
2. [PRIORITÉ MOYENNE] ...
3. [PRIORITÉ BASSE] ...

## Commandes de correction suggérées
- `/update` pour synchroniser Archon et XML
- Créer fichier manquant: ...
```

## Configuration

Remplacez ces valeurs dans votre copie locale:
- `YOUR_PROJECT_ID`: Votre Archon Project ID
- `YOUR_PROJECT_PATH`: Chemin vers votre projet

## Codes de status
- ✅ OK - Pas de problème
- ⚠️ Warning - Attention requise mais non bloquant
- ❌ Error - Problème à corriger
