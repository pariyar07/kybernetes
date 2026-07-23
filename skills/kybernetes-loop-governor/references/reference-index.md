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
| `topology` | `workgraph.md` | Work may stack child loops, use peer workstreams, or require single-writer coordination. |
| `recovery` | `canonical-lifecycle.md` | State is stale, missing, conflicting, terminally trapped, or being migrated. |
| `activation` | `activation-bindings.md` | Re-entry is human, time, event, scheduled, recurring, detached, or notification-dependent. |
| `trajectory` | `trajectory-control.md` | Work is high/extreme recurring or detached, spans progress windows, repeats no-change, or needs strategy redesign. |
| `verification` | `kybernetes:verify-run` | Evidence must independently reject completion, integrate child results, or survive handoff. |
| `learning` | `kybernetes:capture-learning` | Failure repeats or evidence may justify a scoped reusable constraint. |
| `architect` | `kybernetes:loop-architect` | Decision consequence and unresolved uncertainty justify independent loop-shape design or reframing. |
| `closeout` | `kybernetes:loop-closeout` | A checkpoint, handoff, child retirement, program completion, or cleanup inventory is needed. |
| `runtime:chatgpt-work` | `chatgpt-work.md` | The active surface is ChatGPT Work mode; distinguish hosted chat and scheduled-run capability. |
| `runtime:codex` | `codex.md` | The active runtime is Codex; confirm actual callable operations first. |
| `runtime:claude-code` | `claude-code.md` | The active runtime is Claude Code; distinguish model, CLI, hooks, and hosted surfaces. |
| `runtime:claude-cowork` | `claude-cowork.md` | The active surface is Claude Cowork; distinguish remote session capability from local desktop resources. |
| `runtime:portable-core` | `portable-core.md` | Runtime is unknown, required native operations are absent, or dynamic loading is unavailable. |

## Selection Rules

- Start with no optional modules for a clear, reversible foreground action.
- Add a module only when its load condition is observed or persisted in a valid
  manifest.
- Load exactly one runtime binding. Each selected binding resolves the required
  portable baseline itself; `runtime:portable-core` is an alternative binding,
  not a mixin. Do not combine bindings merely because surfaces share a product
  family. Documentation is not capability evidence.
- Dependencies may require another module: lifecycle recovery requires
  `lifecycle`, runtime actuation requires `capability`, and high/extreme detached
  activation requires `lifecycle`, `capability`, `trajectory`, and `verification`.
- Persist selected modules only for durable reconstruction; do not create a
  manifest merely to describe a small task.

## Fail-Closed Rule

If a required module cannot be loaded or the manifest revision is unsupported,
freeze new side effects, read canonical and evidence state, select
`runtime:portable-core`, and reconstruct the smallest safe reference set.
