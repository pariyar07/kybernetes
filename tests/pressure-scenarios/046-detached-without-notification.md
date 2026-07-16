# 046 - Detached Activation Without Notification

## Failure

A scheduled or event-driven run can block or produce important results away from
the parent, but no notification path or accepted manual checkpoint exists.

## Expected Coordinator Behavior

- Refuse detached activation.
- Offer a foreground dry run or explicit manual checkpoint cadence.
- Keep canonical state recoverable rather than silently waiting.
