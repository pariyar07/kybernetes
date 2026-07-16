# Reference Index

Load the kernel first, then only the modules whose conditions are present.
Module identifiers are stable manifest values; paths are implementation details.

| Module | Reference | Load when |
| --- | --- | --- |
| `operating-model` | `operating-model.md` | Altitude, requisite variety, escalation, or control theory changes the next decision. |
| `readiness` | `goal-checklist.md` | Work needs durable state, a measurable execution contract, workers, or cross-turn reconstruction. |
| `elicitation` | `adaptive-elicitation.md` | Missing choices change outcome, risk, permission, budget, topology, or verifier. |
| `lifecycle` | `canonical-lifecycle.md` | State is durable, waiting, paused, terminal, migrated, or diverges from runtime state. |
| `capability` | `capability-negotiation.md` | Any native goal, scheduler, worker, event, notification, hook, or background surface may be used. |
| `topology` | `goal-checklist.md` | Work may stack child loops, use peer workstreams, or require single-writer coordination. |
| `recovery` | `canonical-lifecycle.md` | State is stale, missing, conflicting, terminally trapped, or being migrated. |
| `verification` | `goal-checklist.md` | Evidence must reject completion, integrate child results, or survive handoff. |
| `learning` | `failure-to-constraint.md` | Failure repeats or a reusable constraint may be promoted. |
| `runtime:codex` | `codex.md` | The active runtime is Codex; confirm actual callable operations first. |
| `runtime:claude-code` | `claude-code.md` | The active runtime is Claude Code; distinguish model, CLI, hooks, and hosted surfaces. |
| `runtime:portable-core` | `portable-core.md` | Runtime is unknown, required native operations are absent, or dynamic loading is unavailable. |

## Selection Rules

- Start with no optional modules for a clear, reversible foreground action.
- Add a module only when its load condition is observed or persisted in a valid
  manifest.
- Load exactly one runtime binding. Documentation is not capability evidence.
- Dependencies may require another module: lifecycle recovery requires
  `lifecycle`, runtime actuation requires `capability`, and detached activation
  requires `lifecycle`, `capability`, and `verification`.
- Persist selected modules only for durable reconstruction; do not create a
  manifest merely to describe a small task.

## Fail-Closed Rule

If a required module cannot be loaded or the manifest revision is unsupported,
freeze new side effects, read canonical and evidence state, select
`runtime:portable-core`, and reconstruct the smallest safe reference set.
