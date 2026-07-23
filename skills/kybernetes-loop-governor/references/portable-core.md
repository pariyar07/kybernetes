# Portable Core

## Activation Binding

When no reliable scheduler, event, or notification API is callable, represent
the activation contract durably and use foreground continuation or an explicit
human checkpoint. External cron may wake a fresh process only when it can pass
the activation identity, canonical revision, state pointers, and return path.

Use this file when the loop governor is running in a skill-compatible agent that
does not have a dedicated binding yet.

## Trajectory Binding

Evaluate the compact strategy contract in the lead loop. Record current health and
decision in `control.md`, use `trajectory.md` only for durable multi-window history,
and keep completion evidence in `verification.md`.

## Capability Probe

Record each required capability as native, emulated, unavailable, or unknown.

## Portable Fallback

Use foreground continuation, explicit human checkpoints, portable files, and an
external trigger only when it can pass revision, identity, state, and return data.

## Binding Key

Fill the right column for the current runtime:

| Placeholder | Meaning | Current runtime |
|---|---|---|
| `{SET_GOAL}` | How the lead sets or simulates a durable objective | |
| `{SPAWN}` | How the lead creates a bounded worker | |
| `{ISOLATE}` | How concurrent writers avoid collisions | |
| `{CONCURRENCY}` | Practical worker cap | |
| `{INSPECT}` | How to inspect or close running workers | |
| `{PARALLEL_THREAD}` | How the runtime supports human-visible sibling workstreams | |
| `{CONTROL_RECORD}` | Durable state file for this run | |
| `{RUN_ROOT}` | Root for Kybernetes-created run artifacts | |
| `{CANONICAL_STATE}` | Current state from `canonical-lifecycle.md` | |
| `{NATIVE_STATE}` | Advisory runtime state, if inspectable | |
| `{SUPPORTED_TRANSITIONS}` | Lifecycle transitions confirmed callable | |
| `{PORTABLE_FALLBACK}` | Foreground, manual, file-based, or fresh-binding fallback | |

If a runtime lacks a persistent-goal feature, that is normal. Use a short lead
prompt plus a durable control record.

Durable runs use the trust pair:

- `control.md`: current truth.
- `verification.md`: evidence truth.

Optional files such as `checklist.md`, `decisions.md`, `agents.md`, and worker
briefs/reports are created only when useful. `events.jsonl` is deferred and
audit-only if future pressure evidence requires it.

## Portable Launcher

```text
Use the kybernetes:loop-governor skill.
Create or read control record: <path>.
Objective: <objective>.
Done when: <done condition>.
Verify with: <verification>.
Constraints: <constraints>.
Execution profile: generate task type, role stance, risk posture, artifacts,
verification style, communication cadence, and HITL triggers before significant
work.
Loop readiness: define setpoint, sensor/evidence, actuators, state, stop
condition, and HITL boundary.
Run the loop: sense, compare, choose stay/down/up/stack/stop, act, verify,
record. Ask adaptive questions when the setpoint or sensor is unclear. Escalate
with options plus a recommendation when human input is needed. Record next
activation because portable runtimes may not preserve goal state.
Canonical lifecycle: preserve <canonical state>; treat <native state> as
advisory; use only <supported transitions>; fall back through <portable fallback>.
```

## Canonical Lifecycle And Divergence

When runtime state is missing, stale, or irreparable, keep the trust pair
canonical. Freeze new side effects, reconstruct the smallest safe continuation,
verify it, and create a fresh portable binding. Record any residual stale handle
as superseded and prevent it from receiving new activations.

## Adding A Runtime Binding

Create a dedicated reference file when a runtime has specific primitives for
goals, workers, isolation, inspection, permissions, or resume. Keep generic
coordination behavior in `SKILL.md` and `goal-checklist.md`; keep runtime
assumptions in the binding.
