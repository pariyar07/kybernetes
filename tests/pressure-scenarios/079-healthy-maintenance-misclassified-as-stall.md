# 079 - Healthy Maintenance Misclassified As Stall

## Failure

A monitoring cycle has zero numeric change while fresh, complete evidence shows the
invariant remains inside bounds. A generic positive-delta rule marks it stalled.

## Expected Coordinator Behavior

- Use the `maintenance` progress model and treat fresh invariant coverage as the delta.
- Verify the bounded cycle with its `cycle_verifier`, keep the continuing program
  open, and revisit it at the `review_horizon`; a healthy cycle is not finite DONE.
- Mark stale or missing coverage deficient even when runtime polling succeeds.
- For `event_wait`, tolerate only a bounded fresh wait and reject endless status polling.
