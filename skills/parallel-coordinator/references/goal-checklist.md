# Coordination Control Checklist

This is the reference shape for a coordinated run. Tool-specific names appear as
`{PLACEHOLDERS}` and are resolved by `codex.md`, `claude-code.md`, or
`portable-core.md`.

The durable objective should point to the control record, not paste the whole
checklist into chat. The control record is the runtime setpoint and audit trail.

## 0. Control Record

Create or reuse a control record when the run is long-running, parallel,
high-risk, goal-driven, or likely to cross turns.

Default non-vault path:

```text
.agent-runs/<slug>/control.md
```

Vault path only when the user explicitly targets a vault/scope:

```text
Agent/Workstreams/<slug>/Control.md
```

Minimum sections:

- Objective
- Done condition
- Verification
- Constraints and out of scope
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

Keep current state short. Split detailed history when useful:

- `decisions.md` for durable decisions.
- `workers.md` for worker contracts and status.
- `learnings.md` for reusable observations.
- `events.jsonl` only for high-volume append-only telemetry.

Markdown is the default because agents and humans can read it quickly. JSONL is
useful for machine logs, not for the main operating surface.

## 1. Inputs

Fill these before significant work:

- Objective: one objective, in a sentence or two.
- Done condition: the verifiable condition that ends the run.
- Verification: the test, check, artifact, command, citation set, screenshot,
  validator, or human acceptance that proves done.
- Constraints and out of scope: what must not change or regress.
- Important references: files, docs, tickets, boards, vault scopes, repos, or
  runtime notes that the lead must keep visible.

If DONE is not measurable, fix that before spawning workers.

## 2. Adaptive Pre-Flight

Sense first, then right-size the gate:

- Low variety: do not gate. Act and keep the loop lightweight.
- Medium variety: ask one or two choices that change the result.
- High variety: ask enough to define the setpoint, execution profile, safety
  boundaries, and decomposition.

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

## 3. Execution Profile

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

## 4. Runtime Binding

Resolve the placeholders:

- `{SET_GOAL}`: how the lead sets or simulates a durable objective.
- `{SPAWN}`: how the lead creates workers.
- `{ISOLATE}`: how concurrent writers avoid collisions.
- `{CONCURRENCY}`: practical worker cap.
- `{INSPECT}`: how the lead checks worker status.
- `{CONTROL_RECORD}`: durable state file for this run.

Use the relevant binding file for the current runtime. If the runtime cannot set
a durable goal directly, write a copy-paste launcher for the user.

## 5. Execution Substrate

Pick the lightest surface that still controls risk:

- Main thread: coupled, small, or low-risk work.
- In-session workers: read-heavy fan-out, bounded reviews, research, test
  analysis, summarization.
- Isolated workspace: concurrent writers, divergent implementation branches, or
  risky edits.
- Parallel chats or background sessions: large independent work where the human
  will supervise separate threads.
- External automation: CI, scheduled sweeps, or batch jobs.

Read-heavy work can share a workspace. Concurrent writers need isolation or a
single-writer plan. Cross-cutting cleanup should be sequenced after feature work.

## 6. Coordination Timing

- Fork-join: spawn, wait, integrate. Default for independent slices.
- Checkpointed: workers report at meaningful milestones.
- Async/background: use only when the runtime supports inspection and the control
  record can stay current.

Substrate answers where work happens. Timing answers when results return.

## 7. Permissions And Safety

Give each worker least privilege:

- Read-only for exploration and review.
- Scoped write for bounded implementation.
- Isolated write for concurrent writers.
- Human approval for irreversible or external actions.

Never move secrets or private data into summaries. Do not publish, deploy, push
shared branches, delete, bill, message external parties, or change production
state without explicit approval.

## 8. Worker Contracts

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

## 9. Integration

At integration:

- Compare worker outputs against the done condition and constraints.
- Resolve conflicts before applying changes.
- Re-run verification on the integrated state.
- Update the control record.
- Explain meaningful routing decisions in 1-2 lines.

Per-slice green does not imply integrated green.

## 10. Impediments, Escalations, And HITL

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

## 11. Stop Conditions

- Success: DONE is verified with the agreed method.
- Blocked: no defensible path remains under current constraints. Report the
  smallest decision or input that would unblock it.
- Re-frame: the current objective or decomposition is wrong. Ask the human or
  rewrite the plan.
- Learn: record what should improve the next run.
