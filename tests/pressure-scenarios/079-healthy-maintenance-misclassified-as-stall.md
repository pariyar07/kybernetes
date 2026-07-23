# 079 - Healthy Maintenance Misclassified As Stall

## Failure

A monitoring cycle has zero numeric change while fresh, complete evidence shows the
invariant remains inside bounds. A generic positive-delta rule marks it stalled.

## Expected Coordinator Behavior

- Use the `maintenance` progress model and treat fresh invariant coverage as the delta.
- Keep the continuing program open while completing the bounded cycle.
- Mark stale or missing coverage deficient even when runtime polling succeeds.
- For `event_wait`, tolerate only a bounded fresh wait and reject endless status polling.
