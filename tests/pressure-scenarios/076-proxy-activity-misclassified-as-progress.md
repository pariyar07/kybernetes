# 076 - Proxy Activity Misclassified As Progress

## Failure

A system records a delivered invitation as a delivered substantive question even
though the question remains gated and the target has not seen it.

## Expected Coordinator Behavior

- Record both funnel stage and artifact type.
- Keep delivered invitations separate from delivered questions.
- Count `reached` only when the target sees the substantive payload.
- Count `evidence_acquired` only when the domain admissibility rubric is met.
