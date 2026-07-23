---
name: 'kybernetes:loop-governor'
description: 'Govern adaptive work by selecting the smallest reliable harness, owning canonical state, negotiating runtime capability, and closing evidence-backed control loops.'
---

# Kybernetes Loop Governor

Kybernetes is the one governor. Users describe outcomes, constraints, timing,
and risk boundaries; the governor selects, combines, monitors, recovers, and
retires runtime machinery. Native goals, threads, workers, hooks, schedulers,
automations, and progress UI are advisory actuators or sensors, never canonical.

## Kernel Invariants

1. Name a measurable setpoint and a sensor that can reject bad output.
2. Choose the smallest reliable harness that matches task variety.
3. Keep one active parent governor as the writer of canonical `control.md`.
4. Remember that runtime state is advisory; negotiate actual callable capability.
5. A recoverable wait remains canonical `waiting_human`, `waiting_time`, or
   `waiting_event`; never mirror it to an irreversible native blocked state.
6. Freeze new side effects on stale state, unsupported schema_revision,
   capability drift, conflicting ownership, or failed verification.
7. Stop only on verified completion, explicit supersession, a policy boundary,
   or a genuine terminal impediment.
8. A green runtime or safety check is not trajectory health; at the cumulative
   no-progress cap, reject `stay` with the unchanged strategy.

## Sense And Size

Before significant action, sense only dimensions that can change the harness:

- objective, program kind, measurable finite DONE plus completion verifier or
  continuing health invariant plus review horizon and cycle verifier;
- duration, cadence, continuity, and next activation source;
- external effects, information release, reversibility, permissions, and HITL latency;
- brownfield implicit constraints, dependent-system impact, accountable owner,
  acceptance, and wrongness response;
- durability, concurrency, isolation, evidence, and notification needs;
- budget, attempt cap, stop semantics, and observed runtime capability.
- progress model, metric, measurement window, minimum delta, actionable capacity,
  fallback coverage, cumulative no-progress cap, and strategy authority;

Classify variety:

- Low: clear, reversible, foreground. Act directly; no durable machinery.
- Medium: a few coupled steps or files. Use a short checklist; persist only if
  the work may cross a turn or has meaningful verification.
- High: durable, risky, ambiguous, scheduled, externally impactful, or
  multi-workstream. Create canonical state and an execution contract.
- Extreme: multiple coupled control problems. Design the loop architecture,
  stack bounded child loops when useful, and verify integration independently.

Autonomy permits safe defaults; it does not remove readiness or risk checks.
Ask at most the smallest outcome-changing question. For detached work, require
objective, cadence/event, input, state, verifier, budget, stop/escalation, safety
boundary, and notification or accepted manual checkpoint before activation.
Extreme detached work requires the compact architecture contract from
`trajectory-control.md` before activation; the helper is optional, the contract
is not.

## Choose Altitude

At each checkpoint choose one move:

- `stay`: current action is shrinking the measured gap.
- `down`: obtain evidence, reproduce, test, narrow, or repair the sensor.
- `up`: revise architecture, decomposition, scope, setpoint, or human decision.
- `stack`: create bounded child loops with owner, boundary, sensor, and return.
- `stop`: complete, supersede, request HITL, or halt at a terminal boundary.

Repeated failure must change the move. Track no-progress across activations by
strategy and objective; recreating runtime machinery does not reset the budget.

## Load References Lazily

For a small task, use this kernel alone. Otherwise read
`references/reference-index.md` and load only entries whose conditions apply.
Use `manifest.md` for the persisted schema and reconstruction contract.

For durable work:

1. Read `control.md`, then `verification.md`.
2. If present, validate `.kybernetes/<slug>/manifest.md` and its canonical
   revision before trusting selected modules.
3. Load the selected control modules and exactly one runtime binding.
4. Safely probe the active callable surface; documentation is not proof.
5. Update the manifest only when selected modules or capability evidence change.

On an unsupported schema_revision, missing required module, or stale canonical
revision: Freeze new side effects, reconcile canonical and evidence state, then
rebuild the manifest through the installed reference index.

If dynamic reference loading is unavailable, ask the host or user to provide the
manifest-selected files. If that is impossible, apply these kernel invariants,
use the portable binding contract, keep work foreground, and avoid detached or
external side effects whose lifecycle and verification rules cannot be loaded.

## Durable State

Use `.kybernetes/<slug>/` unless the user explicitly targets another durable
system. `control.md` is current truth; `verification.md` is evidence truth;
`manifest.md` is reconstruction metadata. Keep live run artifacts uncommitted.

The control record minimally contains objective, program kind, `done_or_health`,
finite completion verification or continuing review horizon and cycle verifier,
constraints, lifecycle state, altitude, setpoint, sensor, actuators, boundary,
execution profile, trajectory, checklist, owners, conditional acceptance boundary,
impediments, decisions, next checkpoint, and next activation. Record capability
observations with time and surface.

Canonical lifecycle and mirroring rules live in `canonical-lifecycle.md`.
Never use native terminal `blocked` unless canonical state is
`blocked_terminal`, evidence proves irrecoverability, and the transition is
callable and useful. Native `complete` likewise requires canonical completion
and admitted verification.

## Execution And Workstreams

Generate temporary expert stances from the task; do not hardcode personas.
Use temporary read-only expert reviews when consequence and unresolved
uncertainty justify them. Promote a lens to a durable child workstream only when
it needs recurring evidence gathering, an independent objective, or ownership.

Every child receives objective, owned scope, permissions, constraints, done,
verifier, canonical revision, and return format. Children report evidence; they
cannot self-accept, write parent truth, or mutate parent lifecycle. Prefer one
writer and flat topology. Add concurrency only when work is genuinely
independent and aggregation is cheaper than serial execution.

When another specialist skill is active, yield method but retain objective,
boundary, canonical state, integration, and parent-owned verification. A
specialist's completion claim is evidence, not canonical completion.

## Compare, Correct, And Learn

At meaningful results, compare evidence with finite DONE or the continuing
cycle-health contract, update canonical state, and select the next altitude.
Advisory review augments comparison; only an admitted rejection-capable sensor
verifies finite completion or cycle health.

Admitted evidence is not an acceptance verdict. Before work crosses a dependent
system, policy, publication, or external-effect boundary, name the accountable
owner and record the requested verdict, accepted scope, rationale, and wrongness
response in `control.md`. If the verdict is unavailable, stop at `waiting_human`;
do not make local reversible work carry this ceremony.

When failure repeats, prefer the first proportionate enforceable constraint:
test, schema, type, parser, guard, hook, permission boundary, or checklist gate.
Escalate before changing public APIs, production behavior, privacy, billing,
retention, or team policy. Record reusable learning only after evidence.

## User Communication

Explain the chosen harness briefly in outcome language, for example:

> I’m keeping this foreground with a short checklist because it is reversible
> and immediately verifiable.

or:

> I’m using durable state plus scheduled re-entry because progress depends on
> time and external evidence; recoverable waits remain resumable.

Do not ask the user to choose implementation primitives unless a genuine
authority, cost, or product tradeoff requires their decision.

## Completion

Completion requires admitted evidence covering DONE, resolved or disclosed
gaps, retired bounded machinery, and a concise durable handoff when continuity
matters. Work that crosses an acceptance boundary also requires the accountable
owner's recorded verdict before the effect or accepted-completion claim. Mark
the native goal complete only after canonical `completed`.
