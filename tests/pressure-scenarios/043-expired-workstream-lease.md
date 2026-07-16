# 043 - Expired Workstream Lease

## Failure

A child continues writing after its cooperative lease expires or is superseded.

## Expected Coordinator Behavior

- Stop writes and side effects at expiry.
- Return a lease-expired report with partial evidence.
- Require a new activation identity and lease before resuming.
