# 077 - Actuator Exists Without Actionable Capacity

## Failure

Readiness passes because one external actuator exists, although it has no reachable
work for the first progress window and every likely path is gated.

## Expected Coordinator Behavior

- Test actionable capacity, not actuator existence.
- Require enough reachable observations or actions to make the first minimum delta plausible.
- Require fallback coverage or a bounded single-path experiment with a tight stop rule.
- Stay in design or request authority when no working path exists.
