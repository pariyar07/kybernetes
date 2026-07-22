# Runtime-Portable Trajectory Control Design

Status: proposed for review

Date: 2026-07-23

Scope: generic Kybernetes liveness, trajectory sensing, strategy steering, and runtime portability

## Decision Summary

Kybernetes will remain a generic steering layer rather than a customer-validation
workflow or a Codex-specific harness. The portable kernel will define control law,
state, evidence, authority, and failure semantics. Task adapters will define domain
metrics and thresholds. Runtime bindings will select the mechanisms actually
available in ChatGPT Work mode, Codex, Claude Code, Claude Cowork, or another compatible
agent surface.

The current safety, lifecycle, single-writer, verification, and closeout contracts
remain. A small liveness contract is added beside them:

- a typed progress measure;
- a measurement window and minimum acceptable delta;
- a cumulative no-progress cap;
- actionable capacity and fallback coverage;
- a distinct trajectory sensor;
- a strategy-change rule bounded by explicit authority; and
- a pause, escalation, supersession, or retirement path.

There will not be a new trajectory skill. The governor owns the control decision,
the completion verifier remains completion-only, and runtime adapters expose or
emulate the required sensing and activation capabilities.

## Evidence And Problem Statement

A long-running, channel-constrained discovery experiment remained internally
consistent while making no material progress. It repeatedly inspected account and
pending state, but delivered no substantive evidence-gathering payload after the
initial actions. Its verifier stayed green because it checked state integrity and
guardrails, not whether the experiment's uncertainty was shrinking.

That is not a negative domain verdict. It is a control-system failure:

1. an administrative action was counted as a substantive touch even though the
   evidence-gathering payload remained gated;
2. the dominant actuator did not have enough actionable capacity;
3. no approved fallback could restore reachability;
4. repeated no-change activations did not accumulate into a strategy decision; and
5. completion verification was asked to coexist with a concern it was not designed
   to measure.

The immediate design gap is therefore liveness, not more scheduling or more
workers. More activations would have amplified the same plan.

## Goals

- Reject durable plans that are safe but cannot plausibly produce the named
  progress signal.
- Detect a deteriorating or flat trajectory across activations.
- Change tactics without silently changing the objective, success standard, risk,
  audience, destination, or authority boundary.
- Preserve the difference between activity, progress, admissible evidence, and
  completion.
- Scale the harness to task variety instead of duration alone.
- Keep the same semantics across hosted, local, cloud, chat-based, and
  worktree-based agent runtimes.
- Keep one canonical writer even when work is distributed.

## Non-Goals

- A universal numeric threshold for every domain.
- A production workflow engine or distributed database in the file-based core.
- A separate persistent loop for every sensor or expert perspective.
- Treating a green schedule, successful model invocation, or coherent state file
  as evidence of outcome progress.
- Letting a run redefine DONE, manufacture weaker evidence, or expand authority to
  avoid reporting failure.
- Assuming that documented user-facing functionality is model-callable in every
  plan, app, version, or scheduled execution context.

## Architectural Decision

### Universal Kernel, Adapter-Defined Thresholds

Every durable adaptive loop has the following semantic contract:

| Field | Kernel meaning | Adapter responsibility |
| --- | --- | --- |
| `objective` | Stable outcome being pursued. | Supply the domain-specific outcome. |
| `program_kind` | Finite goal or continuing program. | Choose explicitly; do not force an ongoing policy into false completion. |
| `done_or_health` | Evidence-backed DONE for a finite goal, or health invariant plus review horizon for a continuing program. | Define admissible completion or cycle-health evidence. |
| `progress_model` | Whether the loop converges, learns, maintains an invariant, or waits for an event. | Select the model and define what a healthy window means. |
| `progress_metric` | Typed measure or observation that shows the selected model is working. | Define units, source, freshness, and admissibility. |
| `measurement_window` | Activations, events, or elapsed time over which progress is judged. | Choose a window appropriate to feedback latency. |
| `minimum_delta` | Smallest meaningful change, freshness, coverage, or event-state result per window. | Set a threshold justified by the task. |
| `no_progress_cap` | Consecutive or cumulative deficient windows tolerated before the current strategy is rejected. | Set a bounded cap and explain delayed-feedback exceptions. |
| `actionable_capacity` | Observations or actions currently reachable through approved sensors and actuators. | Show enough capacity to make the next window plausible. |
| `fallbacks` | Pre-authorized moves that can restore progress. | Define ordering, prerequisites, and capacity. |
| `strategy_envelope` | Changes the governor may make autonomously. | State approved channels, resources, claims, cadence, spend, and risk. |
| `escalation` | Human decision needed when the envelope is insufficient. | Identify the owner and exact decision. |
| `retirement` | Condition that stops useless or obsolete machinery. | Define cancellation and cleanup behavior. |

The kernel validates that these fields are coherent. It does not decide that two
interviews, ten tests, a one-percent error reduction, or a three-day window is
universally correct. Those are adapter decisions.

The progress models prevent convergence language from distorting other work:

| Model | Healthy window | Deficient window |
| --- | --- | --- |
| `convergence` | The outcome gap shrinks by the required amount. | The gap stays flat, grows, or becomes unmeasurable. |
| `information` | Admissible evidence reduces named uncertainty. | Activity occurs without new admissible information. |
| `maintenance` | Fresh evidence shows the invariant remains inside bounds with required coverage. | Coverage is stale/missing or the invariant leaves bounds. |
| `event_wait` | The event sensor remains fresh during a bounded wait, or the event arrives and advances the state. | The sensor is stale, the wait exceeds its bound, or repeated polling cannot affect the next decision. |

For maintenance, a zero numeric change can be healthy; freshness and coverage are
the meaningful delta. For event waits, time passage alone is not outcome progress,
but a bounded, fresh wait need not consume the no-progress cap. Continuing programs
complete bounded cycles and use a review or renewal horizon instead of pretending
to complete the ongoing policy objective.

### Architecture Admission Gate

An architecture contract is mandatory before activating an **extreme detached**
run. The helper skill is optional; the contract is not. A run is extreme detached
when it combines unattended or recurring activation with at least one of:

- consequential external effects;
- more than one independent actuator or workstream;
- feedback latency longer than one activation;
- material uncertainty about reachability or evidence admissibility;
- a horizon long enough that reconstruction from chat alone is unsafe; or
- a likely need to change strategy under bounded authority.

The contract may be a compact section in `control.md`. It must show the progress
metric, capacity, minimum delta, no-progress cap, fallback coverage, authority
envelope, verifier, and retirement rule. Invoking `kybernetes:loop-architect` is
recommended for high or extreme variety and required only when the governor cannot
produce or independently check this contract itself.

Example: a two-week discovery run seeks twelve admissible problem interviews. Its
substantive progress metric is evidence-bearing conversations, not invitations.
Before activation it must show enough reachable contacts to plausibly meet the
first window, distinguish invitation delivery from question delivery, and name an
approved alternate route. If the only route requires an acceptance event and no
fallback is authorized, the run stays in design or asks for authority; it does not
start a daily monitoring loop and call the design ready.

This gate does not apply to a one-shot local edit with an immediate test, a short
answer, or a reversible task whose next action and verifier are already obvious.

## Four Distinct Sensors

The word “verification” currently hides different control questions. Kybernetes
will keep four contracts separate:

| Sensor | Question | Typical cadence | Can declare DONE? | Canonical result |
| --- | --- | --- | --- | --- |
| Progress sensor | Did the last move or observation produce the admissible signal required by the progress model? | Every meaningful activation or event | No | Current progress observation |
| Safety sensor | Is the proposed action within permission, policy, privacy, budget, and reversibility boundaries? | Before effects and when context changes | No | Allow, deny, or ask with scope |
| Completion sensor | Does current evidence satisfy the stable DONE condition? | At a checkpoint or terminal claim | Yes, with rejection authority | `verification.md` verdict |
| Strategy or trajectory sensor | Is the current strategy likely to satisfy its progress model within the horizon, renewal period, and resources? | Per measurement window and after material failure | No | Continue, adapt, pause, escalate, or retire |

The trajectory sensor consumes progress observations, capacity, remaining budget,
feedback latency, and the plan. It must be able to reject “stay with the same move.”
It is not an extension of the completion verifier and does not turn a weak trend
into a completion claim.

The existing L2 `progress_surface` remains an advisory checklist or UI. It is not
a progress sensor. During implementation, pressure evidence should determine
whether `progress_sensor` becomes a named L2 port or remains a kernel observation
contract. `trajectory_sensor` is a distinct semantic sensor contract either way.

## Typed Outcome Funnel

Task adapters may use different stage names, but every external or multi-stage
workflow must distinguish semantic effects instead of collapsing them into
“touches” or “attempts.” The generic reference vocabulary is:

| Stage | Definition |
| --- | --- |
| `attempted` | An authorized actuator was initiated, including failed or ambiguous attempts. |
| `delivered` | The target system authoritatively confirmed delivery of the specifically typed artifact or effect. |
| `reached` | The intended target was exposed to the experiment's substantive payload. |
| `engaged` | The target responded or performed the intended interaction. |
| `evidence_acquired` | The engagement satisfied the domain admissibility rubric and reduced relevant uncertainty. |

Every event records both its stage and artifact type. A connection invitation can
therefore be a delivered invitation while remaining zero delivered discovery
questions. A queued deployment can be an attempted deployment while remaining zero
healthy releases. The adapter may add domain stages, but it cannot rename an
upstream proxy as a downstream outcome.

## Durable State

### State Placement

Use a hybrid model:

- `control.md` holds the current trajectory summary and the next control decision;
- `trajectory.md` is added only for high or extreme recurring/detached runs that
  need cross-window history; and
- `verification.md` remains the evidence record for DONE and does not become a
  telemetry ledger.

The lead governor or an explicitly leased reconciler is the sole canonical writer.
Children and schedules submit observations or reports; they do not edit the parent
trajectory verdict.

### Compact Trajectory Record

The current summary in `control.md` contains:

```yaml
trajectory:
  model: convergence | information | maintenance | event_wait
  metric: <typed metric and unit>
  source: <sensor or evidence pointer>
  window: <time, event, or activation window>
  minimum_delta: <adapter threshold>
  actual_delta: <observed delta>
  deficient_windows: <count>
  no_progress_cap: <count or budget>
  actionable_capacity: <current reachable work>
  remaining_horizon: <time, attempts, or resources>
  status: healthy | watch | unhealthy | unknown
  decision: continue | adapt | pause | escalate | retire
  next_measurement: <trigger and expected evidence>
```

When present, `trajectory.md` records one compact row or block per measurement
window: revision, interval, planned delta, actual admissible delta, capacity used,
failure classification, decision, and evidence pointers. It is not a raw event log.
Old windows may be compacted after their decisions and evidence remain
reconstructable.

## Trajectory Control Law

### Before Activation

1. Define the typed metric and evidence source.
2. Estimate actionable capacity for the first window.
3. Reject a plan whose capacity cannot plausibly meet its minimum delta.
4. Confirm at least one working path or an explicit experimental reason to test a
   single uncertain path.
5. Confirm fallback coverage for likely failure classes.
6. Confirm that fallback use is inside the authority envelope or has an escalation
   owner.
7. Set the no-progress cap and retirement rule before schedules are created.

### At Every Meaningful Activation

1. Read the current program revision and trajectory summary.
2. Observe new admissible domain evidence, not just administrative activity.
3. Classify the result as progress, expected waiting, actuator failure, sensor
   failure, strategy failure, or boundary-limited.
4. Update the current window and actionable capacity.
5. Avoid consuming the no-progress budget when feedback is still within an
   explicitly modeled latency window; do consume it when the activation merely
   repeats a known non-producing move.
6. Select a move that could change the next observation.

### At A Deficient Window

- Below the cap: use a pre-authorized fallback or a materially different tactic.
- At the cap: reject the unchanged strategy. Pause its activations and either use
  an approved strategy change, request a precise authority expansion, supersede the
  workstream, or retire it.
- If the sensor is missing or stale: mark trajectory `unknown`; do not infer health
  from runtime success.
- If no controllable path remains: report the limitation without changing DONE or
  manufacturing a domain verdict.

The same failing move cannot be reset by renaming the activation, spawning another
worker, or recreating the schedule. No-progress accounting follows the strategy and
objective, not the runtime handle.

## Strategy Authority

### Autonomous Changes Inside The Envelope

The governor may autonomously:

- reorder approved tactics and work queues;
- alter cadence within stated minimum and maximum bounds;
- allocate attempts or compute within an approved total budget;
- invoke an already approved fallback with the same audience, destination class,
  data boundary, claims, and risk level;
- pause or retire an ineffective actuator;
- split or merge internal workstreams while preserving single-writer ownership;
  and
- ask for clarification or approval.

### Owner Approval Required

The governor must ask before:

- changing the objective, finite DONE condition, continuing health invariant,
  evidence admissibility, or target population;
- using a new external channel, destination class, audience, identity, or account;
- making a new claim or materially changing a representation to third parties;
- installing a tool, enabling a connector, expanding filesystem/network access, or
  releasing additional information;
- increasing spend, attempt limits, rate, or reputational/legal/privacy exposure;
- scraping, enriching, purchasing, or sharing data outside the approved boundary;
  or
- converting an experiment's execution failure into a domain conclusion.

A strategy directive records the preserved objective, approved change, effective
revision, affected workstreams, expiry or review point, and owner when approval was
required. If a runtime can modify its own schedule, it may do so only when that
specific cadence range and mutation capability were pre-authorized. Otherwise it
writes a directive and the parent or human updates the schedule.

## Minimal Organizational Topology

The smallest viable long-horizon topology is:

```text
one lead governor and canonical writer
        |
        +-- zero or more bounded workers/workstreams
        |
        +-- progress, safety, completion, and trajectory observations
        |
        +-- one activation mechanism only when needed
```

The lead may perform all sensing inline. A separate supervisory schedule is added
only when the operational schedule cannot safely compare trajectory with plan, or
when independent cadence materially reduces blind spots. A separate evaluator is
used for terminal evidence when independence is required. Temporary planning or
review agents remain reports, not permanent departments.

Additional chats, workers, and schedules are admitted only when each has:

- a distinct objective or sensor;
- a bounded input and output contract;
- separate evidence or meaningful parallelism;
- permissions no broader than needed;
- one parent integration path; and
- an expected benefit greater than coordination cost.

Duration alone does not justify more topology. A month-long wait on one event may
need one schedule and two files; a ten-minute migration across three systems may
need several bounded workstreams.

## Runtime-Portability Contract

The kernel requests semantics, never a product command. Runtime bindings map these
capabilities:

- canonical or portable state surface;
- progress observation;
- trajectory evaluation;
- scheduler or event activation;
- worker or peer-workstream creation;
- status inspection and notification;
- completion verification;
- permission and information-release boundary; and
- lifecycle recovery.

Every binding can return `native`, `emulated`, or `unavailable`. A documented
feature is not considered available until the active agent-callable surface or a
safe probe confirms it. Native chat history, goals, schedules, project memory, and
runtime status remain advisory unless reconciled into portable canonical state.

### Current Official Surface Comparison

This table describes documented product surfaces as of 2026-07-23. It is binding
guidance, not a promise that every account or scheduled run exposes every tool.

| Concern | ChatGPT Work mode | Codex | Claude Code | Claude Cowork |
| --- | --- | --- | --- | --- |
| Scheduled activation | Web schedules can start fresh or return to an existing chat. Uploaded context, connected tools, skills, and plugins may be available. No local folder persists on web. | Desktop project schedules can run in the project or a dedicated worktree; local files require the machine and app. Standalone and same-chat schedules exist. | Session `/loop`, local desktop scheduled tasks, and cloud routines have different durability and permission models. Cloud/event-triggered runs start fresh. | Remote scheduled tasks create separate Cowork sessions and can use connected capabilities; local-resource access depends on desktop availability and task configuration. |
| Workers | Hosted subagents in Work mode. | Subagents and custom agents; sibling tasks or worktrees may provide isolation. | Subagents, agent view, and experimental teams/workflows; worktrees can isolate writers. | Coordinated subagents and plugin-provided agents within Cowork. |
| Durable native context | Same-chat schedules retain chat context; fresh schedules do not. Hosted context is not portable canonical truth. | Threads, goals, app state, and worktrees vary by surface; callable lifecycle transitions must be probed. | `/goal` is session-scoped; resumed sessions may restore the condition while counters reset. Desktop/cloud schedules commonly start new sessions. | Project instructions/files/memory can orient work, but Chat memory does not carry into Cowork and scheduled runs are separate sessions. |
| Computer and browser actions | Hosted browser/connected tools in Work mode where enabled. | Desktop browser, Chrome extension, and Computer Use where region, permissions, and plugins allow. | Browser, Chrome, computer-use, MCP, hooks, and channels vary by environment and configuration. | Browser/computer actions and connectors are available where enabled; local folders/apps require the desktop connection. |
| Permission consequence | Unattended schedules use configured sandbox/tool permissions; connected services remain separately bounded. | Project/worktree, sandbox, network, app, and computer permissions differ. | Local permission modes and cloud routine connector grants differ; cloud runs cannot stop for ordinary interactive prompts. | Manual/Auto/Skip and organization controls apply; remote automation must not be assumed to gain new folders, deletion rights, or connectors automatically. |
| Schedule mutation | ChatGPT or a skill can create or update schedules where the schedule tool is exposed. Probe the active run. | Same product family, but do not assume every Codex surface exposes schedule CRUD. | Some desktop scheduled-task bindings expose update tools; `/loop` is session-local. Probe before self-modification. | User-facing schedule management is documented; agent-callable self-modification should be treated as unavailable until probed. |

### Portable Fallbacks

- No durable native context: reconstruct from `control.md` and owned reports.
- No scheduler: use a human checkpoint or external scheduler with the same contract.
- No event source: bounded polling with a no-change budget.
- No worker primitive: execute sequentially or provide a bounded handoff prompt.
- No notification path: remain foreground or require an accepted manual cadence.
- No schedule-update capability: record a strategy directive and ask the owner or
  parent binding to change it.
- No safe external actuator: pause and ask; do not substitute a broader channel.

Kybernetes can preserve steering semantics across these runtimes. It cannot assume
that one runtime can resume another runtime's chat, share native goals, or inherit
its credentials and connector approvals. Cross-runtime continuity therefore
depends on portable state and explicitly rebound capabilities.

## Anti-Overengineering Rules

1. Start with one governor, one current-state record, and the task's natural
   verifier.
2. Add `trajectory.md` only for high/extreme recurring or detached work with more
   than one meaningful measurement window.
3. Add a workstream only for distinct ownership, evidence, permissions, or useful
   parallelism.
4. Add a schedule only for a named activation need and stop condition.
5. Add a supervisory schedule only when inline trajectory evaluation is
   insufficient.
6. Add independent completion evaluation only when consequence or evidence
   ambiguity warrants it.
7. Give every added component a retirement condition.
8. If coordination consumes more activations than domain work, shrink the harness.
9. Never create multiple schedules merely to simulate intelligence or resilience.
10. Prefer an inline contract over another artifact for low-variety work.

## Behavioral Pressure Scenarios

### Failing Baseline: Safe But Stalled Detached Run

The first scenario should be
`tests/pressure-scenarios/075-detached-run-remains-safe-but-stalled.md`.

Fixture:

- extreme detached run;
- one dominant actuator;
- canonical state and safety checks pass;
- two measurement windows produce zero admissible domain delta;
- administrative status checks continue to succeed;
- actionable capacity is exhausted;
- no approved fallback has usable capacity; and
- the proposed next action is the same status check and actuator path.

The pre-change governor is expected to accept another activation. The corrected
behavior must:

- reject `stay` with the unchanged move;
- mark trajectory unhealthy or unknown, never healthy;
- pause or retire the non-producing activation;
- select an approved materially different fallback, request a precise strategy
  decision, or supersede the workstream;
- keep administrative activity out of the progress metric; and
- avoid both a completion claim and a negative domain verdict.

### Required Companion Evaluations

1. **Semantic delivery:** a delivered invitation does not count as a delivered
   question or reached substantive payload.
2. **Readiness capacity:** an actuator that exists but has no reachable work fails
   readiness for the next window.
3. **Fallback coverage:** a dominant actuator with known gating needs either an
   approved fallback or an explicit single-path experiment with a tight stop rule.
4. **Cumulative stall:** recreating a schedule or worker does not reset the same
   strategy's no-progress budget.
5. **Authority preservation:** an approved fallback is autonomous; a new channel,
   audience, spend, connector, or data source triggers elicitation.
6. **Delayed feedback:** a modeled waiting period does not falsely consume the cap,
   but status-only polling beyond that period does.
7. **Sensor separation:** green safety and state consistency cannot make trajectory
   green or completion pass.
8. **Harness sizing:** a one-shot local change does not receive a trajectory ledger,
   extra chat, or schedule.
9. **Binding loss:** when a runtime lacks scheduler or notification capability, the
   run falls back to foreground/manual control rather than pretending detachment.
10. **Uncontrollable reality:** exhausted authorized paths yield a truthful pause or
    escalation, not weaker evidence or a rewritten target.

These evaluations would have rejected the failed discovery design before
activation because it lacked substantive delivery capacity, fallback coverage,
typed event semantics, and a cross-activation strategy gate.

## Failure Handling

- **Progress sensor failure:** mark the observation unknown and repair or replace
  the sensor; do not count runtime health as progress.
- **Actuator failure:** consume the actuator-specific attempt budget and use a
  materially different approved fallback.
- **Strategy failure:** pause affected activations before redesign so a bad plan
  cannot continue concurrently.
- **Permission uncertainty:** fail closed at the boundary and ask for the smallest
  necessary authorization.
- **Canonical-state conflict:** stop new side effects and reconcile through the
  single writer.
- **Runtime drift:** probe again, record the new capability snapshot, and bind a
  portable fallback.
- **External impossibility:** report what remains uncontrollable, preserve evidence,
  and use `paused`, `waiting_*`, `superseded`, or terminal failure only according to
  the existing lifecycle contract.

## Implementation Sequence After Spec Approval

1. Add scenario 075 and demonstrate the current behavioral gap.
2. Add the smallest rejection-capable liveness rule to the governor and the
   relevant reference contracts; do not add a new installable skill.
3. Add or revise only the L2 sensor contracts justified by the scenario.
4. Add the compact trajectory state shape and typed-outcome guidance.
5. Update runtime bindings for ChatGPT Work mode, Codex, Claude Code, and Claude Cowork,
   clearly separating official documentation from live probes.
6. Run companion evaluations, existing skill-boundary validation, and public
   boundary checks.
7. Publish a new version and update installed skills from that exact tag rather
   than from an unreleased branch.

## Confirmed, Inferred, And Unknown

### Confirmed

- The existing architecture already treats runtime mechanisms as replaceable L2/L3
  bindings and portable files as canonical.
- The failed run's state and safety checks could pass while its substantive
  information gain remained zero.
- Official product documentation for all four named surfaces supports some
  combination of scheduled work, tools/connectors, and delegated agents, but the
  execution and permission models differ.
- Fresh scheduled sessions are common; native conversation continuity cannot be the
  universal memory layer.

### Inferred Design Choices

- A distinct trajectory contract is the smallest change that can reject a safe but
  stalled plan without corrupting completion semantics.
- An inline mandatory contract, rather than mandatory invocation of an architect
  helper, provides the best balance for extreme detached runs.
- A compact separate trajectory ledger is justified only when several windows must
  survive reconstruction.

### Unknown Until Probed Or Decided

- Which schedule create/update/pause/delete operations are agent-callable in each
  account, app, and scheduled execution context.
- Which skills, plugins, connectors, browser, computer, and local-file capabilities
  survive into a particular unattended run.
- Whether Claude Cowork's selected local folder is available to a remote scheduled
  run without the desktop app; current official pages describe local/remote cases
  at different levels and should not be generalized.
- Whether `progress_sensor` should become a named L2 port or remain a kernel
  observation contract; pressure scenario 075 should decide this by showing the
  smallest enforceable change.
- The numeric thresholds for any real domain adapter.

## Official Sources

Accessed 2026-07-23:

- OpenAI, [Scheduled tasks](https://learn.chatgpt.com/docs/automations)
- OpenAI, [Subagents](https://learn.chatgpt.com/docs/agent-configuration/subagents)
- OpenAI, [Browser](https://learn.chatgpt.com/docs/browser)
- OpenAI, [Chrome extension](https://learn.chatgpt.com/docs/chrome-extension)
- OpenAI, [Computer Use](https://learn.chatgpt.com/docs/computer-use)
- OpenAI, [Git worktrees](https://learn.chatgpt.com/docs/environments/git-worktrees)
- Anthropic, [Persistent goals](https://code.claude.com/docs/en/goal)
- Anthropic, [Run tasks on a schedule](https://code.claude.com/docs/en/scheduled-tasks)
- Anthropic, [Desktop scheduled tasks](https://code.claude.com/docs/en/desktop-scheduled-tasks)
- Anthropic, [Cloud routines](https://code.claude.com/docs/en/routines)
- Anthropic, [Subagents and agent teams](https://code.claude.com/docs/en/agents)
- Anthropic, [Claude Cowork](https://claude.com/product/cowork)
- Anthropic Help Center, [Get started with Claude Cowork](https://support.claude.com/en/articles/13345190-get-started-with-claude-cowork)
- Anthropic Help Center, [Schedule recurring tasks in Claude Cowork](https://support.claude.com/en/articles/13854387-schedule-recurring-tasks-in-claude-cowork)

## Review Decisions

Before skill implementation begins, review and either approve or revise:

1. the extreme-detached architecture admission rule;
2. the five-stage generic outcome funnel;
3. the hybrid `control.md` plus conditional `trajectory.md` state model;
4. the autonomous strategy envelope and owner-approval boundary;
5. scenario 075 as the first failing baseline; and
6. the rule that runtime portability means invariant semantics plus capability
   probing, not identical product machinery.
