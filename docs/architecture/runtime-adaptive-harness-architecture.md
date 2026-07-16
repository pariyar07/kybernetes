# Runtime-Adaptive Harness Architecture

Status: approved  
Date: 2026-07-17  
Scope: Kybernetes control architecture, helper-skill boundaries, durable workgraph,
runtime binding, recovery, verification, and closeout

## Executive Decision

Kybernetes remains canonical even when a runtime offers native goals, schedulers,
hooks, workers, threads, or progress state. Runtime facilities are replaceable
bindings for semantic control needs; they do not own program truth.

Long or consequential work uses one parent program with one lead-owned
`control.md`. Child chats, workers, goals, and automations operate through bounded
workstream contracts, write only their owned artifacts, and submit reports for
lead reconciliation. They never race to edit parent canonical state.

Kybernetes chooses five dimensions independently:

| Dimension | Control question |
| --- | --- |
| Activation posture | What causes the next execution: user, immediate continuation, time, or event? |
| Loop topology | Is work chained, routed, parallelized, voted, or dynamically delegated? |
| Feedback architecture | How is output evaluated, rejected, corrected, and stopped? |
| Continuity architecture | Is work foreground, continuous, checkpointed, migrated, detached, or recurring? |
| Runtime binding | Which capability actually exposed by the active runtime can implement the selected semantics? |

The user supplies outcomes, constraints, timing, and risk boundaries. The
governor owns harness design and explains its choice briefly.

## Goals

- Select the smallest reliable execution substrate from task needs and observed
  runtime capabilities.
- Preserve one reconstructable program truth across context loss, runtime drift,
  provider changes, stale native goals, and fresh-task migration.
- Support multiple chats, goals, workers, events, schedules, and polling jobs
  without split-brain state.
- Add expert perspectives only when decision consequence and unresolved
  uncertainty justify them.
- Keep always-loaded instructions lean and load detailed methods dynamically.
- Close loops deliberately by reconciling evidence, stopping machinery,
  retaining useful state, and removing only disposable artifacts.

## Non-Goals

- Making users choose among native goals, cron, hooks, workers, threads, or
  control files.
- Maintaining a hardcoded council of sales, marketing, engineering, or research
  personas.
- Treating runtime documentation as proof of agent-callable capability.
- Treating consensus, progress UI, worker claims, or native goal status as proof
  of completion.
- Creating production-grade distributed orchestration in the file-based portable
  core.
- Splitting every internal responsibility into an installable skill before
  pressure evidence demonstrates the need.

## Architectural Invariants

1. Kybernetes canonical state is independent of native runtime state.
2. Every canonical record has one writer at a time.
3. Runtime goals, progress surfaces, hooks, schedulers, and workers are advisory
   sensors or actuators until their results are admitted into canonical state.
4. Recoverable waits never map to irreversible native terminal failure.
5. Evidence must be able to reject bad output before it can prove DONE.
6. Child output is proposed evidence; parent reconciliation decides acceptance.
7. Activation must be revision-aware, idempotent, bounded, inspectable, and
   paired with notification or an explicitly accepted manual checkpoint.
8. Expert lenses and promoted workstreams are generated from the task at runtime.
9. Heavy machinery must answer a named failure mode and have a removal condition.
10. Portable semantics survive replacement of Markdown files by a database,
    workflow engine, or event store.

## Skill Lifecycle

The intended helper architecture is:

```text
kybernetes:loop-architect
      |
      v
kybernetes:loop-governor <---- kybernetes:verify-run
      |
      +-----------> kybernetes:capture-learning
      |
      v
kybernetes:loop-closeout
```

### `kybernetes:loop-architect`

Designs or redesigns a loop. It classifies the work, chooses the five control
dimensions, generates relevant expert lenses, negotiates capability needs,
defines boundaries, and emits an execution contract.

Automatic invocation is limited to:

- high or extreme variety;
- a consequential decision with material unresolved uncertainty;
- major reframing after evidence invalidates the current plan; or
- recovery that requires a different substrate or work decomposition.

It remains explicitly callable for any task. It does not run automatically for
ordinary small work.

### `kybernetes:loop-governor`

Is the only governor and control-plane owner. It compares evidence with the
setpoint, selects the next control move, owns canonical lifecycle transitions,
reconciles child reports, and invokes helpers when their contracts fit.

### `kybernetes:verify-run`

Independently evaluates evidence against DONE and has rejection authority. It
records pass, fail, inconclusive, blocked, or not-run results and cannot rely on
the producer's self-claim.

### `kybernetes:capture-learning`

Proposes reusable constraints, rules, tests, or skill improvements only after
representative evidence supports them. It cannot silently rewrite governance or
promote a rule from one anecdote.

### `kybernetes:loop-closeout`

Handles checkpoint consolidation, handoff, workstream completion, and final
program closure. Its modes are:

- `checkpoint`: compact current state and remove safely reproducible temporary
  material;
- `handoff`: prepare a fresh task, context reset, or runtime migration;
- `workstream`: reconcile evidence and stop that workstream's activations; and
- `program`: verify final state, stop all machinery, revoke temporary grants,
  archive retained records, and delete only explicitly disposable artifacts.

### Helper Contract

Every helper is callable by the user or governor and declares:

- required inputs and canonical-state pointer;
- permitted reads, writes, tools, and side effects;
- owned output artifact;
- evidence, confidence, and unresolved gaps;
- proposed transition or recommendation; and
- return path to the governor.

A helper may inspect canonical state and write owned output. It cannot
independently change canonical program lifecycle state. When invoked without an
active governor, it may produce a standalone proposal or report, but it must not
claim that a canonical transition occurred.

New installable skills still require pressure evidence, an independently
testable contract, a working fallback when unavailable, and demonstrated benefit
from the split. The architecture can be separated internally before packaging is
promoted.

## Dynamic Expert Lenses

Expert review is triggered by decision consequence plus material unresolved
uncertainty, not by duration or size alone.

The default is temporary, independent, read-only review.
`kybernetes:loop-architect`
generates only perspectives relevant to the current decision. A lens contract
contains:

- decision under review;
- relevant expertise or perspective;
- shared facts, constraints, and evidence sources;
- assumptions to challenge;
- required output: risks, opportunities, recommendation, confidence, and
  disconfirming evidence; and
- prohibition on external actions and canonical-state mutation.

Independent first passes reduce groupthink. The governor synthesizes agreements,
disagreements, evidence quality, and missing information. Consensus is
comparator input, not verification.

A temporary lens is promoted into a durable child workstream only when it has:

- a distinct recurring objective;
- its own evidence source or verifier;
- meaningful work beyond another review;
- a cadence or event trigger;
- a bounded scope and return contract; and
- expected value exceeding coordination cost.

Once promoted, it is named for its objective rather than its personality. Both
lenses and workstream types remain dynamically generated; examples in docs and
tests are illustrative, not a roster.

## Parent And Child Workgraph

### Portable Artifact Shape

```text
.kybernetes/<program>/
  manifest.md
  control.md
  verification.md
  decisions.md

  workstreams/<id>/
    contract.md
    status.md
    evidence.md

  inbox/<activation-id>/
    report.md
```

`control.md` is the global program truth and is written only by the lead governor
or an explicitly leased reconciler. `verification.md` is the admitted evidence
truth. `manifest.md` is a lean routing index, not an independent truth source.

Each workstream contract records:

- objective and measurable DONE condition;
- evidence source and verifier;
- expected parent program revision;
- activation rule: immediate, human, time, or event;
- owner or runtime handle;
- permissions and side-effect boundary;
- budget, attempt cap, and stop condition;
- dependencies and expected return contract; and
- owned status, evidence, and report paths.

A child chat, native goal, worker, detached session, or automation may update
only its owned workstream artifacts and submit a report to `inbox/`. It cannot
declare global acceptance or edit parent canonical state.

Very durable children may use `status.md` for local continuity. The parent
remains authoritative about whether the workstream is active, accepted,
superseded, terminally blocked, or complete.

Flat workstreams are the default. Nested child programs require explicit
justification, separate single-writer ownership, a return contract, and evidence
that a flat workgraph is insufficient.

### Reconciliation Flow

```text
activation reads manifest and assigned contract
-> validates program revision and workstream state
-> acquires bounded ownership when needed
-> performs bounded work
-> writes evidence and an inbox report
-> notifies the lead
-> lead verifies and accepts, rejects, retries, reframes, or retires
-> lead updates control.md
```

Multiple goals, automations, cron jobs, and synchronization jobs are allowed
when each implements a distinct activation need. They are not created per expert
personality. A native goal points to its workstream contract and remains
advisory. A synchronization job can collect or normalize reports, but cannot
admit evidence or change lifecycle state unless it holds the reconciler lease.

## Lean Boot And Dynamic Loading

Every actor starts with the smallest sufficient context:

1. Read `manifest.md`.
2. Read the current `control.md` summary and revision.
3. Read the assigned workstream contract.
4. Load only references required by the selected control move.

The always-loaded governor entrypoint contains only:

- canonical-state and single-writer invariants;
- readiness and routing rules;
- state-transition constraints;
- helper invocation rules;
- a reference index with one-line descriptions and load conditions; and
- portable fallback behavior.

Runtime bindings, expert-review procedure, topology patterns, recovery protocol,
verification methods, and closeout operations are lazy-loaded references or
helper skills.

`manifest.md` contains program identity, canonical pointers, current revision,
active workstream index, capability snapshot pointer, and named references with
one-line load reasons. If its revision differs from `control.md`, actors treat it
as stale and rebuild or request reconciliation before acting.

## Governor-Owned State Machine

Canonical program states are:

```text
designing
active
waiting_human
waiting_time
waiting_event
paused
verifying
recovering
blocked_terminal
superseded
completed
```

`waiting_human`, `waiting_time`, `waiting_event`, `paused`, `verifying`, and
`recovering` are recoverable. They cannot be mirrored into native terminal
`blocked`.

Native terminal status is irreversible enough to require canonical proof:

```text
Kybernetes MUST NOT mirror waiting_human, waiting_time, waiting_event,
paused, recovering, verifier-pending, provider-backoff, tool-unavailable, or
any other recoverable wait into a native terminal blocked state.

A native blocked write is allowed only when canonical_state == blocked_terminal,
the control record explains why the block is terminal under the current
objective, no known human answer, time passage, event, retry, fallback, or safe
migration can resume it, and recovery has failed or is unsafe.

A native complete write is allowed only when canonical_state == completed and
verification.md records admissible evidence.
```

This law remains in force even if Codex, Claude Code, or another runtime later
offers complete goal edit, pause, resume, clear, and unblock APIs.

## Capability Negotiation And Activation

Kybernetes binds semantic needs to observed runtime capabilities:

1. Classify the required L2 ports and lifecycle transitions.
2. Inspect the active agent-callable surface.
3. Reuse a dated capability snapshot when still valid.
4. Probe safely at program start, after binding failure, when drift is suspected,
   or before relying on a consequential capability.
5. Select the smallest reliable binding.
6. Fall back to portable files, manual checkpoints, external scheduling, or
   fresh-task migration when capabilities are missing.

Documentation is evidence of documented user behavior, not proof of
agent-callable availability. Capability records distinguish runtime, version,
provider, plan, CLI, app, cloud, and agent-callable surfaces where relevant.

### Activation Source Selection

- Prefer direct events when delivery is reliable, inspectable, and admissible.
- Use scheduled polling when no trustworthy event source exists.
- Use manual activation when automation cannot satisfy durability,
  notification, permission, or verification requirements.
- Match polling cadence to the expected change rate and cost of stale state.
- Treat no change as a normal result with an explicit no-change response.

Each detached or recurring activation contract includes:

- workstream ID and expected program revision;
- trigger, cadence, or event source;
- input and evidence sources;
- permitted side effects;
- idempotency key or deduplication rule;
- budget, attempt cap, and no-change behavior;
- notification path; and
- stop, escalation, and retirement conditions.

## Evidence, Research, And Verification

Online research is selected when a consequential decision depends on uncertain
external facts, a capability or policy may have drifted, local evidence conflicts
with documentation, an expert lens identifies a material assumption, or a
verifier requires external confirmation. A deterministic local sensor is
preferred when it can answer more reliably.

Evidence is labeled as:

- documented official behavior;
- verified active runtime behavior;
- reproducible local evidence;
- public issue or user report;
- expert or comparator judgment;
- inference; or
- recommendation.

Drift-prone claims are date-stamped and sourced. Public reports cannot override
verified local behavior, while documentation cannot prove tool availability.

`kybernetes:verify-run` is independent from the producing workstream and has rejection
authority against the agreed DONE condition. Subjective work uses explicit
rubrics and human acceptance where appropriate. Research workers remain
read-only unless separately authorized and return citations, conflicts, gaps,
confidence, and claim-to-source mappings.

## Failure And Recovery

- Stale child revision: perform no side effects and report staleness.
- Duplicate event or schedule: deduplicate by activation identity.
- Lost or expired ownership lease: stop writing and request reconciliation.
- Conflicting reports: quarantine both and compare evidence.
- Uncertain external side effect: inspect the external system before retrying.
- Missing notification path: detached work fails closed.
- Repeated failure: stop repeating the move and re-invoke
  `kybernetes:loop-architect` or
  request HITL.
- Stale native goal: preserve canonical state and migrate to a fresh task or
  fallback substrate.
- Missing resume, clear, or unblock capability: continue from the trust pair
  under a new binding rather than waiting for native repair.
- Runtime/canonical disagreement: `control.md` and `verification.md` win after
  integrity checks.

Portable filesystem leases are cooperative, not distributed transactions. File
bindings use revision checks, atomic replacement where available, and
fail-closed reconciliation. Production bindings may replace them with
transactional leases without changing the semantic contract.

### Migration Protocol

1. Freeze new side effects.
2. Reconcile reports and evidence.
3. Record current revision and unresolved uncertainty.
4. Create a fresh task or binding with canonical pointers.
5. Verify that the new lead reconstructed state correctly.
6. Rebind required automations.
7. Supersede and retire the old runtime surface.

## User Contract

Users provide the desired outcome, constraints and exclusions, timing or
cadence, risk and approval boundaries, and relevant systems or evidence sources.
Kybernetes asks only about choices that change outcomes, permissions, or human
judgment boundaries.

The governor explains its harness briefly without delegating harness design to
the user:

```text
I am using one durable parent program with two bounded workstreams.
Time-triggered checks will use scheduled activation; outreach remains
human-approved. control.md is canonical, and verification.md records evidence.
```

Ports, leases, migration mechanics, worker topology, polling, and cleanup remain
governor decisions unless the user requests detail.

## Test And Pressure Strategy

### Deterministic Tests

- Allowed and forbidden canonical state transitions.
- Recoverable waits never mapping to native terminal `blocked`.
- Single-writer enforcement and revision conflicts.
- Activation deduplication and idempotency.
- Stale manifests, contracts, reports, and capability snapshots.
- Helper input/output contracts.
- Dynamic reference-loading decisions.
- Closeout retention and deletion rules.

### Pressure Scenarios

- Small work correctly skips `kybernetes:loop-architect`.
- Short but consequential uncertainty triggers expert lenses.
- Long routine work does not trigger unnecessary expert review.
- Lenses and promoted workstreams are generated from the task, not a fixed
  roster.
- A temporary lens is promoted only after passing the workstream gate.
- Multiple chats attempt to edit parent state concurrently.
- Duplicate cron or event activations arrive.
- Event delivery is unreliable and polling is selected as fallback.
- Detached work lacks notification and fails closed.
- Runtime documentation advertises a capability absent from the callable
  surface.
- A recoverable HITL wait encounters an irreversible native blocked transition.
- A stale blocked goal requires fresh-task migration.
- Verification rejects a producer's completion claim.
- Learning capture attempts to promote a rule from one anecdote.
- Closeout stops automations but preserves canonical evidence.
- Cleanup attempts to delete unresolved or non-reproducible artifacts.

Live probes separately test Codex, Claude Code, and portable fallback bindings.
Results are date-stamped and distinguish CLI, app, cloud, plan, and
agent-callable surfaces.

## Delivery Sequence

Implement this architecture incrementally rather than as one change:

1. Canonical state machine, native-mirroring constraint, and capability
   negotiation.
2. Lean governor kernel, manifest, and lazy reference loading.
3. `kybernetes:loop-architect` with dynamic expert lenses and
   execution-contract output.
4. Parent/child workgraph, inbox reconciliation, automation, event, and polling
   rules.
5. `kybernetes:loop-closeout` with checkpoint, handoff, workstream, and program
   modes.
6. `kybernetes:verify-run` and `kybernetes:capture-learning` only after their
   pressure gates pass.
7. Stronger transactional or production backends only when portable file-based
   coordination proves insufficient.

Each stage remains portable, independently testable, and releasable. Existing
governor behavior must remain functional while responsibilities migrate.
Implementation planning is split by stage. The first implementation plan covers
stage 1 only; later stages receive their own pressure-backed specifications and
plans when their entry gates are satisfied.

## Deferred Decisions

These are deliberate future gates, not unspecified requirements:

- Exact packaging point for each helper skill, decided by pressure evidence and
  always-loaded context cost.
- Exact transactional backend, deferred until file-based coordination is
  insufficient.
- Recursive child programs, deferred until a flat workgraph fails a real case.
- Provider-specific automation and notification APIs, kept in dated runtime
  bindings.
- Automatic deletion policy beyond explicitly disposable artifacts; canonical
  state and admitted evidence default to archive, not deletion.

## Evidence Context

This design incorporates the existing Kybernetes layered runtime substrate,
L2-port contracts, runtime-use rubric, durable trust pair, binding audits, and
pressure scenarios. It also adopts only the useful, testable portions of
Anthropic's workflow and harness research:

- [Building effective agents](https://www.anthropic.com/research/building-effective-agents)
- [Effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [Harness design for long-running application development](https://www.anthropic.com/engineering/harness-design-long-running-apps)

Anthropic's chaining, routing, parallelization, orchestrator-worker,
evaluator-optimizer, and autonomous-agent patterns inform loop topology and
feedback architecture. They do not replace Kybernetes canonical lifecycle state
or capability negotiation.
