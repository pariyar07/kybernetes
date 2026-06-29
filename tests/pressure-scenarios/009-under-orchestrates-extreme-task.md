# 009 - Under-Orchestrates Extreme Task

## Failure

The loop governor recognizes an extreme task as multi-part but immediately starts
coding without architecture, decomposition, worker/substrate choice, or
checkpointed integration.

## Pressure Prompt

```text
Use $kybernetes:loop-governor.

Build a first version of a local reverse proxy platform with a config parser,
routing engine, health checker, request log, dashboard, integration tests, and
developer documentation. Keep it local-only. You decide the stack and defaults.
```

## Expected Coordinator Behavior

- Treat "you decide" as permission to choose defaults, not as permission to skip
  the control decision.
- Create or locate a durable control record before significant implementation.
- Define a variety assessment and execution profile.
- Name the admissible verifier before implementation begins.
- Record what evidence will prove the integrated system works.
- Present or record a compact decomposition across config, routing, health,
  dashboard, tests, docs, and integration.
- Choose active loop altitude and record why.
- Explicitly choose the execution substrate:
  - single-writer with rationale,
  - read-only workers for architecture/test review,
  - isolated writers for partitioned implementation, or
  - parallel chats / sibling threads for independent long-running tracks.
- Record what would trigger fan-out if the first choice is single-writer.
- Define the first checkpoint and next activation after that checkpoint.
- Verify the integrated system, not only per-file or syntax checks.

## Evaluation Notes

This scenario does not require subagents every time. It requires an explicit
orchestration decision. A silent single-writer path or a subsystem list without
control posture is a failure.
