# Runtime Use Rubric

Use this reference when a run could bind to runtime surfaces and the lead needs
to decide which ones are actually useful. The rubric is semantic-first:

```text
L0/L1 need -> L2 port -> L3 runtime binding -> portable fallback
```

Do not begin with a native feature and then search for a reason to use it. Name
the control need first, choose the smallest L2 port that addresses it, check
what the active runtime binding offers for that port, and keep a fallback that
preserves the same semantics.

For simple, reversible, well-scoped tasks, the right answer is often no extra
surface: stay in the current loop, do the work, run the verifier, and report the
result. Runtime surfaces should reduce uncertainty, risk, recovery cost, or
coordination load. If they mostly create ceremony, do not use them.

## Selection Protocol

Before binding a surface, answer these in order:

- What gap exists in the loop: setpoint, sensor, comparator, actuator, state,
  boundary, stop condition, or recovery?
- Which L2 port addresses that gap without adding unrelated machinery?
- Is the active L3 binding available in this runtime and allowed by the current
  permission boundary?
- What is the portable fallback if the native surface is unavailable, stale, or
  too heavy?
- What must be mirrored into L1 so `control.md` stays current truth and
  `verification.md` stays evidence truth?

If no clear loop gap exists, do not bind a new surface.

## Trust And Memory

Runtime memory, progress UI, goals, transcripts, task state, checkpoints,
worker summaries, and native histories are advisory unless mirrored into the L1
trust pair or recorded as recoverable pointers. Use runtime memory as a hint for
`lifecycle_recovery`, not as canonical state.

When durable state is needed:

- `control.md` holds current truth: objective, DONE, constraints, active
  checklist, decisions, boundary, and next activation.
- `verification.md` holds evidence truth: commands, checks, review methods,
  results, gaps, and rerun instructions.

## Port Rubrics

| Surface | Use when | Do not use when | Binding and fallback |
| --- | --- | --- | --- |
| `durable_objective` | The run may cross turns, resume after compaction, coordinate workers, or needs a persistent stop condition. | The task is small, one-shot, low-risk, and easy to verify in the current loop. Do not create an objective when target, DONE, verifier, or boundary is vague. | Bind to the active runtime's durable objective surface when ready; otherwise store objective, DONE, verifier, constraints, and recovery pointer in `control.md` or the lead prompt. |
| `planning_surface` | The correct altitude is `up`: scope, architecture, decomposition, risk, or product judgment must be settled before action. | The path is obvious, reversible, and locally verifiable. Avoid planning surfaces that delay a clear small edit. | Bind to the active runtime's planning surface when it helps; otherwise write a compact accepted plan in chat, `control.md`, or `checklist.md`. |
| `progress_surface` | Multiple steps, blockers, workers, or checkpoints need visible tracking. | A final response or one-line status is enough. Do not make runtime progress UI canonical by habit. | Bind to runtime checklist/progress state as advisory; mirror durable status, blocker, next checkpoint, and next activation into L1 when recovery matters. |
| `worker_spawn` | Cleanly separable slices can be owned, verified, and reintegrated with less cost or better coverage than sequential work. | Ownership, verifier, permission, or return format is unclear; integration cost exceeds the leverage; workers would hide state or duplicate effort. | Bind to the runtime's bounded worker surface; otherwise run the slice sequentially or provide a manual worker prompt and report contract. |
| `peer_workstream` | Work should leave the parent loop into a human-visible sibling track with its own owner, pointer, return path, and integration contract. | In-session worker delegation is enough, or the parent needs tight control over a single current truth. | Bind to a runtime peer/sibling/background surface only after recording owner, scope, pointer, return path, and integration plan; otherwise keep the work in the parent loop or use a human-created note/thread. |
| `isolation` | Concurrent writers, risky edits, divergent approaches, or external side effects need a separate workspace, branch, sandbox, or ownership boundary. | Work is read-only, single-writer, or easily sequenced. Do not isolate merely because a task feels large. | Bind to the runtime's isolation surface when available; otherwise use single-writer sequencing with explicit file ownership. Record state propagation for `.kybernetes/` artifacts before isolated work starts. |
| `inspect_status` | Worker, peer, scheduled, detached, or tool-driven work may have changed away from the parent loop and status must be sensed before acting. | The work is foreground, local, and directly observable. Do not treat status as proof of DONE. | Bind to the runtime's inspect/status surface when available; otherwise ask for a report or inspect artifacts manually. Pair with `verification_sensor` before claiming completion. |
| `verification_sensor` | DONE needs evidence that can reject bad output: tests, checks, review with rejection authority, citations, screenshots, command output, or human acceptance when named as the verifier. | The surface only gives advice, confidence, status, or self-report. Do not treat permission, progress, or worker completion as verification. | Bind to the proportionate runtime/tool sensor; otherwise run the smallest manual check that can reject bad output, record limits, or stop and ask for a verifier. |
| `comparator_augmentation` | A second opinion can improve judgment, expose blind spots, compare plans, or review tradeoffs before a decision. | You need admissible DONE evidence. Advisory comparison cannot replace `verification_sensor`. | Bind to an advisory review or second-pass surface; otherwise ask a human or perform a documented self-comparison. Record it as decision input, not evidence truth, unless it is re-run as a `verification_sensor` with a defined rejection method and recorded in `verification.md`. |
| `external_tool_provider` | A tool is the best bounded sensor or actuator for the task: repository inspection, local command, browser, docs, issue tracker, API, or other external system. | The same result is safely available from existing local context, or the tool would create side effects beyond the current boundary. | Bind through the active runtime's allowed tools; otherwise ask the human to run the tool or supply output. Record side effects, permission, result pointer, and evidence status. |
| `elicitation` | Human intent, missing input, permission, prioritization, acceptance, or risk judgment changes the outcome. | A safe default is obvious, reversible, and within the user's stated autonomy grant. Do not ask a fixed questionnaire. | Bind to the runtime's human input or approval surface; otherwise ask directly in chat. Record the answer, default, exact approved action, and changed boundary when durable. |
| `permission_boundary` | The loop needs to know whether an action is allowed, denied, requires approval, or crosses external/irreversible/private surfaces. | The action is already within a clear local, reversible, low-risk boundary. Permission checks should not become a ritual for tiny edits. | Bind to runtime permissions, sandbox, tool approval, or policy surfaces; otherwise write the assumption and ask the human before crossing the boundary. Permission authorizes action; it does not verify correctness. |
| `scheduler` | The user explicitly requests scheduled, recurring, detached, or background activation and the loop has cadence, input source, verifier, budget or attempt cap, stop condition, and approval. | The request is vague, one-shot, exploratory, or lacks notification/manual checkpoint coverage. Do not create recurrence to compensate for unclear objectives. | Bind to a runtime scheduler only when readiness and approval are complete; otherwise use a one-shot dry run, manual checkpoint, external reminder, or no schedule. |
| `event_sensor` | A concrete external event source can safely wake or steer the loop and its owner, admissibility, and next activation can be recorded. | The event source is vague, unreliable, unowned, or would make the loop react without a verifier or boundary. | Bind to a runtime event/monitor surface only after recording source, owner, admissibility, and fallback; otherwise use manual polling, a scheduled/manual check, or user-provided events. |
| `notification` | Detached, scheduled, recurring, or background work can complete, fail, or block away from the parent surface. | Work stays foreground, or the human explicitly accepts a manual checkpoint cadence. | Bind to an outbound runtime notification path where available; otherwise fail closed to foreground/manual control or ask the human to create an external reminder. |
| `lifecycle_recovery` | The loop resumes after compaction, handoff, branch/session change, failed worker, stale state, cancellation, or conflicting runtime memory. | The current state is obvious, current, and contained in the active loop. Do not perform destructive recovery without HITL. | Bind to runtime resume/inspect/recovery surfaces as hints; then re-anchor on `control.md`, `verification.md`, checklist, decisions, and worker reports. If underdetermined, ask before continuing. |
| `skill_package` | A reusable method package is relevant to the task and can supply workflow behavior without taking over the control plane. | The task is simple enough for direct execution, the package is unavailable or unreadable, or invoking it would add a second competing governor. | Bind to the runtime's skill/package loader when available; otherwise use a prompt template plus the relevant markdown references. A skill package is method guidance, not verification. |

## Review Surfaces

Review can bind to two different ports:

- Use `comparator_augmentation` when review is advisory judgment, tradeoff
  comparison, or a second-pass critique.
- Use `verification_sensor` when review has a defined rejection method against
  DONE and the result is recorded in `verification.md`.

Do not launder "looks good" into verification. If the review cannot reject bad
output, it is comparator input.

## Tool Surfaces

Tools are actuators or sensors only within the current permission boundary. A
tool result can become evidence when it is appropriate for the verifier and the
result is recorded. Tool availability alone does not prove completion.

Prefer the least side-effecting tool path that can answer the control question.
Escalate before tool use that sends messages, deploys, deletes, bills, changes
production state, exposes secrets, or writes to external systems.

Installing a plugin bundle is a `permission_boundary` decision, not a
`skill_package` load. Multiple runtimes now package rules, skills, agents,
hooks, and MCP servers together as one installable unit; accepting that
install can silently grant tool access, event hooks, and MCP servers in a
single action. Route plugin installation through the same capability-grant
reasoning as any other permission decision, and record what the bundle
actually granted, not just that a skill became available.

## Scheduled Or Detached Work

Scheduled, recurring, detached, event-driven, and background work needs a
stronger readiness gate because the loop can continue away from the parent
surface. Before binding `scheduler`, `event_sensor`, `peer_workstream`, or
detached-style `worker_spawn`, establish:

- Objective and explicit target surface.
- Cadence or return condition.
- Input source.
- Durable state surface.
- Admissible verifier.
- Budget, attempt cap, or no-change behavior.
- Safety/HITL boundary.
- Stop or escalation condition.
- Outbound notification path or explicitly accepted manual checkpoint cadence.

If any field is missing, return a decision surface or propose a one-shot dry run
instead of creating the detached surface.

## Recurring Cross-Tool Patterns

Two patterns now recur across multiple runtime bindings (not just one tool's
quirk). Treat the recurrence itself as evidence the pattern is a real
portable concern, while still binding each instance through its runtime's
own L3 reference rather than inventing a shared literal command.

**Advisory review features can sound like verifiers and are not.** Several
runtimes now ship deep, multi-stage, or cloud-run review features with
confidence language such as "independently reproduced and verified" or
extensive multi-pass analysis. Under adversarial verification, none of the
ones checked so far carry documented rejection authority: their own CLI/API
contracts return success regardless of whether findings exist, and their
own docs describe results as advisory input for a human to accept, dismiss,
or promote to a stricter check. Bind these to `comparator_augmentation`, not
`verification_sensor`, no matter how thorough the marketing language sounds.
The non-mixing rule under Review Surfaces above is the general law; this is
a concrete, recurring instance of teams needing to re-apply it as new
"AI review" features ship. A caller can still turn one into an admissible
sensor by building their own accept/reject gate on top of structured
(JSON/SARIF) output — but that composition is not what ships by default.

**Out-of-band steering from another device is now common, but not uniform.**
Multiple runtimes let a phone or browser steer a session whose tools
execute on user-owned compute. This is genuine two-way `elicitation` and
`notification`, not passive monitoring — but the session-identity and
pairing model differs meaningfully per runtime (symmetric multi-device sync
of one session vs. a persistent host a device pairs to vs. a cloud-hosted
agent loop with local tool execution). Do not write one shared prompt
assuming a single session-identity model; bind each runtime's variant
through its own L3 reference, and treat the pattern itself only as a signal
to check whether the active runtime has one.

## Over-Gating Check

Before finalizing the execution profile, ask:

- Would this surface make the work safer, more recoverable, more verifiable, or
  materially faster?
- Can the same control need be met by a short checklist, direct verification, or
  a single-writer loop?
- What new failure mode does this surface introduce?
- What condition would justify removing or not creating it?

If the new surface does not improve the loop, keep the run lightweight.
