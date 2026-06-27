# Claude Code Binding

Use this file when the loop governor is running in Claude Code.

## Binding Table

- `{SET_GOAL}`: no universal persistent goal command. Use the lead prompt and the
  control record as the durable objective.
- `{SPAWN}`: use the Task tool or configured subagents for bounded worker tasks.
- `{ISOLATE}`: use git worktrees for concurrent writers.
- `{CONCURRENCY}`: keep everyday fan-out small unless slices are cleanly
  independent and the lead can integrate the summaries.
- `{INSPECT}`: use Claude Code's available agent/session inspection surfaces.
- `{RUN_ROOT}`: project-local `.kybernetes/<slug>/` for every Kybernetes-created
  run artifact.
- `{CONTROL_RECORD}`: project-local `.kybernetes/<slug>/control.md`, or an
  explicitly targeted external workstream or knowledge-base path.

## Lead Prompt Shape

```text
Use kybernetes:loop-governor.
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
record. Ask adaptive questions before major work and use HITL for unclear scope,
blockers, risk, or irreversible actions.
```

## Workers

Subagents should receive task contracts:

- Bounded objective.
- Sources or files to read first.
- Owned scope.
- Permission level and isolation.
- What not to touch.
- Done condition and verification.
- Return format.
- How to report impediments and cross-slice findings.

The lead integrates. Do not ask workers to merge the whole system themselves.

## Resume

On resume, read the control record before continuing. Refresh:

- Current checklist.
- Loop semantics and active altitude.
- Sensor/evidence and next activation.
- Worker registry.
- Open impediments.
- Latest decisions.
- Next checkpoint.

If the control record is missing or stale, reconstruct the smallest safe state
before making new edits.
