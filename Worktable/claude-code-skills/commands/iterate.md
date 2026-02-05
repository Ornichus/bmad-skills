---
description: 'Boucle autonome test-fix-test avec rapport de fin d étape structuré'
---

# /iterate - Boucle Autonome Test-Fix-Test

Orchestration automatisée de la boucle de développement:
**production → tests → correction → boucle jusqu'à validation**

## Paramètres

```
/iterate [grande-etape] [--resume]
```

- `grande-etape`: Nom ou ID de la grande étape à traiter (optionnel, détecté automatiquement)
- `--resume`: Reprendre une boucle interrompue

## Machine d'États

```
GRANDE ÉTAPE N
│
├── Sous-étape 1
│   └── IMPL → /test → [FAIL? → fix → re-test (max 10x)] → PASS
├── Sous-étape 2
│   └── IMPL → /test → [FAIL? → fix → re-test (max 10x)] → PASS
└── Sous-étape N
    └── IMPL → /test → PASS

→ TOUTES sous-étapes PASS
→ Générer Rapport de Fin d'Étape
→ Signaler "Grande étape terminée"
→ USER valide
→ COMMIT + /update
→ Passer à GRANDE ÉTAPE N+1
```

## Instructions pour l'Agent

### 1. Initialisation

1. **Charger le contexte projet** (Archon ou autre système de tâches)
2. **Identifier la grande étape courante** depuis les tâches (feature grouping)
3. **Lister les sous-étapes** de cette grande étape

### 2. Boucle Principale (par sous-étape)

Pour CHAQUE sous-étape:

```python
iteration = 0
MAX_ITERATIONS = 10

while not tests_passed and iteration < MAX_ITERATIONS:
    if iteration == 0:
        implement_substep()
    else:
        fix_based_on_test_analysis()

    test_result = run_test()  # Appelle /test

    if test_result.passed:
        tests_passed = True
        mark_substep_complete()
    else:
        iteration += 1
        analyze_failure(test_result)

if iteration >= MAX_ITERATIONS:
    request_user_help()
```

### 3. Détection du Type de Test

| Cible | Détection | Commande |
|-------|-----------|----------|
| Frontend | `*.tsx`, `*.jsx`, composants React | `/test frontend` |
| Backend | `*.py`, endpoints API, services | `/test backend` |
| Mixte | Interaction frontend+backend | `/test integration` |

### 4. Fin de Grande Étape

Quand TOUTES les sous-étapes sont PASS:

1. **Générer le Rapport de Fin d'Étape** (OBLIGATOIRE)

   Utiliser le template: `skills/iterate-workflow/iteration-report-template.md`

   Le rapport DOIT inclure:
   - **État Avant/Après**: Quantités précises de pages, boutons, fonctions, etc.
   - **Nouveautés Concrètes**: Fonctionnalités, UI, capacités techniques
   - **Statut Fonctionnel**: Chaque élément marqué [Fonctionnel]/[Non-fonctionnel]/[Mock]/[Partiel]
   - **Acceptance Criteria**: Liste des AC validés
   - **Tests**: Résumé avec passants/échoués

2. **Afficher le rapport puis signaler la completion:**
   ```
   ══════════════════════════════════════════════════════
   ✅ GRANDE ÉTAPE TERMINÉE: [NOM_ETAPE]
   ══════════════════════════════════════════════════════

   [RAPPORT DE FIN D'ÉTAPE]

   ══════════════════════════════════════════════════════
   Sous-étapes complétées:
   - [x] Sous-étape 1
   - [x] Sous-étape 2
   - [x] Sous-étape N

   🔔 En attente de validation utilisateur...
   ══════════════════════════════════════════════════════
   ```

3. **Attendre validation user** (NE PAS continuer sans validation)

4. **Après validation:**
   - Créer un commit descriptif
   - Exécuter `/update` pour synchroniser le suivi
   - Passer à la grande étape suivante

### 4.1 Template du Rapport de Fin d'Étape

**Référence complète:** `skills/iterate-workflow/iteration-report-template.md`

**Structure minimale obligatoire:**

```markdown
# Rapport de Fin d'Étape: {NOM}

## État Avant/Après

### AVANT
| Catégorie | Qté | Détails |
|-----------|-----|---------|
| Pages/Vues | {N} | {liste} |
| Boutons/Actions | {N} | {label → action → [statut]} |
| Fonctions métier | {N} | {nom() → description → [statut]} |
| Tests | {N} | {passants/total} |

### APRÈS
| Catégorie | Qté | Delta | Détails |
|-----------|-----|-------|---------|
| Pages/Vues | {N} | +{X} | {liste mise à jour} |
| Boutons/Actions | {N} | +{X} | {liste mise à jour} |
| Fonctions métier | {N} | +{X} | {liste mise à jour} |
| Tests | {N} | +{X} | {passants/total} |

## Nouveautés Concrètes

### Fonctionnalités
| Feature | Description | Statut |
|---------|-------------|--------|
| {nom} | {ce que l'user peut faire} | [Fonctionnel] |

### Boutons Ajoutés
| Label | Emplacement | Action | Statut |
|-------|-------------|--------|--------|
| "{texte}" | {où} | {ce qui se passe} | [Fonctionnel] |

### Fonctions Ajoutées
| Fonction | Description | Statut |
|----------|-------------|--------|
| `nom()` | {ce qu'elle fait} | [Fonctionnel] |

## Tests
| Type | Passants | Échoués |
|------|----------|---------||
| Total | {N} | {N} |
```

**Règles:**
- NE PAS lister les fichiers créés/modifiés
- NE PAS montrer de code
- TOUJOURS indiquer le statut fonctionnel de chaque élément
- Labels de boutons entre guillemets
- Noms de fonctions avec parenthèses

### 5. Gestion des Échecs (10 itérations atteintes)

```
══════════════════════════════════════════════════════
⚠️ AIDE REQUISE - Max itérations atteint

Sous-étape: [NOM]
Itérations: 10/10
Dernier échec: [DESCRIPTION]

Analyse du problème:
[ANALYSE_DETAILLEE]

Actions tentées:
1. [ACTION_1]
2. [ACTION_2]
...

Suggestions:
- [SUGGESTION_1]
- [SUGGESTION_2]

🔔 Intervention utilisateur requise
══════════════════════════════════════════════════════
```

## Variables d'État

L'agent doit maintenir ces variables:

```yaml
iterate_state:
  grande_etape: "B3-Config"
  sous_etapes:
    - name: "Setup environment"
      status: "done"
      iterations: 2
    - name: "Implement core logic"
      status: "in_progress"
      iterations: 5
    - name: "Add tests"
      status: "pending"
      iterations: 0
  current_substep: 1
  total_iterations: 7
```

## Exemple d'Exécution

```
> /iterate B3-Config

🔄 GRANDE ÉTAPE: B3-Config
   3 sous-étapes détectées

📍 Sous-étape 1/3: Setup environment variables
   Iteration 1/10...
   ✅ Tests passés

📍 Sous-étape 2/3: Implement config service
   Iteration 1/10...
   ❌ Test échoué - Analysing...
   Iteration 2/10...
   ❌ Test échoué - Missing dependency
   Iteration 3/10...
   ✅ Tests passés

📍 Sous-étape 3/3: Add validation
   Iteration 1/10...
   ✅ Tests passés

══════════════════════════════════════════════════════
✅ GRANDE ÉTAPE TERMINÉE: B3-Config
══════════════════════════════════════════════════════

# Rapport de Fin d'Étape: B3-Config

## État Avant/Après
[... rapport complet ...]

══════════════════════════════════════════════════════
🔔 En attente de validation utilisateur...
══════════════════════════════════════════════════════
```
