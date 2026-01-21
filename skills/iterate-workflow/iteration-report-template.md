# Template: Rapport de Fin de Grande Étape

Ce template définit la structure obligatoire pour le rapport généré à la fin de chaque grande étape `/iterate`.

---

## Structure du Rapport

```markdown
# Rapport de Fin d'Étape: {NOM_GRANDE_ETAPE}

**Date:** {DATE}
**Durée:** {DUREE_ESTIMEE}
**Statut:** {COMPLETE|PARTIAL|BLOCKED}

---

## 1. Résumé Exécutif

{Description concise de ce qui a été accompli en 2-3 phrases}

---

## 2. État Avant/Après

### AVANT cette étape

| Catégorie | Quantité | Détails |
|-----------|----------|---------||
| **Pages/Vues** | {N} | {Liste: nom → description courte} |
| **Composants UI** | {N} | {Liste: nom → rôle} |
| **Boutons/Actions** | {N} | {Liste: label → action déclenchée → [Fonctionnel/Non-fonctionnel]} |
| **Sections/Blocs** | {N} | {Liste: nom → contenu} |
| **Fonctions métier** | {N} | {Liste: nom → ce qu'elle fait → [Fonctionnel/Non-fonctionnel]} |
| **Endpoints API** | {N} | {Liste: méthode + route → description} |
| **Tests** | {N} | {N passants / N total} |

### APRÈS cette étape

| Catégorie | Quantité | Delta | Détails |
|-----------|----------|-------|---------||
| **Pages/Vues** | {N} | {+X} | {Liste mise à jour} |
| **Composants UI** | {N} | {+X} | {Liste mise à jour} |
| **Boutons/Actions** | {N} | {+X} | {Liste mise à jour} |
| **Sections/Blocs** | {N} | {+X} | {Liste mise à jour} |
| **Fonctions métier** | {N} | {+X} | {Liste mise à jour} |
| **Endpoints API** | {N} | {+X} | {Liste mise à jour} |
| **Tests** | {N} | {+X} | {N passants / N total} |

---

## 3. Nouveautés Concrètes (Cette Étape)

### 3.1 Fonctionnalités Utilisateur

| Fonctionnalité | Description | Statut |
|----------------|-------------|--------||
| {Nom feature 1} | {Ce que l'utilisateur peut faire} | [Fonctionnel] |
| {Nom feature 2} | {Ce que l'utilisateur peut faire} | [Fonctionnel] |

### 3.2 Éléments Interface (UI)

#### Nouvelles Pages/Vues
| Page | Accès | Description |
|------|-------|-------------||
| {Nom page} | {URL ou navigation} | {Ce qu'elle affiche} |

#### Nouveaux Composants
| Composant | Emplacement | Rôle |
|-----------|-------------|------||
| {Nom composant} | {Où il apparaît} | {Ce qu'il fait} |

#### Nouveaux Boutons/Actions
| Label | Emplacement | Action déclenchée | Statut |
|-------|-------------|-------------------|--------||
| "{Texte bouton}" | {Où} | {Ce qui se passe au clic} | [Fonctionnel] |

#### Nouvelles Sections/Blocs
| Section | Page | Contenu |
|---------|------|---------||
| {Nom section} | {Page parent} | {Ce qu'elle contient} |

### 3.3 Capacités Techniques

#### Nouvelles Fonctions Métier
| Fonction | Module | Description | Statut |
|----------|--------|-------------|--------||
| `{nom_fonction}()` | {module} | {Ce qu'elle fait} | [Fonctionnel] |

#### Nouveaux Endpoints API
| Méthode | Route | Description | Statut |
|---------|-------|-------------|--------||
| {GET/POST/...} | `/api/{route}` | {Ce qu'il fait} | [Fonctionnel] |

#### Nouvelles Intégrations
| Service | Type | Description |
|---------|------|-------------||
| {Nom service} | {API/Library/etc.} | {Comment il est utilisé} |

---

## 4. Acceptance Criteria Validés

| AC# | Critère | Statut |
|-----|---------|--------||
| AC1 | Given {contexte}, When {action}, Then {résultat} | [PASS] |
| AC2 | Given {contexte}, When {action}, Then {résultat} | [PASS] |

---

## 5. Tests

### Résumé Tests
| Type | Passants | Échoués | Couverture |
|------|----------|---------|------------||
| Unit | {N} | {N} | {X%} |
| Integration | {N} | {N} | {X%} |
| E2E | {N} | {N} | - |
| **Total** | **{N}** | **{N}** | - |

### Nouveaux Tests Ajoutés
- `test_{nom}` - {Ce qu'il teste}
- `test_{nom}` - {Ce qu'il teste}

---

## 6. Non-Fonctionnel / À Compléter

| Élément | Raison | Priorité |
|---------|--------|----------||
| {Élément} | {Pourquoi pas fonctionnel} | {Haute/Moyenne/Basse} |

---

## 7. Prochaines Étapes Suggérées

1. {Action suivante logique}
2. {Action suivante logique}
3. {Action suivante logique}

---

## 8. Références

- **Stories complétées:** {Liste des story IDs}
- **Commits:** {Hashes ou messages}
- **Documentation mise à jour:** {Fichiers docs modifiés}
```

---

## Règles d'Utilisation

### Ce qui DOIT être inclus
- Tous les éléments concrets visibles/utilisables
- L'état fonctionnel de chaque élément (Fonctionnel/Non-fonctionnel)
- Le delta Avant/Après avec quantités précises
- Les labels exacts des boutons (entre guillemets)
- Les noms de fonctions avec parenthèses

### Ce qui NE DOIT PAS être inclus
- Noms de fichiers créés/modifiés
- Extraits de code source
- Détails d'implémentation interne
- Noms de classes/variables internes
- Chemins de fichiers

### Définition "Fonctionnel"
- **[Fonctionnel]**: L'élément fait ce qu'il est censé faire, testé et validé
- **[Non-fonctionnel]**: L'élément existe mais ne produit pas le résultat attendu
- **[Mock]**: L'élément utilise des données simulées, pas de vraie logique
- **[Partiel]**: L'élément fonctionne mais avec limitations documentées

### Quand générer ce rapport
1. À la fin de chaque grande étape `/iterate`
2. AVANT de demander la validation utilisateur
3. APRÈS que tous les tests passent

---

## Exemple Concret: Wave 4 Output

```markdown
# Rapport de Fin d'Étape: Wave 4 Output

**Date:** 2026-01-21
**Durée:** ~3h
**Statut:** COMPLETE

---

## 1. Résumé Exécutif

Système complet de génération de rapports avec 7 types de templates et export multi-format (Markdown, JSON, Excel, HTML). Les rapports sont générés automatiquement à partir des données d'analyse.

---

## 2. État Avant/Après

### AVANT cette étape

| Catégorie | Quantité | Détails |
|-----------|----------|---------||
| **Fonctions métier** | 45 | Orchestrator, Scoring, Matcher, Agents, Scrapers |
| **Tests** | 138 | 138 passants / 138 total |

### APRÈS cette étape

| Catégorie | Quantité | Delta | Détails |
|-----------|----------|-------|---------||
| **Fonctions métier** | 62 | +17 | + ReportGenerator (10), + Exporters (7) |
| **Tests** | 138 | +0 | 138 passants / 138 total (pas de régression) |

---

## 3. Nouveautés Concrètes

### 3.1 Fonctionnalités Utilisateur

| Fonctionnalité | Description | Statut |
|----------------|-------------|--------||
| Génération de rapports | Créer 7 types de rapports depuis les données d'analyse | [Fonctionnel] |
| Export multi-format | Exporter en Markdown, JSON, Excel ou HTML | [Fonctionnel] |
| Export bundle | Générer tous les rapports en une seule opération | [Fonctionnel] |

### 3.2 Capacités Techniques

#### Nouvelles Fonctions Métier
| Fonction | Module | Description | Statut |
|----------|--------|-------------|--------||
| `generate_executive_summary()` | output.generator | Résumé exécutif avec top solutions | [Fonctionnel] |
| `generate_comparison_table()` | output.generator | Tableau comparatif critères/solutions | [Fonctionnel] |
| `generate_evaluation_grid()` | output.generator | Grille d'évaluation complète | [Fonctionnel] |
| `generate_solution_sheet()` | output.generator | Fiche détaillée par solution | [Fonctionnel] |
| `generate_recommendation()` | output.generator | Recommandation avec justification | [Fonctionnel] |
| `generate_sources()` | output.generator | Liste des sources consultées | [Fonctionnel] |
| `generate_all()` | output.generator | Génération de tous les rapports | [Fonctionnel] |
| `export()` | output.exporters | Export bundle complet | [Fonctionnel] |
| `export_single()` | output.exporters | Export d'un seul rapport | [Fonctionnel] |
| `get_exporter()` | output.exporters | Factory pour créer un exporter | [Fonctionnel] |

#### Nouveaux Formats d'Export
| Format | Extension | Description | Statut |
|--------|-----------|-------------|--------||
| Markdown | .md | Rapports formatés Markdown | [Fonctionnel] |
| JSON | .json | Données structurées JSON | [Fonctionnel] |
| Excel | .xlsx | Classeur multi-feuilles | [Fonctionnel] |
| HTML | .html | Page web autonome | [Fonctionnel] |

---

## 4. Acceptance Criteria Validés

| AC# | Critère | Statut |
|-----|---------|--------||
| AC1 | Given données d'analyse, When génération rapport, Then 7 types disponibles | [PASS] |
| AC2 | Given rapport généré, When export Markdown, Then fichier .md créé | [PASS] |
| AC3 | Given rapport généré, When export Excel, Then classeur avec feuilles | [PASS] |

---

## 5. Tests

### Résumé Tests
| Type | Passants | Échoués |
|------|----------|---------||
| Existants | 138 | 0 |
| **Total** | **138** | **0** |

---

## 6. Non-Fonctionnel / À Compléter

| Élément | Raison | Priorité |
|---------|--------|----------||
| Tests spécifiques output | Non créés, imports validés seulement | Moyenne |

---

## 7. Prochaines Étapes Suggérées

1. Wave 5 Integration: CLI pour utilisation en ligne de commande
2. Tests E2E complets du workflow
3. Intégration BMAD skill
```
