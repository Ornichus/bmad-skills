# /setup-agent-browser - Configurer Agent-Browser pour Ralphy sur Windows/WSL

## Contexte

Ralphy avec `--browser` necessite agent-browser de Vercel. Sur Windows, agent-browser s'execute dans WSL Ubuntu mais Ralphy utilise Git Bash (`/usr/bin/bash`). Il faut creer des wrappers pour faire le pont.

## Instructions

Execute les etapes suivantes dans l'ordre:

### 1. Verifier les prerequis

```bash
# Verifier WSL Ubuntu
wsl.exe -d Ubuntu -- echo "WSL OK"

# Verifier si agent-browser est installe dans WSL
wsl.exe -d Ubuntu -- npm list -g agent-browser 2>/dev/null || echo "Non installe"
```

### 2. Installer agent-browser dans WSL (si necessaire)

```bash
wsl.exe -d Ubuntu -- npm install -g agent-browser
wsl.exe -d Ubuntu -- npx agent-browser install
```

### 3. Creer le dossier bin utilisateur (si necessaire)

```bash
mkdir -p ~/bin
# Ou sur Windows: mkdir -p /c/Users/$USER/bin
```

### 4. Creer le wrapper Bash (CRITIQUE pour Ralphy)

Creer le fichier `C:\Users\<USERNAME>\bin\agent-browser` (sans extension):

```bash
#!/bin/bash
# Wrapper agent-browser pour Git Bash -> WSL
wsl.exe -d Ubuntu -- npx agent-browser "$@"
```

Commande pour creer:
```bash
cat > /c/Users/$USER/bin/agent-browser << 'EOF'
#!/bin/bash
wsl.exe -d Ubuntu -- npx agent-browser "$@"
EOF
chmod +x /c/Users/$USER/bin/agent-browser
```

### 5. Creer le wrapper CMD (pour PowerShell)

Creer le fichier `C:\Users\<USERNAME>\bin\agent-browser.cmd`:

```batch
@echo off
wsl.exe -d Ubuntu -- npx agent-browser %*
```

### 6. Verifier le PATH

S'assurer que `C:\Users\<USERNAME>\bin` est dans le PATH Windows.

```powershell
# Verifier
$env:PATH -split ';' | Where-Object { $_ -match 'bin' }

# Ajouter si necessaire
[Environment]::SetEnvironmentVariable("PATH", "$env:PATH;$env:USERPROFILE\bin", "User")
```

### 7. Tests de validation

Executer tous ces tests et verifier qu'ils passent:

```bash
# Test 1: Version via bash
agent-browser --version
# Attendu: agent-browser 0.7.x

# Test 2: Version via PowerShell
powershell.exe -Command "agent-browser --version"
# Attendu: agent-browser 0.7.x

# Test 3: Test fonctionnel complet
agent-browser open https://example.com
agent-browser snapshot -i
agent-browser screenshot /tmp/test-setup.png
agent-browser close

# Test 4: Ralphy dry-run
ralphy --browser --dry-run "test agent-browser"
# Attendu: [INFO] Browser automation enabled (agent-browser)
```

## Criteres de succes

- [ ] `agent-browser --version` fonctionne dans Git Bash
- [ ] `agent-browser --version` fonctionne dans PowerShell
- [ ] `ralphy --browser --dry-run "test"` affiche "Browser automation enabled"
- [ ] Screenshot de test cree avec succes

## Depannage

### "/usr/bin/bash: agent-browser: command not found"
Le wrapper bash n'existe pas ou n'est pas executable.
Solution: Recreer le fichier sans extension et faire `chmod +x`

### "wsl.exe not found"
Utiliser le chemin complet `/mnt/c/Windows/System32/wsl.exe` dans le wrapper

### "npx agent-browser: command not found" dans WSL
Reinstaller: `wsl.exe -d Ubuntu -- npm install -g agent-browser`

### Screenshots vides
Installer Chromium: `wsl.exe -d Ubuntu -- npx agent-browser install`

## Architecture finale

```
Ralphy --browser
    |
    v
Git Bash (/usr/bin/bash)
    |
    v
~/bin/agent-browser (script bash)
    |
    v
wsl.exe -d Ubuntu -- npx agent-browser
    |
    v
WSL Ubuntu -> Chromium headless
```

## References

- Documentation complete: https://github.com/Ornichus/bmad-skills/blob/main/docs/AGENT-BROWSER-WINDOWS-WSL.md
- agent-browser GitHub: https://github.com/vercel-labs/agent-browser
- Ralphy GitHub: https://github.com/michaelshimeles/ralphy
