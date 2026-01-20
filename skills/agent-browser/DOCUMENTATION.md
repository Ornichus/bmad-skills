# Vercel Agent Browser CLI - Documentation Complete

## Table des Matieres

1. [Introduction](#introduction)
2. [Architecture et Fonctionnement](#architecture-et-fonctionnement)
3. [Pourquoi Agent Browser est Plus Fiable](#pourquoi-agent-browser-est-plus-fiable)
4. [Installation sur Windows via WSL](#installation-sur-windows-via-wsl)
5. [Commandes Principales](#commandes-principales)
6. [Workflow Optimal pour Agents IA](#workflow-optimal-pour-agents-ia)
7. [Integration avec Claude Code](#integration-avec-claude-code)
8. [Sessions et Mode Multi-Browser](#sessions-et-mode-multi-browser)
9. [Depannage](#depannage)
10. [References](#references)

---

## Introduction

**Vercel Agent Browser CLI** est un outil d'automatisation de navigateur headless concu specifiquement pour les agents IA. Il utilise Playwright sous le capot mais avec une approche innovante basee sur des "references condensees" qui le rend significativement plus fiable que les alternatives traditionnelles.

### Statistiques de Fiabilite (Source: Cole Medin)

| Outil | Taux de Reussite Premier Essai |
|-------|-------------------------------|
| Vercel Agent Browser CLI | **95%** |
| Playwright MCP | 80% |
| Chrome DevTools MCP | 75% |

### Caracteristiques Cles

- **Gratuit et Open Source** (Licence Apache-2.0)
- **CLI Rust rapide** avec fallback Node.js
- **Systeme de references** (`@e1`, `@e2`) pour interactions deterministes
- **Optimise pour les LLMs** - sortie condensee et token-efficient
- **Sessions isolees** pour tests paralleles

---

## Architecture et Fonctionnement

### Architecture Client-Daemon

```
+------------------+     +------------------+     +------------------+
|   CLI Rust       | --> |   Node.js Daemon | --> |   Playwright     |
|   (Binaire natif)|     |   (Gestion)      |     |   + Chromium     |
+------------------+     +------------------+     +------------------+
```

1. **CLI Rust** (binaire natif rapide) - Parse les commandes, communique avec le daemon
2. **Node.js Daemon** - Gere l'instance Playwright/Chromium
3. **Fallback** - Si le binaire natif n'est pas disponible, utilise Node.js directement

Le daemon demarre automatiquement a la premiere commande et persiste entre les commandes pour des operations rapides.

### Philosophie "Less is More"

Contrairement aux approches traditionnelles qui utilisent des selecteurs et des recherches (matching non-deterministe), Agent Browser:

1. **Visite le site** et prend un **snapshot**
2. **Condense** la structure en references pointant vers les elements interactifs
3. **Retourne** une version consolidee au LLM
4. L'agent utilise les **refs** (`@e1`, `@e2`) pour interagir de maniere deterministe

Cette approche reduit les erreurs car on ne depend pas de recherches/matching qui peuvent echouer.

---

## Pourquoi Agent Browser est Plus Fiable

### Approche Traditionnelle (Playwright MCP)

```
Agent -> Recherche selecteur -> Match elements -> Retry si echec -> Action
         (non-deterministe)     (peut echouer)
```

### Approche Agent Browser

```
Agent -> Snapshot -> References determinees -> Action directe avec @ref
         (structure complete)  (@e1, @e2, @e3)    (pas de recherche)
```

### Avantages

1. **Deterministe** - La reference pointe vers l'element exact du snapshot
2. **Rapide** - Pas de re-query du DOM necessaire
3. **Token-efficient** - Structure condensee envoyee au LLM
4. **Fiable** - Pas de dependance aux recherches qui peuvent echouer

---

## Installation sur Windows via WSL

> **IMPORTANT**: Agent Browser ne fonctionne PAS correctement sur Windows natif.
> Il FAUT utiliser WSL (Windows Subsystem for Linux) avec Ubuntu.

### Prerequis

- Windows 10/11 avec WSL2
- Ubuntu installe dans WSL
- Node.js 18+ installe dans Ubuntu

### Etape 1: Verifier/Installer WSL

```powershell
# Dans PowerShell (Admin)
wsl --install -d Ubuntu
```

### Etape 2: Installer Node.js dans WSL

```bash
# Dans WSL Ubuntu
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### Etape 3: Installer Agent Browser

```bash
# Dans WSL Ubuntu
npm install -g agent-browser
```

### Etape 4: Installer Chromium

```bash
# Telecharger Chromium
agent-browser install

# OU avec npx si le PATH n'est pas configure
npx agent-browser install
```

### Etape 5: Installer les Dependances Systeme (CRITIQUE)

```bash
# Cette etape est OBLIGATOIRE sur Linux/WSL
sudo npx playwright install-deps chromium

# OU manuellement si la commande ci-dessus ne fonctionne pas:
sudo apt-get update
sudo apt-get install -y \
    libnspr4 \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    libatspi2.0-0 \
    libxshmfence1
```

### Etape 6: Verifier l'Installation

```bash
# Tester que tout fonctionne
npx agent-browser open https://example.com
npx agent-browser snapshot -i
npx agent-browser close
```

---

## Commandes Principales

### Workflow de Base

```bash
# 1. Ouvrir une URL
agent-browser open <url>

# 2. Prendre un snapshot (elements interactifs)
agent-browser snapshot -i

# 3. Interagir avec les references
agent-browser click @e1
agent-browser fill @e2 "texte"

# 4. Fermer
agent-browser close
```

### Navigation

```bash
agent-browser open <url>      # Naviguer vers URL
agent-browser back            # Page precedente
agent-browser forward         # Page suivante
agent-browser reload          # Recharger
agent-browser close           # Fermer le navigateur
```

### Snapshot (Analyse de Page)

```bash
agent-browser snapshot            # Arbre d'accessibilite complet
agent-browser snapshot -i         # Elements interactifs seulement (RECOMMANDE)
agent-browser snapshot -c         # Sortie compacte
agent-browser snapshot -d 3       # Limiter profondeur a 3
agent-browser snapshot -s "#main" # Limiter a un selecteur CSS
agent-browser snapshot -i --json  # Format JSON pour parsing
```

### Interactions (avec @refs du snapshot)

```bash
agent-browser click @e1           # Clic
agent-browser dblclick @e1        # Double-clic
agent-browser fill @e2 "texte"    # Effacer et taper
agent-browser type @e2 "texte"    # Taper sans effacer
agent-browser press Enter         # Appuyer sur touche
agent-browser press Control+a     # Combinaison de touches
agent-browser hover @e1           # Survol
agent-browser check @e1           # Cocher checkbox
agent-browser uncheck @e1         # Decocher checkbox
agent-browser select @e1 "value"  # Selectionner dropdown
agent-browser scroll down 500     # Defiler page
agent-browser scrollintoview @e1  # Amener element en vue
agent-browser drag @e1 @e2        # Glisser-deposer
agent-browser upload @e1 file.pdf # Telecharger fichier
```

### Obtenir des Informations

```bash
agent-browser get text @e1        # Texte de l'element
agent-browser get html @e1        # innerHTML
agent-browser get value @e1       # Valeur input
agent-browser get attr @e1 href   # Attribut specifique
agent-browser get title           # Titre de la page
agent-browser get url             # URL actuelle
agent-browser get count ".item"   # Compter elements
agent-browser get box @e1         # Bounding box
```

### Screenshots et PDF

```bash
agent-browser screenshot          # Screenshot vers stdout
agent-browser screenshot page.png # Sauvegarder fichier
agent-browser screenshot --full   # Page complete
agent-browser pdf output.pdf      # Sauvegarder en PDF
```

### Attente

```bash
agent-browser wait @e1                     # Attendre element
agent-browser wait 2000                    # Attendre millisecondes
agent-browser wait --text "Success"        # Attendre texte
agent-browser wait --url "**/dashboard"    # Attendre pattern URL
agent-browser wait --load networkidle      # Attendre fin reseau
agent-browser wait --fn "window.ready"     # Attendre condition JS
```

---

## Workflow Optimal pour Agents IA

### Workflow Recommande

```bash
# 1. Naviguer et obtenir snapshot
agent-browser open https://example.com
agent-browser snapshot -i --json   # L'IA parse l'arbre et les refs

# 2. L'IA identifie les refs cibles depuis le snapshot
# 3. Executer les actions avec les refs
agent-browser click @e2
agent-browser fill @e3 "texte input"

# 4. Nouveau snapshot si la page a change
agent-browser snapshot -i --json
```

### Exemple Complet: Soumission de Formulaire

```bash
# Ouvrir la page du formulaire
agent-browser open https://example.com/form

# Obtenir les elements interactifs
agent-browser snapshot -i
# Sortie:
# - textbox "Email" [ref=e1]
# - textbox "Password" [ref=e2]
# - button "Submit" [ref=e3]

# Remplir le formulaire
agent-browser fill @e1 "user@example.com"
agent-browser fill @e2 "password123"
agent-browser click @e3

# Attendre et verifier
agent-browser wait --load networkidle
agent-browser snapshot -i  # Verifier resultat
```

---

## Integration avec Claude Code

> **IMPORTANT pour Windows**: Le skill doit etre adapte pour utiliser WSL.
> Toutes les commandes doivent etre prefixees avec `wsl -d Ubuntu -- npx`

### Methode 1: Skill pour un Projet Specifique

Copiez le dossier `skills/agent-browser/` dans votre projet:

```powershell
# PowerShell - copier vers un projet
xcopy /E /I "skills\agent-browser" "C:\chemin\vers\ton-projet\.claude\skills\agent-browser"
```

### Methode 2: Skill Global (Tous les Projets)

Pour que le skill soit disponible dans TOUS vos projets Claude Code:

```powershell
# PowerShell - installer globalement
xcopy /E /I "skills\agent-browser" "%USERPROFILE%\.claude\skills\agent-browser"
```

### Methode 3: Instructions dans CLAUDE.md

Ajoutez a votre fichier `CLAUDE.md`:

```markdown
## Browser Automation (Windows/WSL)

Use agent-browser via WSL for web automation:

Core workflow:
1. `wsl -d Ubuntu -- npx agent-browser open <url>` - Navigate to page
2. `wsl -d Ubuntu -- npx agent-browser snapshot -i` - Get interactive elements with refs (@e1, @e2)
3. `wsl -d Ubuntu -- npx agent-browser click @e1` / `fill @e2 "text"` - Interact using refs
4. `wsl -d Ubuntu -- npx agent-browser close` - Close browser

Note: Pour acceder a localhost Windows depuis WSL, utiliser `host.docker.internal`
```

### Acces a Localhost Windows depuis WSL

Si votre serveur de dev tourne sur Windows (ex: `npm run dev` sur port 3000):

```bash
# Depuis WSL, utiliser host.docker.internal au lieu de localhost
wsl -d Ubuntu -- npx agent-browser open http://host.docker.internal:3000
```

---

## Sessions et Mode Multi-Browser

### Sessions Isolees

Executez plusieurs instances de navigateur isolees:

```bash
# Sessions differentes
agent-browser --session agent1 open site-a.com
agent-browser --session agent2 open site-b.com

# Lister les sessions actives
agent-browser session list
```

Chaque session a ses propres:
- Instance de navigateur
- Cookies et stockage
- Historique de navigation
- Etat d'authentification

### Mode Headed (Debug)

Afficher la fenetre du navigateur pour le debug:

```bash
agent-browser open example.com --headed
```

---

## Depannage

### Erreur: "command not found: agent-browser"

```bash
# Option 1: Utiliser npx
npx agent-browser <commande>

# Option 2: Ajouter au PATH
export PATH="$PATH:$(npm config get prefix)/bin"
```

### Erreur: "libnspr4.so: cannot open shared object file"

Les dependances systeme manquent:

```bash
sudo apt-get update
sudo apt-get install -y libnspr4 libnss3 libatk1.0-0 libatk-bridge2.0-0 \
    libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 libxfixes3 \
    libxrandr2 libgbm1 libpango-1.0-0 libcairo2 libasound2

# Ou utilisez la commande Playwright
sudo npx playwright install-deps chromium
```

### Erreur sur Windows

Agent Browser ne fonctionne pas nativement sur Windows. Utilisez WSL:

```powershell
# Installer WSL si necessaire
wsl --install -d Ubuntu

# Executer dans WSL
wsl -d Ubuntu -- npx agent-browser open https://example.com
```

---

## References

### Liens Officiels

- **GitHub Repository**: https://github.com/vercel-labs/agent-browser
- **Video Explicative**: https://www.youtube.com/watch?v=7aEQnTsI6zs
- **Blog Vercel (Philosophie)**: https://vercel.com/blog/we-removed-80-percent-of-our-agents-tools

### Version Actuelle

- **Package**: `agent-browser@0.6.0`
- **Playwright**: `^1.57.0`
- **Licence**: Apache-2.0

---

## Resume des Commandes Essentielles

```bash
# Installation (WSL Ubuntu)
npm install -g agent-browser
npx agent-browser install
sudo npx playwright install-deps chromium

# Workflow de base (depuis Windows)
wsl -d Ubuntu -- npx agent-browser open <url>
wsl -d Ubuntu -- npx agent-browser snapshot -i
wsl -d Ubuntu -- npx agent-browser click @e1
wsl -d Ubuntu -- npx agent-browser fill @e2 "text"
wsl -d Ubuntu -- npx agent-browser close
```

---

*Documentation creee le 20/01/2026 - Basee sur agent-browser v0.6.0*
