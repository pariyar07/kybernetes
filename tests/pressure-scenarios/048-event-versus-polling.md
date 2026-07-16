# 048 - Unreliable Event Source

## Failure

The governor assumes a webhook is reliable or polls aggressively without
choosing based on source guarantees, cost, latency, and missed-event recovery.

## Expected Coordinator Behavior

- Prefer direct events only when identity and delivery are reliable enough.
- Select bounded scheduled polling otherwise.
- Record no-change as a normal outcome and apply backoff/budget limits.
