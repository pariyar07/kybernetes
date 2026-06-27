# Codex Binding

Use this file when the loop governor is running in Codex.

## Binding Table

- `{SET_GOAL}`: prefer the available goal tool when the environment exposes one
  and policy allows it. If the agent cannot set the goal itself, return a
  copy-paste `/goal` prompt to the user.
- `{SPAWN}`: spawn subagents only when explicitly useful. Worker prompts receive
  task contracts, not slash commands.
- `{ISOLATE}`: use git worktrees for concurrent writers.
- `{CONCURRENCY}`: obey the current Codex agent/thread limits. Keep fan-out small
  unless the slices are cleanly independent.
- `{INSPECT}`: inspect or close worker threads with the runtime's agent/thread
  inspection surface.
- `{RUN_ROOT}`: project-local `.kybernetes/<slug>/` for every Kybernetes-created
  run artifact.
- `{CONTROL_RECORD}`: project-local `.kybernetes/<slug>/control.md`, or an
  explicitly targeted external workstream or knowledge-base path.

## Goal Behavior

The goal belongs to the loop governor thread. Workers must not receive `/goal`
commands.

In Codex, the model may see goal state across turns through the runtime, but do
not rely on the goal alone. The stable recovery point is the control record. Read
or refresh it at kickoff, resume, before irreversible actions, after worker
returns, and whenever the loop stalls.

## Minimal `/goal` Prompt

Use the shortest prompt that preserves the loop:

```text
/goal Use $kybernetes:loop-governor.
Objective: <objective>.
Read first: <path-to-control-record>.
Operating model: <path-to-skill>/references/operating-model.md.
Done when: <done condition>.
Verify with: <verification>.
Constraints: <constraints>.
Artifacts: <control record, checklist, worker registry, evidence, plans, tests>.
Loop readiness: setpoint, sensor/evidence, actuators, state, stop condition,
and HITL boundary.
Altitude: choose stay, down, up, stack, or stop at checkpoints.
Loop: sense, compare, choose altitude, act, verify, record. Ask HITL when scope,
risk, blockers, or irreversible actions need a human decision.
```

If no control record exists yet, create one first for non-trivial runs. If the
agent cannot create files, replace `Read first` with the path the user should
create and include a compact control-record template.

## Goal Fallback

If `/goal` is unavailable, fails, or the agent is not allowed to call the goal
tool:

1. Continue in the current chat with the same control record.
2. Return the copy-paste `/goal` prompt to the user.
3. State that the run can continue without goal mode as long as the control
   record is maintained.

Do not bury the fallback in prose. Put it in a fenced block the user can copy.

## Subagents

Codex workers should receive:

- A bounded objective.
- Owned paths or sources.
- Permission level.
- Things not to touch.
- Done condition and verification.
- Return format.
- Instruction to report impediments, conflicts, or findings that affect other
  workers.

The loop governor integrates worker summaries and updates the control record.

For high and extreme variety in Codex, decide explicitly whether to use
subagents, parallel chats, isolated workspaces, or a single-writer loop. Record
the choice in the control record. A valid decision can be "no subagents yet",
but it must include the reason and the condition that would trigger fan-out.

## Parallel Chats

Use separate chats only when the user asks for them or when a long-running task
needs human-visible independent tracks. Record why a side chat is preferable to
an in-session worker, what it owns, and how its output will return to the
control record.

## Goal Artifact References

When Codex keeps a goal as prompt state, include references to the durable run
surface rather than only the abstract objective. Kybernetes-created run files
belong under `.kybernetes/<slug>/...`. At minimum, reference:

- Control record.
- Current checklist or plan.
- Worker registry when workers exist or were considered.
- Evidence or verification report.
- Important created files or docs that future turns must recover.

Keep the goal concise. The goal should point to artifacts; it should not become
the artifact.

## Copy-Paste Launcher

```text
Use $kybernetes:loop-governor.
Create or read control record: <path>.
Objective: <objective>.
Done when: <done condition>.
Verify with: <verification>.
Constraints: <constraints>.
Execution profile: generate the task type, role stance, risk posture, artifacts,
verification style, cadence, and HITL triggers before significant work.
Loop readiness: define setpoint, sensor/evidence, actuators, state, stop
condition, and HITL boundary.
Keep the loop active: ask adaptive questions when the setpoint or sensor is
unclear, choose stay/down/up/stack/stop at checkpoints, update the control
record after meaningful results, explain routing decisions briefly, and escalate
with options plus a recommendation when human input is needed.
```
