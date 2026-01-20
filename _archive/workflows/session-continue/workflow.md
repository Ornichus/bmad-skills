---
name: "session-continue"
description: "Prepare session handoff with documentation update, Archon sync, and XML launch prompt for seamless agent continuation"
triggers:
  - "compact&continue"
  - "clear&continue"
  - "session-continue"
---

# Session Continue Workflow

Prepare session transition with context saving, Archon update, and XML prompt generation for agent resume.

## Trigger Detection

```xml
<trigger-detection>
  <if trigger="compact&continue">Execute COMPACT mode (summarize context)</if>
  <if trigger="clear&continue">Execute CLEAR mode (fresh start with context file)</if>
  <if trigger="session-continue">Ask user which mode to use</if>
</trigger-detection>
```

---

## Step 1: Analyze Current Session

**Actions:**
1. Identify active agent (bmad-master, dev, analyst, etc.)
2. List tasks in progress (status: doing)
3. List remaining todo tasks
4. Capture current work context

```xml
<session-analysis>
  <active-agent>{detect from conversation}</active-agent>
  <current-task>{from Archon: status=doing}</current-task>
  <pending-tasks>{from Archon: status=todo}</pending-tasks>
  <project-id>{from Archon or CLAUDE.md}</project-id>
</session-analysis>
```

**Archon Calls:**
```
find_tasks(filter_by="status", filter_value="doing")
find_tasks(filter_by="status", filter_value="todo")
find_projects(project_id="...")
```

---

## Step 2: Update Documentation

**Actions:**
1. Update `docs/PROGRESS.md` if exists (or create)
2. Add entry with:
   - Date/time
   - Tasks completed this session
   - Tasks in progress
   - Important notes
   - Active agent

**PROGRESS.md Format:**
```markdown
## Session [DATE] - [AGENT]

### Completed
- [x] Task description

### In Progress
- [ ] Task description (-> next session)

### Notes
- Key context for next session
```

---

## Step 3: Sync Archon

**Actions:**
1. Update "doing" tasks with progress notes
2. Verify task consistency vs reality
3. Add metadata if needed

```
manage_task("update", task_id="...", description="[UPDATED] Progress notes...")
```

---

## Step 4: Generate Launch Prompt XML

**Create file:** `_bmad-output/session-state.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<session-context generated="{ISO_TIMESTAMP}">

  <project>
    <id>{ARCHON_PROJECT_ID}</id>
    <name>{PROJECT_NAME}</name>
    <path>{PROJECT_PATH}</path>
  </project>

  <agent>
    <type>{AGENT_TYPE: bmad-master|dev|analyst|pm|...}</type>
    <launch-command>/bmad:{module}:agents:{agent-name}</launch-command>
  </agent>

  <context>
    <summary>{2-3 sentence summary of where we left off}</summary>
    <last-action>{What was the last thing done}</last-action>
  </context>

  <tasks>
    <current status="doing">
      <task id="{ID}">{TITLE}</task>
    </current>
    <next status="todo" priority="high">
      <task id="{ID}">{TITLE}</task>
    </next>
  </tasks>

  <instructions>
    <on-resume>
      1. Read this context file
      2. Launch agent: {LAUNCH_COMMAND}
      3. Continue with task: {CURRENT_TASK}
      4. If task done, move to next in queue
    </on-resume>
  </instructions>

</session-context>
```

---

## Step 5: Execute Mode

### Mode: COMPACT & CONTINUE

**Output to user:**
```
Session Context Saved

File: _bmad-output/session-state.xml
Agent: {AGENT_TYPE}
Current Task: {TASK_TITLE}

To continue after compact:
1. Run /compact now
2. On new session, say: "continue" or run the agent command

The agent will read session-state.xml automatically.
```

### Mode: CLEAR & CONTINUE

**Output to user:**
```
Session Context Saved

File: _bmad-output/session-state.xml
Agent: {AGENT_TYPE}
Current Task: {TASK_TITLE}

To continue after clear:
1. Run /clear now
2. On new session, say: "continue" or run the agent command

The agent will read session-state.xml automatically.
```

---

## Step 6: Resume Protocol (Next Session)

When user starts new session and says "continue" or loads agent:

1. **Check for session-state.xml:**
   ```
   Read: _bmad-output/session-state.xml
   ```

2. **Parse context and display:**
   ```
   Resuming Session

   Project: {PROJECT_NAME}
   Agent: {AGENT_TYPE}
   Last Task: {CURRENT_TASK}

   Continuing from where you left off...
   ```

3. **Launch appropriate agent:**
   ```
   /bmad:{module}:agents:{agent-name}
   ```

4. **Orient agent to current task:**
   ```
   manage_task("update", task_id="...", status="doing")
   ```

---

## Sub-Agent Strategy

To optimize context, use sub-agents (Task tool) for:

| Operation | Use Sub-Agent? | Reason |
|-----------|---------------|--------|
| File reading | Yes | Isolate file content from main context |
| Web research | Yes | Large results don't bloat main context |
| Code analysis | Yes | Separate analysis context |
| Documentation update | No | Need main context for accuracy |
| Archon updates | No | Need conversation context |

**Note:** Sub-agents inherit active MCPs from parent session.
