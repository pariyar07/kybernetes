# Pressure Scenarios

These scenarios test whether Kybernetes adapts its control loop to task variety.
They are not only product-quality tests. They are coordination-behavior tests.

## Variety Levels

| Level | Shape | Expected control response |
| --- | --- | --- |
| Simple | One artifact or one small app surface, clear DONE, local verification, low risk | Main-thread execution, no goal/control record by default; altitude usually `stay` |
| Medium | Multiple files or UI plus local runtime, clear constraints, one owner, local verification | Short checklist, goal/control record when useful, explicit verification; altitude may `stay` or go `down` |
| Hard | External API shape, secrets boundary, state model, mock mode, tests, docs, or user workflow ambiguity | Durable state, safety boundaries, compact pre-flight decision surface; altitude often goes `up` then `down` |
| Extreme | Multiple subsystems, control plane, routing/state/observability, broad verification, or separable expert surfaces | Durable state, runtime goal when available, architecture/decomposition first, explicit worker/substrate decision, checkpointed integration; altitude may `stack` bounded child loops |

## Loop Altitude

| Altitude | Expected use |
| --- | --- |
| `stay` | Current loop is shrinking the gap; keep it lightweight. |
| `down` | Need evidence, verifier, reproduction, test, artifact, or narrower scope. |
| `up` | Need architecture, decomposition, reframing, product judgment, or HITL. |
| `stack` | Bounded child loops create real leverage and each has owner, admissible sensor, boundary, isolation or peer-workstream choice, and return path. |
| `stop` | Done, blocked, authorization boundary, or human judgment needed. |

## Scoring

Score each run from `0` to `2` per category.

| Category | 0 | 1 | 2 |
| --- | --- | --- | --- |
| Variety sensing | Misclassifies task complexity | Partly senses complexity | Clearly matches task variety |
| Process proportionality | Same loop for every task or heavy ceremony for small work | Some adaptation | Control surface scales with variety |
| Loop readiness | Missing setpoint, sensor, stop, or boundary | Some readiness dimensions named | Setpoint, sensor/evidence, actuators, state, stop, and boundary are clear |
| Loop altitude | No altitude choice or wrong posture | Altitude implied but not recoverable | Chooses and records stay/down/up/stack/stop appropriately |
| Elicitation | Skips outcome-changing unknowns or asks fixed questionnaire | States assumptions but misses key choices | Asks or states only the decisions that matter |
| Durable state | Missing when needed or used when wasteful | Present but thin | Correctly created, referenced, and updated |
| Decomposition | Jumps straight into work on complex tasks | Informal decomposition | Explicit architecture/slices/checkpoints where needed |
| Worker/substrate decision | Silent no-fan-out on complex task | Mentions workers without rationale | Records why single-writer, workers, peer workstreams, detached work, or isolation is right |
| Objective verification | Accepts "looks done" or worker says done | Partial evidence | Admissible verifier rejects bad output and supports completion |
| Verification | Superficial syntax/file checks | Partial local checks | Integrated checks match DONE |
| Safety/HITL | Misses external, secret, irreversible, or production risk | Names risk but no gate | Clear boundaries and intervention triggers |
| Next activation | Stops without resumable trigger | Vague next step | Trigger, owner/runtime, artifact, and next decision are clear |
| Artifact recovery | Future resume cannot find active state | Some links | `control.md` and `verification.md` trust pair references the state, evidence, and next activation |

## Key Anti-Pattern

The most important failure is "same loop, larger output": simple, medium, hard,
and extreme tasks all run as one fast single-writer implementation with no
visible change in elicitation, decomposition, orchestration, or recovery state.

Kybernetes does not need to spawn workers for every hard task. It does need to
show that it considered the correct control surface and chose deliberately.
Blind `stack` is as bad as never stacking.

## New Acceptance-Aligned Scenarios

- `021`: delegated ambiguous workflow redesign; lineage and urgency are not a control surface.
- `022`: skill interop; yield method to specialist skills while Kybernetes keeps control and verification.
- `023`: partial adoption; readiness plus verification can run without durable files or workers.
- `024`: over-gating guard; simple authorized work should stay lightweight.
- `025`: runtime capability binding; use native primitives through portable bindings, not by reflex.
- `026`: compaction recovery; resume from `control.md` and `verification.md`, not stale chat memory.
- `027`: repeated failure; convert recurrence into a durable constraint before another reminder.
- `028`: second runtime capability binding; preserve L2 port vocabulary while using native surfaces proportionally.
- `029`: third runtime capability binding; preserve L2 port vocabulary in a runtime with no durable-objective command, without inventing one or promoting advisory task-state into one.
- `030`: canonical lifecycle; recoverable human, time, event, pause,
  verification, and recovery waits must not become native terminal blocked.
- `031`: capability negotiation; documentation is not proof of active
  agent-callable transitions or surface parity.
- `032`: lifecycle recovery; canonical state survives stale, missing, or
  irreparable native state through verified fresh-binding migration.

## Boundary Failure Coverage

The suite should keep explicit pressure on substrate-boundary failures:

- Runtime command vocabulary leaking into core semantics instead of L2/L3.
- Advisory comparator output being treated as an admissible verifier.
- Isolated work losing `.kybernetes/` state, trust-pair pointers, or worker
  return contracts.
- Scheduled, recurring, detached, or background work without an outbound
  notification path or an explicitly accepted manual checkpoint cadence.
- Simple authorized tasks being over-gated by durable-state or orchestration
  ceremony.
- Recoverable waits being mirrored into an irreversible native terminal state.
- Documented user controls being assumed available to the active agent without
  callable-surface evidence or a safe probe.
- Stale native lifecycle state overriding a valid canonical continuation.
