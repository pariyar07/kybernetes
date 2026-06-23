# Portable Core

Use this file when the coordinator is running in a skill-compatible agent that
does not have a dedicated binding yet.

## Binding Key

Fill the right column for the current runtime:

| Placeholder | Meaning | Current runtime |
|---|---|---|
| `{SET_GOAL}` | How the lead sets or simulates a durable objective | |
| `{SPAWN}` | How the lead creates a bounded worker | |
| `{ISOLATE}` | How concurrent writers avoid collisions | |
| `{CONCURRENCY}` | Practical worker cap | |
| `{INSPECT}` | How to inspect or close running workers | |
| `{CONTROL_RECORD}` | Durable state file for this run | |

If a runtime lacks a persistent-goal feature, that is normal. Use a short lead
prompt plus a durable control record.

## Portable Launcher

```text
Use the parallel-coordinator skill.
Create or read control record: <path>.
Objective: <objective>.
Done when: <done condition>.
Verify with: <verification>.
Constraints: <constraints>.
Execution profile: generate task type, role stance, risk posture, artifacts,
verification style, communication cadence, and HITL triggers before significant
work.
Run the loop: sense, compare, act, verify, record. Ask adaptive questions when
the setpoint is unclear. Escalate with options plus a recommendation when human
input is needed.
```

## Adding A Runtime Binding

Create a dedicated reference file when a runtime has specific primitives for
goals, workers, isolation, inspection, permissions, or resume. Keep generic
coordination behavior in `SKILL.md` and `goal-checklist.md`; keep runtime
assumptions in the binding.
