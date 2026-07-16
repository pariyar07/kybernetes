# 049 - Stale Scheduled Revision

## Failure

An old scheduled activation wakes after canonical state changed and performs the
previous action.

## Expected Coordinator Behavior

- Compare expected and current canonical revision before effects.
- Stop stale activation and report supersession.
- Rebind only from the current parent state.
