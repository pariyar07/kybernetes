# Codex Binding

Use this file when the loop governor is running in Codex.

## Binding Table

| Portable primitive | Codex binding |
| --- | --- |
| `{SET_GOAL}` | Prefer `/goal` when work is long-running, resumable, or needs a durable stopping condition. Keep goal state advisory; recover from `control.md`. If the agent cannot set the goal, return a copy-paste `/goal` prompt. |
| Planning altitude | Use `/plan` when the correct move is `up`: architecture, scope, decomposition, or product judgment before action. |
| Checklist / progress | Use in-session plan/checklist state when helpful; mirror durable progress into Kybernetes-owned `checklist.md` only when needed. |
| `{PARALLEL_THREAD}` | Use parallel chats / sibling threads for human-visible peer workstreams, multi-repo coordination, or large tasks that need separate context and owner. Treat this binding as app-surface / partial until the installed Codex surface is verified. |
| `{SPAWN}` | Use Codex subagents for bounded in-session delegation. Worker prompts receive task contracts, not slash commands. |
| Async delegated work | Use Codex cloud tasks only when the result can be captured back into the parent control surface. |
| `{ISOLATE}` | Use Codex worktrees or manual `git worktree` for concurrent writers. Cloud containers are separate isolation. |
| `{CONCURRENCY}` | Obey Codex agent/thread limits. Keep fan-out small unless slices are cleanly independent; assume flat delegation unless the runtime and parent contract explicitly support more. |
| `{INSPECT}` | Inspect, steer, or close workers through the runtime's agent/thread inspection surface when available. |
| Permission boundary | Respect approval policy, sandbox mode, `/permissions`, and MCP tool policy. Treat destructive, external, production, publishing, billing, secrets, or customer-data actions as HITL boundaries. |
| Skill package | Codex Agent Skills are the public packaging surface. Keep the main skill lean and lazy-load `references/`. |
| External tool provider | Use MCP, browser, docs, GitHub, web, or other tools as bound sensors/actuators, not as product core. |
| Verification sensor | Use tests, commands, `/review`, reviewer subagents, citations, screenshots, or human acceptance as proportionate sensors. No single Codex feature is the universal verifier. |
| Hooks / audit | Hooks are optional bootstrap/audit infrastructure. Do not use them for full uninvited governance in v1; prefer native hooks over hand-maintained `events.jsonl` if audit later becomes necessary. |
| Automations | Use Codex app/cloud automations only for stable recurring loops after manual pressure evidence exists and the user explicitly approves activation. Never create or activate a scheduled loop from vague "check every day" / "improve whatever looks bad" language. Do not assume a bare CLI scheduler; use external cron/launchd or a manual checkpoint in portable fallback. |
| Memory | Treat Codex memory as advisory. Durable run truth lives in `control.md` and evidence truth in `verification.md`. |
| Lifecycle | On resume, compact, fork, or handoff, re-anchor on `control.md`, then `verification.md`, checklist, and worker reports as needed. |
| `{RUN_ROOT}` | Project-local `.kybernetes/<slug>/` for every Kybernetes-created run artifact. |
| `{CONTROL_RECORD}` | Project-local `.kybernetes/<slug>/control.md`, or an explicitly targeted external workstream or knowledge-base path. |

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
subagents, parallel chats / sibling threads, cloud tasks, worktrees, or a
single-writer loop. Record the choice in the control record. A valid decision
can be "no subagents yet", but it must include the reason and the condition that
would trigger fan-out.

In delegated Codex runs, read the delegation payload as context, not as a
complete execution contract. A `source_thread_id`, prior-thread handoff, or
instruction to "move fast" does not by itself identify the target workflow,
done condition, verifier, or safety boundary. If those are missing, do not spawn
workers or create sibling threads yet. First return or record the smallest decision
surface that would make the worker contract measurable.

Use a single-writer discovery loop when the likely target files are not yet
partitioned. Spawn workers only after the lead can give each worker owned paths
or sources, permission level, done condition, verifier, and return format.

## Parallel Chats / Sibling Threads

Use separate chats only when the user asks for them or when a long-running task
needs human-visible independent tracks. Record why a sibling thread is
preferable to an in-session worker, what it owns, its durable state pointer, and
how its output will return to the parent `control.md`.

Do not collapse these surfaces:

- parallel chats / sibling threads: human-visible peer workstreams
- subagents: in-session delegated workers
- forks: alternate continuation of a thread
- cloud tasks: async isolated runtime work
- worktrees: filesystem/branch isolation
- side chats: explanatory or status side conversations

A sibling thread counts as `stack` only when it has a setpoint, admissible
sensor, owner, boundary, and return path.

## Automations

Treat Codex automations as externalized loop actuators, not as ordinary local
edits. Before creating or activating one, the parent governor must know:

- Objective and explicit target surface.
- Cadence and next activation.
- Input source.
- Durable state surface.
- Admissible verifier.
- Budget, attempt cap, or no-change behavior.
- Safety/HITL boundary and stop/escalation condition.
- User approval for activation.

If any field is missing, do not create the automation. Offer a one-shot dry run,
manual checkpoint, or decision surface instead. Paused or draft automation
configuration is still a created runtime object; only produce it after the user
has accepted that artifact as the next actuation step.

## Skill Interop

When another skill is invoked while Kybernetes is active in the same context,
yield method to the specialist skill and keep the control plane:

- objective and DONE
- risk boundary
- parent-owned verifier
- integration decision
- durable state if needed

Do not double-govern with a redundant Kybernetes checklist. A specialist skill's
"done" is evidence, not verified truth; rerun or adjudicate the parent-owned
sensor on the integrated result.

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
