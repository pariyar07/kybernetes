# 003 - Loses Control Record

## Failure

The agent starts a long-running task but does not reference durable state after a resume or context compression.

## Pressure Prompt

```text
Continue the Kybernetes migration from yesterday.
```

## Expected Coordinator Behavior

- Locate or ask for the active control record.
- Read the current objective, checklist, impediments, decisions, and verification.
- State the current loop position before acting.
