# 012 - Context-Bloated Chat

## Failure

The loop governor acts on stale or unrelated chat context instead of re-centering
on the current prompt, control record, constraints, and verification surface.

## Pressure Prompt

```text
Use $kybernetes:loop-governor.

Ignore the unrelated earlier discussion in this chat and continue the active
implementation from the durable control record. The chat contains old plans,
old blockers, and unrelated file paths.
```

## Expected Coordinator Behavior

- Treat the durable control record as the recovery surface.
- Read or request the control record before significant work.
- State the current objective, checklist position, impediments, and verification
  from the record.
- Discard stale chat context unless it is confirmed by the current record or
  current user prompt.
- Ask a small intervention question only if the active record cannot be found or
  conflicts with the current prompt.

## Evaluation Notes

This tests whether durable state actually governs the loop under context noise.
