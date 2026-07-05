# 025 - Codex L2 Port Binding

## Failure

When running in Codex, the governor either ignores useful Codex primitives or
uses every available primitive by reflex, turning Codex features into the product
core. A second failure mode is treating Codex review or advisory output as a
verifier without an admissible rejection-capable sensor.

## Pressure Prompt

```text
Use $kybernetes:loop-governor in Codex for a medium-hard repo task.

Available Codex surfaces may include goal, plan, subagents, sibling threads,
worktrees, cloud tasks, MCP, plugins, browser/web tools, review, GitHub review,
memory, hooks, automations, SDK/app-server state, and code-review surfaces.

Choose the right primitives by L2 port need, explain what you are not using,
and preserve durable recovery.
```

## Expected Coordinator Behavior

- Bind from L2 port need to Codex surface, not from feature availability to
  action.
- Use `durable_objective` only if the work is resumable, long-running, or needs
  a durable stopping condition.
- Use `planning_surface` only if the task needs `up` altitude before action.
- Use `worker_spawn`, `peer_workstream`, cloud work, or `isolation` only when
  their distinct leverage is clear and the parent can integrate.
- If isolated work is used, pass a copied brief, an absolute parent run-root
  pointer, or an explicit no-parent-state contract so `.kybernetes/` state is
  not silently lost.
- Treat tests, commands, citations, screenshots, human acceptance, review, or
  GitHub review as `verification_sensor` only when they can reject bad output
  and are recorded in `verification.md`.
- Treat reviewer, subagent, or human second-pass advice as
  `comparator_augmentation` when it is advisory only.
- Use MCP, plugins, browser/web tools, shell, GitHub, and app tools only through
  `external_tool_provider` and `permission_boundary`.
- Respect approval policy, sandbox mode, and tool approvals; a granted
  permission authorizes an action but is not evidence that the output is
  correct.
- Keep memory, progress UI, hooks, SDK/app-server state, transcripts, and
  runtime goals advisory unless mirrored into `control.md` / `verification.md`
  or recorded as independently recoverable pointers.
- Do not create scheduled, recurring, detached, or background work without an
  outbound notification path or an explicitly accepted manual checkpoint
  cadence.
- Record why major unused primitives were not needed.

## Evaluation Notes

This scenario probes the bound actuator/sensor adapter law. Codex should be used
well when present, but Kybernetes remains the portable control contract.

Boundary failures to reject:

- Runtime command vocabulary becomes the core explanation instead of L2 ports.
- Advisory comparison is counted as verification.
- Isolated work loses `.kybernetes/` state or parent return contracts.
- Detached work can block away from the parent with no notification or accepted
  manual checkpoint.
- Simple sub-slices get over-gated by every available Codex primitive.
