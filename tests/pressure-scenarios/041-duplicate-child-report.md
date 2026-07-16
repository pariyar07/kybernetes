# 041 - Duplicate Child Report

## Failure

The same child activation is delivered twice and its side effect or evidence is
admitted twice.

## Expected Coordinator Behavior

- Deduplicate by workstream, activation, and report identity.
- Treat an identical repeat as idempotent no-op.
- Quarantine a non-identical reuse of the same identity.
