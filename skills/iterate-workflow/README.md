# Iterate Workflow Skill

Workflow de développement itératif avec rapport de fin d'étape structuré.

## Contenu

- `iteration-report-template.md` - Template complet pour le rapport de fin de grande étape

## Utilisation

Le template est utilisé par la commande `/iterate` pour générer un rapport concret à la fin de chaque grande étape de développement.

### Caractéristiques du Rapport

1. **État Avant/Après** - Comparaison quantitative du projet
2. **Nouveautés Concrètes** - Fonctionnalités, UI, capacités techniques
3. **Statuts Fonctionnels** - [Fonctionnel], [Non-fonctionnel], [Mock], [Partiel]
4. **Acceptance Criteria** - Format Given/When/Then
5. **Tests** - Résumé passants/échoués

### Ce qui est EXCLU

- Noms de fichiers
- Extraits de code
- Détails d'implémentation
- Chemins de fichiers

## Intégration

Pour utiliser ce workflow dans un projet:

1. Copier `iteration-report-template.md` vers `.claude/templates/`
2. Ajouter la référence dans le skill `/iterate` du projet
3. Ajouter une section "Rapport de Fin d'Étape" dans CLAUDE.md

## Lié à

- `/iterate` - Commande d'orchestration
- `/test` - Commande de test
- `/update` - Synchronisation après validation
