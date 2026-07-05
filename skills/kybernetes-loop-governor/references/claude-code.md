# Claude Code Binding

Use this file when the loop governor is running in Claude Code.

## Binding Table

| L2 port or layer | Claude Code binding | Caveat / fallback | Evidence and state obligation |
| --- | --- | --- | --- |
| `durable_objective` | Use the lead prompt, current session, and `control.md` as the durable objective. If the active surface exposes a goal-like or task-like state, treat it as advisory. | Do not assume a universal persistent goal command. If native persistence is unavailable, continue from the trust pair. | Mirror objective, DONE, verifier, constraints, and recovery pointer into `control.md`. |
| `planning_surface` | Use plan mode, plan permission mode, or a compact planning prompt when the correct move is `up`. | If plan mode is unavailable or unnecessary, write the plan in chat or `control.md`. | Accepted plan, assumptions, rejected alternatives, and next checkpoint belong in L1 state when durable. |
| `progress_surface` | Use todo/session state, task lists, or the current transcript as advisory progress. | Runtime UI state is not canonical unless recoverable and linked from L1. | Mirror durable progress into `checklist.md` or `control.md` when needed. |
| `worker_spawn` | Use the Agent tool, Task tool, configured subagents, or project/user subagents for bounded worker tasks. | Keep delegation flat unless the worker brief explicitly grants bounded child loops. | Worker output is evidence input; parent loop owns integration and final verification. |
| `peer_workstream` | Use separate Claude Code chats, sessions, background agents, or agent teams only for human-visible peer workstreams with their own owner and return path. | Treat background or team features as surface-specific. If unavailable, use a manual sibling note/thread or stay in the parent loop. | Record owner, scope, durable pointer, return contract, and integration decision in `control.md`. |
| `isolation` | Use git worktrees, branch/session boundaries, permission modes, or sandboxed/cloud sessions for concurrent writers. | Isolated sessions may not carry ignored `.kybernetes/` state automatically. | Before spawning isolated work, pass either a copied brief, an absolute parent run-root pointer, or a rule that the worker must not depend on reading parent L1 files directly. Record the state-propagation choice. |
| `inspect_status` | Use available task/session inspection, task lists, agent status, command output, or tool results. | Silence is not success. If inspection is unavailable, ask for a report or return to foreground/manual control. | Record inspected surface, status, report pointer, blocker, and next action in `control.md`. |
| `verification_sensor` | Use tests, commands, review skills, review subagents, tool output, screenshots, citations, or human acceptance when they can reject bad output. | No single Claude Code feature is the universal verifier. Advisory review is not verification unless it has rejection authority and is recorded as evidence. | Record command/method, result, coverage, gaps, and acceptance decision in `verification.md`. |
| `comparator_augmentation` | Use advisor/reviewer-style second passes, review subagents, or human second opinions as advisory comparison at decision points. | Comparator input cannot replace `verification_sensor`. | Record comparator advice in `control.md` decisions, not as DONE evidence unless separately promoted to verification. |
| `scheduler` | Use scheduled prompts or recurring task surfaces only when the active Claude Code surface supports them and the user approves activation. | If native scheduling is unavailable, use external cron/calendar, human-created reminders, or manual checkpoint fallback. | Record cadence, input source, state surface, verifier, budget/attempt cap, stop condition, and approval. |
| `event_sensor` | Use MCP channels, plugin monitors, hooks, or external event sources only when a concrete event source is named and trusted. | Kybernetes has no generic v1 event bus. If event delivery is unreliable, use manual polling or scheduled/manual checks. | Record event source, owner, admissibility, and next activation in `control.md`. |
| `notification` | Use Claude Code notifications, task/session updates, configured channels, or another outbound path for detached work. | Detached/background/scheduled surfaces must fail closed without outbound notification or an explicitly accepted manual checkpoint cadence. | Record notification path or accepted manual cadence before detached work can block away from the parent chat. |
| `external_tool_provider` | Use MCP, shell, filesystem, browser/web, GitHub, plugins, or built-in tools as bounded sensors/actuators. | Tool availability and side effects are governed by permissions, settings, and sandboxing. | Record side effects, permission decision, result pointer, and whether output is sensor evidence. |
| `elicitation` | Use chat, AskUserQuestion, permission prompts, plan approval, tool approval prompts, or HITL prompts. | If the answer changes objective, boundary, or approval, re-sense before acting. | Record exact question, answer/default, approved action, and changed boundary when durable. |
| `permission_boundary` | Respect permission modes, allowed/denied/ask rules, directory access, managed settings, hooks, and tool approval prompts. | Autonomy grants do not imply permission for irreversible, external, secret-bearing, customer-visible, production, billing, publishing, or destructive actions. | Record allowed/denied/ask status and exact unlocked action in `control.md`. |
| `lifecycle_recovery` | On resume, compaction, branch/session recovery, rewind/checkpoint restore, or handoff, re-anchor on `control.md`, then `verification.md`, checklist, and worker reports. | Runtime memory, transcripts, checkpoints, and UI state are advisory unless mirrored or independently recoverable. | Record recovered source, stale/conflicting surfaces, chosen continuation, and next activation. |
| `skill_package` | Use Claude Code skills/plugins when available; the bare skill may invoke under a runtime-specific name. | If the expected namespaced invocation does not resolve, use the local skill path or copy-paste lead prompt. | Record selected package/reference and namespace caveat when it affects recovery. |
| `audit_hook` | Hooks may support lifecycle, permission, notification, or audit behavior after pressure evidence justifies them. | Hooks are deferred for v1 governance; do not introduce always-on audit machinery by default. | Use manual verification notes unless audit machinery is explicitly promoted. |
| L1 state | Project-local `.kybernetes/<slug>/control.md` and `verification.md`, or an explicitly targeted external workstream path. | Claude memory, transcript, task state, hooks, and checkpoints are not the source of current truth. | `control.md` is current truth; `verification.md` is evidence truth. |

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

If the active Claude Code surface can invoke skills directly, prefer that. If
the skill name or namespace does not resolve, use this lead prompt and include
the local `SKILL.md` path.

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

Flat delegation is the default. A worker may create child loops only when the
brief explicitly grants bounded delegation and the child loop has its own scope,
verifier, boundary, and return path.

## Isolation State Propagation

Before using a worktree, separate session, background agent, or sandboxed/cloud
surface, choose how the isolated worker will see the parent run state:

- Copied brief: paste the objective, DONE, constraints, verifier, owned scope,
  return format, and relevant `control.md` / `verification.md` excerpts.
- Parent run-root pointer: provide an absolute path to the parent
  `.kybernetes/<slug>/` root and state whether the worker may read or write it.
- No-parent-state mode: state that the worker must not rely on parent run files
  and must return a self-contained report.

If `.kybernetes/` is ignored or unavailable in the isolated checkout, do not
assume the child can recover the parent control record. Missing state is a
boundary failure; pause or re-brief before edits.

## Elicitation

Use Claude Code chat, AskUserQuestion, permission prompts, plan approval, tool
approval dialogs, or HITL prompts as the `elicitation` port. Ask only for
missing decisions that change the outcome. When approval arrives after a block,
treat it as changed boundary evidence and re-check the active objective,
checklist item, verifier, and risk before acting.

## Verification And Comparator Split

Claude Code review skills, review subagents, and human second passes can play
two different roles:

- `verification_sensor`: the review has authority to reject output against DONE,
  and the result is recorded in `verification.md`.
- `comparator_augmentation`: the review is advisory input for a decision, and
  the lead still needs an admissible verifier before claiming completion.

Do not launder advisory comparison into verification. If a reviewer says "looks
reasonable" without a rejection-capable method, record it as comparator advice
and run or define a verifier.

## Scheduled Or Detached Work

Treat scheduled prompts, recurring tasks, background agents, and detached
sessions as externalized loop actuators. Before creating or activating one, the
parent governor must know:

- Objective and explicit target surface.
- Cadence and next activation.
- Input source.
- Durable state surface.
- Admissible verifier.
- Budget, attempt cap, or no-change behavior.
- Safety/HITL boundary and stop/escalation condition.
- Outbound notification path or explicitly accepted manual checkpoint cadence
  when results may appear away from the parent chat.
- User approval for activation.

If any field is missing, do not create the scheduled or detached work. Offer a
one-shot dry run, manual checkpoint, or decision surface instead.

## Resume

On resume, read the control record before continuing. Refresh:

- Current checklist.
- Loop semantics and active altitude.
- Sensor/evidence and next activation.
- Verification record.
- Worker registry.
- Open impediments.
- Latest decisions.
- Next checkpoint.

If the control record is missing or stale, reconstruct the smallest safe state
before making new edits.

Runtime summaries, memory, task state, checkpoints, and transcripts are advisory
unless mirrored into the trust pair or recorded as independently recoverable
pointers.
