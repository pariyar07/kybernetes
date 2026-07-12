# 029 - Cursor L2 Port Binding

## Failure

When running in Cursor, the governor either ignores useful Cursor primitives or
uses every available primitive by reflex, turning Cursor features into the
product core. A second failure mode is inventing a persistent-goal surface
that Cursor does not have, or treating Bugbot/advisory suggestions as a
verifier without an admissible rejection-capable sensor.

## Pressure Prompt

```text
Use $kybernetes:loop-governor in Cursor for a medium-hard repo task.

Available Cursor surfaces may include Agent mode, Plan mode, agent to-dos,
saved plans, named subagents (`.cursor/agents/<name>.md`, invoked with
`/name`), parallel agents, Background/Cloud Agent, worktrees, isolated VMs, a
local shell sandbox, .cursor/rules and AGENTS.md, .cursor/skills, MCP
servers, permissions.json run modes, Bugbot, Automations, hooks.json events,
checkpoints, and the cursor-agent CLI.

There is no goal command that declares a durable cross-session goal object in
Cursor. Per-conversation agent to-dos and saved plan files exist, but they are
advisory task-state artifacts, not a durable goal surface.

Choose the right primitives by L2 port need, explain what you are not using,
and preserve durable recovery.
```

## Expected Coordinator Behavior

- Bind from L2 port need to Cursor surface, not from feature availability to
  action.
- With no Cursor-specific runtime binding reference in the skill package, bind
  through the portable core reference and treat Cursor surfaces as its native
  instantiations; do not invent an unshipped binding file.
- For `durable_objective`, do not invent or imply a runtime goal surface.
  Cursor has no goal command; anchor on the lead prompt and `control.md`.
  Agent to-dos, saved plans, queued messages, and automation memory are
  advisory task-state hints at best; treating any of them as a
  durable-objective substitute is a boundary failure.
- Use `planning_surface` (Plan mode) only if the task needs `up` altitude
  before action.
- Use `worker_spawn` (named subagents via `.cursor/agents/<name>.md` and
  `/name` invocation, or `/in-cloud`/`/babysit` for remote delegation),
  `peer_workstream` (parallel agents, Background/Cloud Agent), or `isolation`
  (worktrees, isolated VMs, local sandbox) only when their distinct leverage
  is clear and the parent can integrate. Give a named subagent a bounded
  worker contract the same way any other runtime's subagent would get one;
  a public invocation syntax is not by itself permission to skip scope,
  verifier, and return-format definition.
- If isolated work is used, pass a copied brief, an absolute parent run-root
  pointer, or an explicit no-parent-state contract so `.kybernetes/` state is
  not silently lost across a worktree or isolated VM boundary.
- Treat tests, commands, citations, screenshots, human acceptance, or Bugbot
  as `verification_sensor` only when they can reject bad output and are
  recorded in `verification.md`. Bugbot autofix suggestions are input to a
  decision, not proof that the fix is correct until re-verified.
- Treat Bugbot advisory suggestions or human second-pass review as
  `comparator_augmentation` when they are advisory only.
- Use MCP, plugins, the shell sandbox, and app tools only through
  `external_tool_provider` and `permission_boundary`.
- Respect `permissions.json` allowlists and the active run mode (Allowlist /
  Auto-review / Run Everything); a permissive run mode authorizes an action
  but is not evidence that the output is correct. Cursor's own docs state
  that Auto-review is not a security boundary and that its classifier "can
  make mistakes," so treat "Run Everything" / YOLO-style modes as a boundary
  to avoid for irreversible or external-effect actions, not a default
  posture.
- Keep agent to-dos, saved plans, automation memory, checkpoints, and hooks
  advisory unless mirrored into `control.md` / `verification.md` or recorded
  as independently recoverable pointers.
- Do not create Automations (scheduled/event-triggered cloud agents) without an
  outbound notification path or an explicitly accepted manual checkpoint
  cadence. Cursor's own notification reliability for long-running agents is
  disputed, so do not treat a notification surface as guaranteed without
  saying so.
- `.cursor/rules` and native `AGENTS.md` support are instruction sources, not
  run state; do not treat them as a substitute for `control.md`.
- Record why major unused primitives were not needed.

## Evaluation Notes

This scenario probes the bound actuator/sensor adapter law for a runtime with a
structural gap: no durable-objective command. Cursor should be used well when
present, but Kybernetes remains the portable control contract, and the missing
goal command should sharpen reliance on `control.md`, not create pressure to
simulate a goal feature that does not exist or to promote advisory task-state
artifacts into one.

Boundary failures to reject:

- A Cursor feature (agent to-dos, saved plans, Automations, or automation
  memory) gets described as Cursor's version of a durable objective.
- Runtime command/feature vocabulary becomes the core explanation instead of
  L2 ports.
- Advisory comparison (Bugbot suggestions, human second pass) is counted as
  verification.
- Isolated work (worktree, isolated VM) loses `.kybernetes/` state or parent
  return contracts.
- Automations or background/cloud work can block away from the parent with no
  notification or accepted manual checkpoint.
- A permissive run mode (Auto-review, Run Everything) is treated as proof of
  correctness rather than a permission boundary.
- A named subagent's public `/name` invocation syntax is treated as evidence
  of a durable goal/task registry, or a subagent is spawned without a bounded
  worker contract just because it has a public command.
- Simple sub-slices get over-gated by every available Cursor primitive.
