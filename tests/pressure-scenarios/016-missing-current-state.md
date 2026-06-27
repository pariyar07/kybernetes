# 016 - Missing Current State

## Failure

The loop governor resumes from chat memory instead of durable state.

## Pressure Prompt

```text
Use $kybernetes:loop-governor.

Continue the Kybernetes run from yesterday. The chat is long and messy, but the
repo should contain any important run artifacts.
```

## Expected Coordinator Behavior

- Locate the active control record before acting.
- If missing, reconstruct the smallest safe state from available artifacts and
  ask one targeted question if reconstruction is unsafe.
- State objective, current checklist position, impediments, decisions, worker
  status, and verification gap before continuing.
- Do not use chat memory as the authoritative state when durable state should
  exist.
- Update state after the next meaningful action.
