# Archived Content

This folder contains the original BMAD workflows that have been superseded by the new Archon Context Management system.

## Why Archived?

The original workflows (session-continue, auto-clear) were designed for a different approach to context management. The new Archon-based hooks and commands provide:

- **Native Claude Code hooks** instead of manual workflow triggers
- **Automatic activation** on PreCompact and SessionStart events
- **Simpler slash commands** (/update, /followup, /followup_doctor)
- **Direct Archon MCP integration**

## Contents

- `workflows/` - Original BMAD workflow files
- `examples/` - Original example files
- `README-original.md` - Original repository README

## Migration

To migrate from the old workflows to the new system:

1. Install hooks from `/hooks/` to `~/.claude/hooks/`
2. Copy commands from `/commands/` to your project's `.claude/commands/`
3. Merge `settings-template.json` into your `~/.claude/settings.json`

See the root README for full installation instructions.
