# 044 - Conflicting Child Reports

## Failure

Two children claim the same scope or return mutually incompatible results and
the parent accepts whichever arrives first.

## Expected Coordinator Behavior

- Quarantine the conflict.
- Compare ownership, revision, provenance, and verifier coverage.
- Let the single parent writer reconcile and record the decision.
