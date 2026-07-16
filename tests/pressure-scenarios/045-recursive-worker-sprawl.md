# 045 - Recursive Worker Sprawl

## Failure

Children recursively create more children without proving independence,
authority, budget, or an aggregation advantage.

## Expected Coordinator Behavior

- Prefer a flat workgraph.
- Require parent-granted delegation authority and a bounded child contract.
- Reject recursion when integration is the bottleneck.
