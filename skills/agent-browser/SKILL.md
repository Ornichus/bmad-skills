---
name: agent-browser
description: Automates browser interactions for web testing, form filling, screenshots, and data extraction. Use when the user needs to navigate websites, interact with web pages, fill forms, take screenshots, test web applications, or extract information from web pages.
allowed-tools: Bash(wsl:*),Bash(agent-browser:*)
---

# Browser Automation with agent-browser (Windows/WSL)

**IMPORTANT**: Sur cette machine Windows, agent-browser fonctionne via WSL Ubuntu.
Toutes les commandes doivent être préfixées avec `wsl -d Ubuntu -- npx`

## Quick start

```bash
wsl -d Ubuntu -- npx agent-browser open <url>        # Navigate to page
wsl -d Ubuntu -- npx agent-browser snapshot -i       # Get interactive elements with refs
wsl -d Ubuntu -- npx agent-browser click @e1         # Click element by ref
wsl -d Ubuntu -- npx agent-browser fill @e2 "text"   # Fill input by ref
wsl -d Ubuntu -- npx agent-browser close             # Close browser
```

## Core workflow

1. Navigate: `wsl -d Ubuntu -- npx agent-browser open <url>`
2. Snapshot: `wsl -d Ubuntu -- npx agent-browser snapshot -i` (returns elements with refs like `@e1`, `@e2`)
3. Interact using refs from the snapshot
4. Re-snapshot after navigation or significant DOM changes

## Commands

### Navigation
```bash
wsl -d Ubuntu -- npx agent-browser open <url>      # Navigate to URL
wsl -d Ubuntu -- npx agent-browser back            # Go back
wsl -d Ubuntu -- npx agent-browser forward         # Go forward
wsl -d Ubuntu -- npx agent-browser reload          # Reload page
wsl -d Ubuntu -- npx agent-browser close           # Close browser
```

### Snapshot (page analysis)
```bash
wsl -d Ubuntu -- npx agent-browser snapshot            # Full accessibility tree
wsl -d Ubuntu -- npx agent-browser snapshot -i         # Interactive elements only (recommended)
wsl -d Ubuntu -- npx agent-browser snapshot -c         # Compact output
wsl -d Ubuntu -- npx agent-browser snapshot -d 3       # Limit depth to 3
wsl -d Ubuntu -- npx agent-browser snapshot -s "#main" # Scope to CSS selector
```

### Interactions (use @refs from snapshot)
```bash
wsl -d Ubuntu -- npx agent-browser click @e1           # Click
wsl -d Ubuntu -- npx agent-browser dblclick @e1        # Double-click
wsl -d Ubuntu -- npx agent-browser focus @e1           # Focus element
wsl -d Ubuntu -- npx agent-browser fill @e2 "text"     # Clear and type
wsl -d Ubuntu -- npx agent-browser type @e2 "text"     # Type without clearing
wsl -d Ubuntu -- npx agent-browser press Enter         # Press key
wsl -d Ubuntu -- npx agent-browser press Control+a     # Key combination
wsl -d Ubuntu -- npx agent-browser hover @e1           # Hover
wsl -d Ubuntu -- npx agent-browser check @e1           # Check checkbox
wsl -d Ubuntu -- npx agent-browser uncheck @e1         # Uncheck checkbox
wsl -d Ubuntu -- npx agent-browser select @e1 "value"  # Select dropdown
wsl -d Ubuntu -- npx agent-browser scroll down 500     # Scroll page
wsl -d Ubuntu -- npx agent-browser scrollintoview @e1  # Scroll element into view
wsl -d Ubuntu -- npx agent-browser drag @e1 @e2        # Drag and drop
wsl -d Ubuntu -- npx agent-browser upload @e1 file.pdf # Upload files
```

### Get information
```bash
wsl -d Ubuntu -- npx agent-browser get text @e1        # Get element text
wsl -d Ubuntu -- npx agent-browser get html @e1        # Get innerHTML
wsl -d Ubuntu -- npx agent-browser get value @e1       # Get input value
wsl -d Ubuntu -- npx agent-browser get attr @e1 href   # Get attribute
wsl -d Ubuntu -- npx agent-browser get title           # Get page title
wsl -d Ubuntu -- npx agent-browser get url             # Get current URL
wsl -d Ubuntu -- npx agent-browser get count ".item"   # Count matching elements
wsl -d Ubuntu -- npx agent-browser get box @e1         # Get bounding box
```

### Check state
```bash
wsl -d Ubuntu -- npx agent-browser is visible @e1      # Check if visible
wsl -d Ubuntu -- npx agent-browser is enabled @e1      # Check if enabled
wsl -d Ubuntu -- npx agent-browser is checked @e1      # Check if checked
```

### Screenshots & PDF
```bash
wsl -d Ubuntu -- npx agent-browser screenshot                  # Screenshot to stdout (base64)
wsl -d Ubuntu -- npx agent-browser screenshot /tmp/page.png    # Save to file (in WSL)
wsl -d Ubuntu -- npx agent-browser screenshot --full           # Full page
wsl -d Ubuntu -- npx agent-browser pdf /tmp/output.pdf         # Save as PDF
```

### Wait
```bash
wsl -d Ubuntu -- npx agent-browser wait @e1                     # Wait for element
wsl -d Ubuntu -- npx agent-browser wait 2000                    # Wait milliseconds
wsl -d Ubuntu -- npx agent-browser wait --text "Success"        # Wait for text
wsl -d Ubuntu -- npx agent-browser wait --url "**/dashboard"    # Wait for URL pattern
wsl -d Ubuntu -- npx agent-browser wait --load networkidle      # Wait for network idle
wsl -d Ubuntu -- npx agent-browser wait --fn "window.ready"     # Wait for JS condition
```

### Mouse control
```bash
wsl -d Ubuntu -- npx agent-browser mouse move 100 200      # Move mouse
wsl -d Ubuntu -- npx agent-browser mouse down left         # Press button
wsl -d Ubuntu -- npx agent-browser mouse up left           # Release button
wsl -d Ubuntu -- npx agent-browser mouse wheel 100         # Scroll wheel
```

### Semantic locators (alternative to refs)
```bash
wsl -d Ubuntu -- npx agent-browser find role button click --name "Submit"
wsl -d Ubuntu -- npx agent-browser find text "Sign In" click
wsl -d Ubuntu -- npx agent-browser find label "Email" fill "user@test.com"
wsl -d Ubuntu -- npx agent-browser find first ".item" click
wsl -d Ubuntu -- npx agent-browser find nth 2 "a" text
```

### Browser settings
```bash
wsl -d Ubuntu -- npx agent-browser set viewport 1920 1080      # Set viewport size
wsl -d Ubuntu -- npx agent-browser set device "iPhone 14"      # Emulate device
wsl -d Ubuntu -- npx agent-browser set geo 37.7749 -122.4194   # Set geolocation
wsl -d Ubuntu -- npx agent-browser set offline on              # Toggle offline mode
wsl -d Ubuntu -- npx agent-browser set media dark              # Emulate color scheme
```

### Cookies & Storage
```bash
wsl -d Ubuntu -- npx agent-browser cookies                     # Get all cookies
wsl -d Ubuntu -- npx agent-browser cookies set name value      # Set cookie
wsl -d Ubuntu -- npx agent-browser cookies clear               # Clear cookies
wsl -d Ubuntu -- npx agent-browser storage local               # Get all localStorage
wsl -d Ubuntu -- npx agent-browser storage local key           # Get specific key
wsl -d Ubuntu -- npx agent-browser storage local set k v       # Set value
wsl -d Ubuntu -- npx agent-browser storage local clear         # Clear all
```

### Tabs & Windows
```bash
wsl -d Ubuntu -- npx agent-browser tab                 # List tabs
wsl -d Ubuntu -- npx agent-browser tab new [url]       # New tab
wsl -d Ubuntu -- npx agent-browser tab 2               # Switch to tab
wsl -d Ubuntu -- npx agent-browser tab close           # Close tab
wsl -d Ubuntu -- npx agent-browser window new          # New window
```

### Frames
```bash
wsl -d Ubuntu -- npx agent-browser frame "#iframe"     # Switch to iframe
wsl -d Ubuntu -- npx agent-browser frame main          # Back to main frame
```

### Dialogs
```bash
wsl -d Ubuntu -- npx agent-browser dialog accept [text]  # Accept dialog
wsl -d Ubuntu -- npx agent-browser dialog dismiss        # Dismiss dialog
```

### JavaScript
```bash
wsl -d Ubuntu -- npx agent-browser eval "document.title"   # Run JavaScript
```

## Example: Form submission

```bash
wsl -d Ubuntu -- npx agent-browser open https://example.com/form
wsl -d Ubuntu -- npx agent-browser snapshot -i
# Output shows: textbox "Email" [ref=e1], textbox "Password" [ref=e2], button "Submit" [ref=e3]

wsl -d Ubuntu -- npx agent-browser fill @e1 "user@example.com"
wsl -d Ubuntu -- npx agent-browser fill @e2 "password123"
wsl -d Ubuntu -- npx agent-browser click @e3
wsl -d Ubuntu -- npx agent-browser wait --load networkidle
wsl -d Ubuntu -- npx agent-browser snapshot -i  # Check result
```

## Example: Test a local dev server

```bash
# Si le serveur tourne sur Windows localhost:3000, utiliser host.docker.internal ou l'IP Windows
wsl -d Ubuntu -- npx agent-browser open http://host.docker.internal:3000
wsl -d Ubuntu -- npx agent-browser snapshot -i
```

## Sessions (parallel browsers)

```bash
wsl -d Ubuntu -- npx agent-browser --session test1 open site-a.com
wsl -d Ubuntu -- npx agent-browser --session test2 open site-b.com
wsl -d Ubuntu -- npx agent-browser session list
```

## JSON output (for parsing)

Add `--json` for machine-readable output:
```bash
wsl -d Ubuntu -- npx agent-browser snapshot -i --json
wsl -d Ubuntu -- npx agent-browser get text @e1 --json
```

## Debugging

```bash
wsl -d Ubuntu -- npx agent-browser console                    # View console messages
wsl -d Ubuntu -- npx agent-browser errors                     # View page errors
wsl -d Ubuntu -- npx agent-browser highlight @e1              # Highlight element
```

## Notes importantes pour Windows/WSL

1. **Chemins de fichiers**: Les screenshots sont sauvegardés dans le système de fichiers WSL (ex: `/tmp/`). Pour accéder depuis Windows: `\\wsl$\Ubuntu\tmp\`

2. **Localhost**: Si ton serveur de dev tourne sur Windows, utilise `host.docker.internal` ou ton IP Windows au lieu de `localhost`

3. **Performance**: Le daemon persiste entre les commandes, donc les commandes suivantes sont rapides après le premier `open`
