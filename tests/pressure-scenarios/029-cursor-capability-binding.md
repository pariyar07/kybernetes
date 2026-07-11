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

Available Cursor surfaces may include Agent mode, Ask mode, Plan mode, parallel
agents, Background/Cloud Agent, worktrees, isolated VMs, a local shell sandbox,
.cursor/rules and AGENTS.md, .cursor/skills, MCP servers, permissions.json
approval modes, Bugbot, Memories, Automations, hooks.json events, checkpoints,
and the cursor-agent CLI.

There is no persistent goal or task-state command in Cursor.

Choose the right primitives by L2 port need, explain what you are not using,
and preserve durable recovery.
```

## Expected Coordinator Behavior

- Bind from L2 port need to Cursor surface, not from feature availability to
  action.
- For `durable_objective`, do not invent or imply a runtime goal surface.
  Cursor has no analogue to `/goal`; go straight to the lead prompt and
  `control.md` with no runtime hint to fall back on. Treating Memories or
  Automations as a durable-objective substitute is a boundary failure.
- Use `planning_surface` (Plan mode) only if the task needs `up` altitude
  before action.
- Use `worker_spawn` (Composer/subagents), `peer_workstream` (parallel agents,
  Background/Cloud Agent, Agents Window), or `isolation` (worktrees, isolated
  VMs, local sandbox) only when their distinct leverage is clear and the
  parent can integrate.
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
- Respect `permissions.json` allowlists and the active run mode (Allowlist-only
  / Auto-review / Run Everything); a permissive run mode authorizes an action
  but is not evidence that the output is correct. Treat "Run Everything" /
  YOLO-style modes as a boundary to avoid for irreversible or external-effect
  actions, not a default posture.
- Keep Memories, Notepads, checkpoints, and hooks advisory unless mirrored into
  `control.md` / `verification.md` or recorded as independently recoverable
  pointers.
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
structural gap: no durable-objective analogue. Cursor should be used well when
present, but Kybernetes remains the portable control contract, and the missing
`/goal`-equivalent should sharpen reliance on `control.md`, not create pressure
to simulate a goal feature that does not exist.

Boundary failures to reject:

- A Cursor feature (Memories, Automations, or Notepads) gets described as
  Cursor's version of a durable objective.
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
- Simple sub-slices get over-gated by every available Cursor primitive.
