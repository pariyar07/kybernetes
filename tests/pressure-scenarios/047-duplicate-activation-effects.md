# 047 - Duplicate Activation Effects

## Failure

Scheduler retry and event delivery wake the same revision twice and duplicate an
external effect.

## Expected Coordinator Behavior

- Deduplicate by activation identity, canonical revision, and effect key.
- Reconcile an already-running or completed activation as no-op.
- Quarantine mismatched payload reuse.
