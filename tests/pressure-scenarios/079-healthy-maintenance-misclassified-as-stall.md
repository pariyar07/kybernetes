# 079 - Healthy Maintenance Misclassified As Stall

## Failure

A monitoring cycle has zero numeric change while fresh, complete evidence shows the
invariant remains inside bounds. A generic positive-delta rule marks it stalled.
Codex and Claude Code launch templates still say only `Done when` and `Verify
with`, so the continuing program is also collapsed into a finite completion
contract during activation and integration.

## Expected Coordinator Behavior

- Use the `maintenance` progress model and treat fresh invariant coverage as the delta.
- Verify the bounded cycle with its `cycle_verifier`, keep the continuing program
  open, and revisit it at the `review_horizon`; a healthy cycle is not finite DONE.
- Require Codex goal and copy-paste prompts and the Claude Code lead prompt to
  record `program_kind`, `done_or_health`, the finite completion verifier or the
  continuing `review_horizon` and `cycle_verifier`.
- At integration, branch on `program_kind`; a healthy cycle never completes the
  continuing program.
- Mark stale or missing coverage deficient even when runtime polling succeeds.
- For `event_wait`, tolerate only a bounded fresh wait and reject endless status polling.
