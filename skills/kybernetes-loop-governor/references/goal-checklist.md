# Coordination Control Checklist

This is the reference shape for a coordinated run. Tool-specific names appear as
`{PLACEHOLDERS}` and are resolved by `codex.md`, `claude-code.md`, or
`portable-core.md`.

The durable objective should point to the control record, not paste the whole
checklist into chat. The control record is the runtime setpoint and audit trail.

## 0. Run Artifact Root

Create Kybernetes run artifacts under one project-local run root:

```text
.kybernetes/<slug>/
```

This root is for every file the Kybernetes skill creates for the run, including:

- `control.md`
- `checklist.md` or `plan.md`
- `verification.md`
- `decisions.md` or focused decision notes
- `agents.md` and `workers/<worker-id>-*.md` only when delegated work exists

Do not create Kybernetes run artifacts under legacy run roots from early drafts.

## 1. Control Record

Create or reuse a control record when the run is long-running, parallel,
high-risk, goal-driven, or likely to cross turns.

Default project-local control record path:

```text
.kybernetes/<slug>/control.md
```

External system path only when the user explicitly targets a knowledge base,
workstream system, or project-management surface:

```text
<workstream-system>/<slug>/Control.md
```

### Finding The Active Control Record

When resuming, setting a runtime goal, or continuing after compaction/handoff,
find the active control record before significant work.

Use this order:

1. Explicit path in the current prompt, handoff, or user answer.
2. Runtime goal, checklist, worker report, or resume prompt that names a
   `control.md`.
3. Project-local `.kybernetes/index.md`, manifest, or equivalent pointer if the
   project has one.
4. Recent `.kybernetes/*/control.md` candidates whose objective matches the
   current task.

If there are zero plausible candidates, reconstruct the smallest safe state from
available artifacts before acting. If reconstruction is under-determined or would
invent state, ask one targeted question instead. If there are multiple plausible
candidates, ask the user to choose and provide a one-line recommendation with why
one record appears safest.

Minimum sections:

- Objective
- Done condition
- Verification
- Constraints and out of scope
- Loop semantics
- Variety assessment
- Execution profile
- Important files and references
- Current checklist
- Worker registry
- Impediments
- Escalations
- Intervention requests
- Decisions
- Learnings
- Next checkpoint
- Next activation

Keep current state short. Split detailed history when useful:

- `decisions.md` for durable decisions.
- `agents.md` for delegated worker registry.
- `learnings.md` for reusable observations.
- `verification.md` for admissible sensors, latest evidence, failures, gaps,
  rerun instructions, and human acceptance.

Markdown is the default because agents and humans can read it quickly.
`events.jsonl` is deferred for v1. If it is introduced later, it is audit-only,
single-writer, ordered by append position, and never the current truth.

## 2. Inputs

Fill these before significant work:

- Objective: one objective, in a sentence or two.
- Done condition: the verifiable condition that ends the run.
- Verification: the test, check, artifact, command, citation set, screenshot,
  validator, or human acceptance that proves done.
- Constraints and out of scope: what must not change or regress.
- Important references: files, docs, tickets, boards, knowledge-base scopes,
  repos, or runtime notes that the lead must keep visible.

If DONE is not measurable, fix that before spawning workers.

## 3. Loop Readiness

Before creating loop machinery, check:

- Setpoint: objective and measurable done condition.
- Sensor/evidence: test, artifact, citation, screenshot, human acceptance,
  independent review, or another verifier that can reject bad output.
- Actuators: main thread, checklist, goal, workers, worktrees, tools, research,
  tests, or HITL.
- State: whether `.kybernetes/<slug>/` run memory is needed.
- Stop condition: success, blocked, re-frame, or human decision.
- Boundary: permissions, external effects, secrets, budget, and review.

If setpoint or sensor is vague, go `down` before acting: ask one targeted
question, define acceptance criteria, reproduce the issue, find evidence, or
reduce scope.

The verifier is admissible only when it can reject bad output without relying on
the generator's self-claim. Above Simple tasks, self-assertion is not enough.

Record:

- Active altitude: `stay`, `down`, `up`, `stack`, or `stop`.
- Why this altitude is right now.
- Sensor/evidence to inspect next.
- Next activation:
  - Trigger, condition, or time.
  - Owner/runtime.
  - First artifact to inspect.
  - Next decision.
  - Stop/escalation condition.
  - If activation depends on user approval, the exact action that approval
    unlocks.
  - If the work is complete, state that there is no next activation except
    optional follow-up.

Next checkpoint is the next within-run cadence or verification stop. Next
activation is the cross-turn, resume, scheduled, or approval-triggered condition
that tells a future loop how to restart safely.

## 4. Adaptive Pre-Flight

Sense first, then right-size the gate:

- Low variety: do not gate. Act and keep the loop lightweight.
- Medium variety: ask one or two choices that change the result.
- High variety: ask enough to define the setpoint, execution profile, safety
  boundaries, and decomposition.
- Extreme variety: create durable state, define the architecture/decomposition
  surface, choose the execution substrate, and establish integrated verification
  before implementation.

Choose from this menu only when it matters:

- Scope and done condition.
- Task type and role stance.
- Expected artifacts.
- Verification style.
- Decomposition.
- Worker model and reasoning style.
- Execution substrate.
- Coordination timing.
- Permissions.
- Concurrency.
- Budget and stopping rules.
- Human-in-the-loop triggers.

Present choices with a recommended default. The user should be able to reply
`go` or override one line.

For high and extreme work, the pre-flight must either ask for missing
outcome-changing decisions or state the defaults being chosen. A user granting
autonomy is a signal to choose safe defaults, not a reason to omit the
decision surface.

Record the variety assessment in the control record:

- Complexity level: low, medium, high, or extreme.
- Why this level: size, ambiguity, risk, independent parts, external impact,
  durable state, and verification needs.
- Control response: main thread, checklist, durable state, goal, workers,
  isolated workspace, parallel chats / sibling threads, cloud tasks, or HITL.

## 5. Execution Profile

Record the generated operating stance:

- Task type.
- Role stance.
- Risk posture.
- Expected artifacts.
- Verification style.
- Communication cadence.
- Escalation triggers.

The role stance is generated from the task. Examples include engineering lead,
product strategist, research synthesizer, incident coordinator, documentation
editor, or another posture. Do not hardcode a narrow personality.

## 6. Runtime Binding

Resolve the placeholders:

- `{SET_GOAL}`: how the lead sets or simulates a durable objective.
- `{SPAWN}`: how the lead creates workers.
- `{ISOLATE}`: how concurrent writers avoid collisions.
- `{CONCURRENCY}`: practical worker cap.
- `{INSPECT}`: how the lead checks worker status.
- `{CONTROL_RECORD}`: durable state file for this run.
- `{RUN_ROOT}`: durable run root for all Kybernetes-created artifacts.

Use the relevant binding file for the current runtime. If the runtime cannot set
a durable goal directly, write a copy-paste launcher for the user.

## 7. Execution Substrate

Pick the lightest surface that still controls risk:

- Main thread: coupled, small, or low-risk work.
- In-session workers: read-heavy fan-out, bounded reviews, research, test
  analysis, summarization.
- Isolated workspace: concurrent writers, divergent implementation branches, or
  risky edits.
- Parallel chats / sibling threads: large independent or multi-repo work where
  the human will supervise separate peer workstreams and the parent has an
  integration contract.
- Background/cloud sessions: async work whose result can return to the parent
  control surface.
- External automation: CI, scheduled sweeps, or batch jobs.

Read-heavy work can share a workspace. Concurrent writers need isolation or a
single-writer plan. Cross-cutting cleanup should be sequenced after feature work.

For high and extreme variety, record the worker/substrate decision even when the
answer is no fan-out:

- Why no workers yet: integration bottleneck, empty scaffold, unclear file
  ownership, or low leverage.
- Why workers now: independent slices, specialized review, risky contracts,
  broad test matrix, or separate research surfaces.
- Why isolated workspaces: concurrent writers, divergent implementation paths,
  or high collision risk.

## 8. Coordination Timing

- Fork-join: spawn, wait, integrate. Default for independent slices.
- Checkpointed: workers report at meaningful milestones.
- Async/background: use only when the runtime supports inspection and the control
  record can stay current.

Substrate answers where work happens. Timing answers when results return.

## 9. Permissions And Safety

Give each worker least privilege:

- Read-only for exploration and review.
- Scoped write for bounded implementation.
- Isolated write for concurrent writers.
- Human approval for irreversible or external actions.

Never move secrets or private data into summaries. Do not publish, deploy, push
shared branches, delete, bill, message external parties, or change production
state without explicit approval.

## 10. Worker Contracts

Each worker gets:

- Role and bounded objective.
- Sources or paths to read first.
- Owned scope.
- Files or areas it must not touch.
- Permission level and isolation.
- Done condition and verification.
- Return format.
- Impediment and escalation reporting.

Workers return distilled findings and evidence, not raw logs. The lead owns
integration and final verification.

Flat delegation is the v1 default. Recursive child loops are allowed only when a
worker brief explicitly grants bounded delegation and the child loop is
separately resumable, measurable, and scoped.

## 11. Integration

At integration:

- Compare worker outputs against the done condition and constraints.
- Resolve conflicts before applying changes.
- Re-run verification on the integrated state.
- Confirm the active altitude still fits. If integration fails, go `down` for
  evidence, `up` to re-frame, or `stop` for HITL rather than blind retry.
- Update the control record.
- Explain meaningful routing decisions in 1-2 lines.

Per-slice green does not imply integrated green.

## 12. Impediments, Escalations, And HITL

Use these buckets:

- Impediment: something blocking progress under current constraints.
- Escalation: a loop-level change in plan, scope, substrate, budget, or risk.
- Intervention request: a human decision needed now.
- Learning: a reusable observation from the run.

Escalate to the human when:

- The setpoint is unclear.
- The action is irreversible, external, production-facing, or privacy-sensitive.
- Workers disagree in a way that changes the result.
- Verification fails repeatedly.
- New evidence invalidates the plan.
- Permissions, budget, or time block progress.

When asking, give options and a recommendation.

## 13. Stop Conditions

- Success: DONE is verified with the agreed method.
- Blocked: no defensible path remains under current constraints. Report the
  smallest decision or input that would unblock it.
- Re-frame: the current objective or decomposition is wrong. Ask the human or
  rewrite the plan.
- Learn: record run-local observations and promote reusable rules only through
  the learning capture gate.

Map stop conditions to altitude:

- Verified success -> `stop`.
- Missing evidence -> `down`.
- Wrong objective or decomposition -> `up`.
- Need bounded workers -> `stack`.
- Human judgment or authorization needed -> `stop` with HITL.

## 14. Learning Capture

Promote a lesson only when it is supported by evidence, repeated pattern, or
verified failure; is general enough for future runs; and belongs in the target
audience. Keep hunches and one-off observations in the run record.
