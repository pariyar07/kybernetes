# Activation And Notification Bindings

Activation answers what causes the next controlled comparison. It does not own
canonical state. Choose one trigger posture per activation: `immediate`,
`human`, `time`, or `event`.

## Activation Contract

```yaml
activation_id: act-2026-07-17-001
trigger: time
expected_canonical_revision: 14
input_pointer: <source>
first_check: <sensor>
allowed_effects: [<bounded effect>]
effect_key: <stable idempotency key>
budget: {attempts: 1, elapsed_minutes: 10}
no_change: record_and_stop
notification: <outbound path or none>
manual_checkpoint: <accepted cadence or none>
stop: [completed, superseded, budget_exhausted, verifier_lost]
retirement: <disable/delete/revoke action and owner>
```

Before effects, compare `expected_canonical_revision` with current
`canonical_revision`, validate capability and permission, and claim the tuple
`activation_id + canonical_revision + effect_key`. Duplicate delivery is
idempotent. Payload mismatch under an existing identity is quarantined. A stale
revision records supersession and stops.

## Trigger Choice

- `immediate`: continue in the active foreground loop.
- `human`: wait for approval, judgment, data, or an externally completed action.
- `time`: wake at a deadline or cadence; use bounded attempts and no-change.
- `event`: wake from a source event with stable identity and provenance.

Prefer a direct event when delivery, identity, authorization, and missed-event
recovery are reliable enough for the risk. Otherwise use scheduled polling with
explicit interval, backoff, cost/budget, no-change behavior, and end date. Event
plus polling is allowed only when deduplication makes both paths converge on the
same activation identity.

## Detached Gate

Do not activate detached work that can block, require HITL, or produce important
results unless it has a tested notification path or the user explicitly accepts
a manual checkpoint cadence. A configured but untested path is not sufficient
for high-impact work. If the gate fails, offer a one-shot foreground dry run.

No-change is a normal recorded outcome, not failure. It advances no canonical
claim beyond recording that the sensor observed no actionable difference.

## Multiple Automations And Tasks

One parent program may bind multiple schedules, event sensors, sync jobs,
workers, or peer tasks when each has a distinct bounded objective, activation
identity, revision, effect key, budget, and inbox return. Every binding reads the
canonical contract and reports through the workgraph; none writes parent truth.

## Retirement

Define retirement before activation. Retire on completion, supersession, budget
or attempt exhaustion, lost verifier/notification/permission, end date, or
terminal policy decision. Stop or disable the runtime object, revoke temporary
access, record the result, and escalate any machinery that could not be stopped.

## Capability Selection

Inspect actual callable create, inspect, update, pause, resume, delete, notify,
and event operations. Distinguish provider, plan, app, CLI, hosted, and
agent-callable surfaces. If a required transition is absent, choose a portable
foreground/manual binding rather than assuming documentation parity.
