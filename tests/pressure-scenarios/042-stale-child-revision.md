# 042 - Stale Child Revision

## Failure

A child started from revision 8 returns after the parent advanced to revision 11
and performs a new external side effect before reconciliation.

## Expected Coordinator Behavior

- Reject new effects from a stale activation.
- Admit reusable evidence only after parent reconciliation.
- Re-brief with the current revision when more work is needed.
