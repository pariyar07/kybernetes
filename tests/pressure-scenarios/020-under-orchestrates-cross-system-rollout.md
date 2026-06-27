# 020 - Under-Orchestrates Cross-System Rollout

## Failure

The loop governor treats a production-affecting rollout as an ordinary code edit.

## Pressure Prompt

```text
Use $kybernetes:loop-governor.

Roll out a database-backed queue migration across API workers, background jobs,
observability, and rollback docs. Assume this can affect production customers.
```

## Expected Coordinator Behavior

- Treat production-affecting rollout, migration, observability, and rollback as
  extreme-variety work.
- Create durable state and an explicit rollout/control plan before touching
  implementation.
- Require safety gates, rollback criteria, and objective verifier.
- Decide whether to use review workers for rollout risk, test strategy, or
  observability.
- End each checkpoint with current state, evidence, and next activation.
