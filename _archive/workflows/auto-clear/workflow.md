---
name: "auto-clear"
description: "Auto-trigger context management when reaching configurable threshold (80% or 90%)"
triggers:
  - "auto-clear"
  - "auto-clear 80"
  - "auto-clear 90"
default_threshold: 90
---

# Auto-Clear Workflow

Automatically monitors context window usage and triggers session-continue workflow when approaching capacity.

## Configuration

```yaml
thresholds:
  warning: 70      # Show warning at 70%
  trigger_80: 80   # Optional early trigger
  trigger_90: 90   # Default trigger (recommended)
  critical: 95     # Force immediate action
```

---

## Step 1: Parse Threshold Parameter

**Actions:**
1. Check if user specified threshold (80 or 90)
2. Default to 90% if not specified
3. Validate threshold value

```xml
<threshold-detection>
  <if trigger="auto-clear 80">Set threshold to 80%</if>
  <if trigger="auto-clear 90">Set threshold to 90%</if>
  <if trigger="auto-clear">Use default 90%</if>
</threshold-detection>
```

**Output:**
```
Auto-Clear Activated

Threshold: {THRESHOLD}%
Mode: Monitoring context usage

I will automatically save context and prepare for clear when reaching {THRESHOLD}%.
```

---

## Step 2: Monitor Context Usage

**Continuous Monitoring:**
- Track conversation length
- Estimate token usage
- Watch for warning signs:
  - Response truncation
  - Memory issues
  - Slow responses

```xml
<context-monitor>
  <check-interval>After each major action</check-interval>
  <estimate-method>Message count + content length</estimate-method>
  <warning-triggers>
    <trigger level="70%">Display warning banner</trigger>
    <trigger level="{THRESHOLD}%">Execute auto-clear</trigger>
    <trigger level="95%">Force immediate clear</trigger>
  </warning-triggers>
</context-monitor>
```

---

## Step 3: Warning Display (70%)

When context reaches 70%:

```
Context Usage Warning

Estimated usage: ~70%
Threshold: {THRESHOLD}%

Continuing work. Will auto-save at {THRESHOLD}%.
```

---

## Step 4: Trigger Session-Continue

When context reaches threshold:

**Actions:**
1. Stop current work gracefully
2. Execute `/session-continue` workflow
3. Use CLEAR mode (fresh start recommended at high context)

```xml
<auto-trigger>
  <message>
    Context Threshold Reached ({THRESHOLD}%)
    
    Initiating automatic session save...
  </message>
  <execute workflow="session-continue" mode="clear"/>
</auto-trigger>
```

---

## Step 5: Post-Trigger Instructions

**Output to user:**
```
Auto-Clear Complete

Context was at: ~{THRESHOLD}%
Session saved to: _bmad-output/session-state.xml
Agent: {AGENT_TYPE}
Last Task: {TASK_TITLE}

Next steps:
1. Run /clear now
2. Start new session
3. Say "continue" to resume

Your work has been preserved!
```

---

## Threshold Recommendations

| Threshold | Use Case |
|-----------|----------|
| **80%** | Long coding sessions, many file reads |
| **90%** | Standard work, balanced context usage |

**80% Recommended When:**
- Working with large files
- Multiple sub-agent calls expected
- Complex multi-step tasks remaining

**90% Recommended When:**
- Standard development work
- Quick tasks
- Minimal file reading needed

---

## Manual Override

User can always:
- Run `/compact&continue` manually at any time
- Run `/clear&continue` manually at any time
- Ignore auto-clear warning (not recommended at 95%+)

---

## Notes

- Context estimation is approximate
- Actual limits depend on model and configuration
- When in doubt, use 80% threshold
- Sub-agents help reduce main context usage
