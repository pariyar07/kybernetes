# Trajectory Control

Load this module for high/extreme recurring or detached work, repeated no-change,
multi-window experiments, continuing programs, or strategy redesign. Keep clear,
reversible, immediately verifiable work on the governor kernel alone.

## Program Contract

Every governed trajectory records:

```yaml
program_kind: finite
objective: evidence-backed outcome
done_or_health: terminal evidence or continuing health invariant
progress_model: convergence
progress_metric: typed admissible observation
measurement_window: bounded time, events, or activations
minimum_delta: smallest meaningful result for that window
no_progress_cap: maximum deficient windows for one strategy
actionable_capacity: reachable observations and actions
fallbacks: ordered pre-authorized alternatives
strategy_envelope: allowed autonomous changes
escalation: owner and exact decision
retirement: stop and cleanup condition
```

`program_kind` is `finite` or `continuing`. Finite work has evidence-backed DONE.
Continuing work has a health invariant, bounded cycles, and a review horizon; a
healthy cycle does not complete the continuing policy objective.

## Progress Models

| Model | Healthy window | Deficient window |
| --- | --- | --- |
| `convergence` | The outcome gap shrinks by `minimum_delta`. | The gap is flat, grows, or becomes unmeasurable. |
| `information` | Admissible evidence reduces named uncertainty. | Activity occurs without admissible information gain. |
| `maintenance` | Fresh evidence covers the invariant and remains inside bounds. | Coverage is stale, missing, or outside bounds. |
| `event_wait` | The event sensor remains fresh inside a bounded wait, or the event advances state. | The sensor is stale, the wait exceeds its bound, or polling cannot affect the next decision. |

Zero numeric change can be healthy for `maintenance`. A modeled fresh wait need
not consume the no-progress budget. Administrative activity, runtime success, or
unbounded status polling is not progress in any model.

## Four Sensor Questions

- Progress: did the move or observation produce the admissible signal required by
  the progress model?
- Safety: is the proposed effect inside permission, policy, privacy, budget, and
  reversibility boundaries?
- Completion: does admitted evidence satisfy finite DONE?
- Trajectory: can the current strategy satisfy its progress model within the
  remaining horizon, review period, capacity, and resources?

Safety and state consistency cannot make trajectory healthy. Trajectory cannot
declare completion. The completion verifier remains independently rejection-capable.

## Extreme Detached Admission

An extreme detached run requires an architecture contract before activation. The
contract may be inline in `control.md`; invocation of the architect helper is
optional. Record progress model and metric, capacity, minimum delta, no-progress
cap, fallback coverage, strategy envelope, verifier, notification, and retirement.
If capacity cannot plausibly satisfy the first window, stay in design or request
the smallest authority change.

Classify a detached run as extreme when unattended or recurring activation combines
with consequential external effects, multiple independent actuators/workstreams,
feedback latency longer than one activation, material uncertainty about reachability
or evidence admissibility, reconstruction risk beyond chat history, or likely
strategy change under bounded authority.

## Typed Outcome Funnel

- `attempted`: an authorized actuator was initiated, including failed or ambiguous attempts.
- `delivered`: the target system confirmed delivery of the specifically typed artifact or effect.
- `reached`: the intended target was exposed to the substantive payload.
- `engaged`: the target responded or performed the intended interaction.
- `evidence_acquired`: the engagement met the domain admissibility rubric and reduced uncertainty.

Record the stage and artifact type. An upstream proxy cannot be renamed as a
downstream outcome.

## Durable State

Keep the current trajectory summary in `control.md`: model, metric, source,
window, minimum and actual delta, deficient-window count, cap, actionable
capacity, remaining horizon, health, decision, and next measurement.

Create `trajectory.md` only for high/extreme recurring or detached work that
needs several windows to survive reconstruction. Record one compact block per
window: revision, interval, planned and actual admissible delta, capacity used,
failure class, decision, and evidence pointers. It is not raw telemetry and it
does not replace `verification.md`.

Only the lead governor or leased reconciler writes the parent trajectory verdict.
Children return observations and evidence.

## Control Law

Before activation, reject missing or implausible capacity, unbounded no-progress,
and known actuator gating without a fallback or an explicit single-path experiment
with a tight stop rule.

At each meaningful activation, classify new evidence as progress, expected waiting,
actuator failure, sensor failure, strategy failure, or boundary-limited. Update the
window and capacity. Repeated execution of a known non-producing move consumes the
cumulative no-progress budget.

Below the cap, choose a materially different pre-authorized tactic when available.
At the cap, reject `stay` with the unchanged strategy: pause its activations, then
adapt inside the envelope, request a precise authority decision, supersede the
workstream, or retire it. Recreating a worker, task, chat, or schedule does not reset
the same strategy's budget.

## Autonomous Changes Inside The Envelope

The governor may reorder approved tactics, alter cadence inside stated bounds,
allocate attempts inside an approved total budget, use an approved fallback with
the same audience/destination/data/claims/risk boundary, pause or retire an
ineffective actuator, and change internal topology while preserving one writer.

## Owner Approval Required

Ask before changing objective, finite DONE, continuing health invariant, evidence
admissibility, target population, external channel, destination class, audience,
identity, claims, tool installation, connector grants, filesystem/network access,
information release, spend, rate, attempt cap, data acquisition, or legal/privacy/
reputational exposure. Execution failure cannot be converted into a domain verdict.

Self-modify a schedule only when the callable operation and cadence range were
pre-authorized. Otherwise record a strategy directive for the parent or owner.
A directive records the preserved objective, approved change, effective canonical
revision, affected workstreams, expiry or review point, and approving owner when
approval was required.

## Harness Sizing

Start with one governor, one current-state record, and the natural verifier. Add a
trajectory ledger, workstream, schedule, supervisory activation, or independent
evaluator only for a named failure mode and give it a retirement condition. If
coordination consumes more activations than domain work, shrink the harness.
