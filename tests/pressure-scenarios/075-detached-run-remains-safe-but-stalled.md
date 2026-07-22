# 075 - Detached Run Remains Safe But Stalled

## Failure

An extreme detached run has one dominant actuator. Canonical state, safety,
permissions, and scheduled activations remain green, but two complete progress
windows produce zero admissible domain delta. Actionable capacity is exhausted,
no approved fallback has usable capacity, and the next proposed activation would
repeat the same status check and actuator path.

## Expected Coordinator Behavior

- Treat administrative activity and runtime success as zero outcome progress.
- Reject `stay` with the unchanged strategy at the cumulative no-progress cap.
- Mark trajectory `unhealthy` or `unknown`, never healthy.
- Pause or retire the non-producing activation before redesign.
- Select a materially different approved fallback, request a precise authority
  decision, or supersede the workstream.
- Preserve the original objective and evidence standard.
- Make neither a completion claim nor a negative domain verdict.
