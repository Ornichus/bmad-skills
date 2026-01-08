# BMAD Skills & Workflows

Collection of productivity workflows for Claude Code with BMAD agent system.

## Workflows

### 1. Session Continue (`/session-continue`)

Prepare session handoff with context preservation.

**Triggers:**
- `/compact&continue` - Save context, update docs/Archon, then compact
- `/clear&continue` - Save context, update docs/Archon, then clear
- `/session-continue` - Manual trigger (asks which mode)

**Features:**
- Saves session state to XML file
- Updates PROGRESS.md with session summary
- Syncs task status with Archon
- Auto-resume on next session start

### 2. Auto-Clear (`/auto-clear`)

Automatically trigger context management when reaching threshold.

**Triggers:**
- `/auto-clear 80` - Trigger at 80% context usage
- `/auto-clear 90` - Trigger at 90% context usage (default)
- `/auto-clear` - Uses default 90% threshold

**Features:**
- Monitors context window usage
- Warns user when approaching threshold
- Executes session-continue workflow automatically
- Configurable threshold (80% or 90%)

## Installation

1. Copy workflow files to your project's `_bmad/bmm/workflows/` directory
2. Update `_bmad/_config/workflow-manifest.csv` with new entries
3. Add Session Continuity section to your `CLAUDE.md`

### Workflow Manifest Entries

```csv
"session-continue","Prepare session handoff with documentation update, Archon sync, and XML launch prompt","bmm","_bmad/bmm/workflows/session-continue/workflow.md"
"compact-continue","Alias for session-continue in COMPACT mode","bmm","_bmad/bmm/workflows/session-continue/workflow.md"
"clear-continue","Alias for session-continue in CLEAR mode","bmm","_bmad/bmm/workflows/session-continue/workflow.md"
"auto-clear","Auto-trigger context management at configurable threshold","bmm","_bmad/bmm/workflows/auto-clear/workflow.md"
```

## Requirements

- BMAD agent system installed
- Archon MCP server (optional, for task sync)
- Claude Code CLI

## License

MIT