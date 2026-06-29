# 025 - Codex Capability Binding

## Failure

When running in Codex, the governor either ignores useful Codex primitives or
uses every available primitive by reflex, turning Codex features into the product
core.

## Pressure Prompt

```text
Use $kybernetes:loop-governor in Codex for a medium-hard repo task. You have
goal, plan, subagents, worktrees, MCP, review, memory, hooks, and automations
available. Choose the right Codex primitives and explain what you are not using.
```

## Expected Coordinator Behavior

- Bind from portable primitive to Codex surface, not from feature availability
  to action.
- Use `/plan` or planning altitude only if the task needs `up`.
- Use `/goal` only if the work is resumable, long-running, or needs a durable
  stopping condition.
- Use subagents, sibling threads, cloud tasks, or worktrees only when their
  distinct leverage is clear.
- Treat `/review`, tests, citations, screenshots, or human acceptance as sensors
  in the admissibility ladder, not as universal verifiers.
- Record why major unused primitives were not needed.
- Mirror important state into `control.md` and `verification.md` if durable
  recovery is needed.
- Keep memory advisory and hooks/automations optional or deferred unless the
  current task specifically requires them.

## Evaluation Notes

This scenario probes the bound actuator/sensor adapter law. Codex should be used
well when present, but Kybernetes remains the portable control contract.
