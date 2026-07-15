# Codex Binding

Use this file when the loop governor is running in Codex.

## Binding Table

| L2 port or layer | Codex binding | Caveat / fallback | Evidence and state obligation |
| --- | --- | --- | --- |
| `durable_objective` | Prefer `/goal` when work is long-running, resumable, or needs a durable stopping condition and the objective is ready enough to name. Pausing, resuming, editing, or clearing an active goal is done through buttons in the app's progress row, not separate slash commands. | If the agent cannot set the goal, return a copy-paste `/goal` prompt or continue from `control.md`. Goal state is advisory. | Mirror objective, DONE, verifier, constraints, and recovery pointer into `control.md`. |
| `planning_surface` | Use `/plan` when the correct move is `up`: architecture, scope, decomposition, or product judgment before action. | If plan mode is unavailable or unnecessary, write a compact plan in chat or `control.md`. | Accepted plan, assumptions, rejected alternatives, and next checkpoint belong in L1 state when durable. |
| `progress_surface` | Use in-session plan/checklist state, goal progress, or app thread state when helpful. | Runtime progress UI is advisory unless recoverable and linked from L1. | Mirror durable progress into `checklist.md` or `control.md` only when needed. |
| `worker_spawn` | Use Codex subagents for bounded in-session delegation. Worker prompts receive task contracts, not slash commands. | Codex does not need to spawn workers by reflex; use single-writer work when integration cost is higher than coverage gain. | Worker reports are evidence inputs; parent loop owns integration and final verification. |
| `peer_workstream` | Use parallel chats, sibling threads, cloud tasks, or Handoff only for human-visible peer workstreams with their own owner and return path. | Treat app/cloud/thread availability as surface-specific. If unavailable, use a manual sibling note/thread or stay in the parent loop. | Record owner, scope, durable pointer, return contract, and integration decision in `control.md`. |
| `isolation` | Use Codex app worktrees, cloud containers, sandbox policy, or manual `git worktree` for concurrent writers. | Worktrees and cloud tasks may not carry ignored `.kybernetes/` state automatically. | Before spawning isolated work, pass either a copied brief, an absolute parent run-root pointer, or a rule that the worker must not depend on reading parent L1 files directly. Record the state-propagation choice. |
| `inspect_status` | Inspect, steer, or close workers through thread/task status, automation panes, command output, or app/server state when available. Worker inspection has moved from a dedicated slash command toward app UI (task list, thread status) on current surfaces; verify what the installed surface actually exposes rather than assuming a fixed command name. | Silence is not success. If inspection is unavailable, ask for a report or return to foreground/manual control. | Record inspected surface, status, report pointer, blocker, and next action in `control.md`. |
| `verification_sensor` | Use tests, commands, `/review`, reviewer subagents, GitHub review, citations, screenshots, or human acceptance as proportionate sensors when they can reject bad output. | No single Codex feature is the universal verifier. Advisory review is not verification unless it has rejection authority and is recorded as evidence. | Record command/method, result, coverage, gaps, and acceptance decision in `verification.md`. |
| `comparator_augmentation` | Use reviewer/subagent/human second-pass input as an advisory comparison at decision points. | There is no assumed universal Codex advisor primitive. Comparator input cannot replace `verification_sensor`. | Record comparator advice in `control.md` decisions, not as DONE evidence unless separately promoted to verification. |
| `scheduler` | Use Codex app/cloud automations only for stable recurring loops after the user approves activation. | Do not assume a bare CLI scheduler. Use external cron/launchd, a human-created reminder, or manual checkpoint fallback when native scheduling is unavailable. | Record cadence, input source, state surface, verifier, budget/attempt cap, stop condition, and approval. |
| `event_sensor` | Use app/plugin/GitHub/cloud signals or automation polling only when a concrete event source is named. | Kybernetes has no generic v1 event bus. If event delivery is not reliable, use manual polling or a scheduled/manual check. | Record event source, admissibility, owner, and next activation in `control.md`. |
| `notification` | Use app notifications, automation inbox/triage, thread updates, or another configured outbound path for detached work. | Detached/cloud/automation surfaces must fail closed without outbound notification or an explicitly accepted manual checkpoint cadence. | Record notification path or accepted manual cadence before detached work can block away from the parent chat. |
| `external_tool_provider` | Use MCP, browser, docs, GitHub, web, filesystem, shell, plugins, or app tools as bounded sensors/actuators. MCP interactive authentication no longer requires an experimental opt-in; remote plugins are enabled by default with richer catalog rows and npm marketplace sources. | Tool availability and side effects are governed by the active sandbox and approval policy. | Record side effects, permission decision, result pointer, and whether output is sensor evidence. |
| `elicitation` | Use chat questions, permission prompts, plan approval, tool approval prompts, or app prompts. | If the answer changes objective, boundary, or approval, re-sense before acting. | Record exact question, answer/default, approved action, and changed boundary when durable. |
| `permission_boundary` | Respect approval policy, sandbox mode, `/permissions`, MCP/app side-effect approvals, workspace roots, and network policy. App tool approvals support a `writes` mode (`[apps._default].default_tools_approval_mode`) where tools declared read-only run without approval while writes still prompt; this governs app tools, not the general approval policy. | Autonomy grants do not imply permission for irreversible, external, secret-bearing, customer-visible, production, billing, publishing, or destructive actions. | Record allowed/denied/ask status and exact unlocked action in `control.md`. |
| `lifecycle_recovery` | On resume, `/compact`, `/fork`, Handoff, archive/delete, or app/server resume, re-anchor on `control.md`, then `verification.md`, checklist, and worker reports. Some of these actions live in app UI (task list, keyboard shortcuts, deep links) rather than a slash command on current surfaces; do not assume a fixed command name without checking the installed surface. | Runtime memory, transcripts, checkpoints, and app state are advisory unless mirrored or independently recoverable. | Record recovered source, stale/conflicting surfaces, chosen continuation, and next activation. |
| `skill_package` | Codex Agent Skills are the workflow package; plugins are optional distribution for reusable install shape. | If `$kybernetes:loop-governor` does not resolve in the active surface, use the local skill path or copy-paste launcher. | Record selected package/reference and namespace caveat when it affects recovery. |
| `audit_hook` | Hooks may support lifecycle or audit behavior after pressure evidence justifies them. | Hooks are deferred for v1 governance; do not introduce always-on audit machinery by default. | Use manual verification notes unless audit machinery is explicitly promoted. |
| L1 state | Project-local `.kybernetes/<slug>/control.md` and `verification.md`, or an explicitly targeted external workstream path. | Codex goal state, memory, progress UI, transcripts, and hooks are not the source of current truth. | `control.md` is current truth; `verification.md` is evidence truth. |

## Goal Behavior

The goal belongs to the loop governor thread. Workers must not receive `/goal`
commands.

Before creating or returning a goal prompt, confirm the goal can name the target,
objective, done condition, verifier, constraints, and active control record. A
prompt like "set a goal for this" is not enough when "this" lacks a recoverable
target or verifier. Go `down` to repair readiness before setting a durable goal.

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

1. Repair readiness first if target, objective, DONE, verifier, constraints, or
   control record are still vague.
2. Continue in the current chat with the same control record.
3. Return the copy-paste `/goal` prompt to the user.
4. State that the run can continue without goal mode as long as the control
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
subagents, peer workstreams, detached cloud work, worktrees, or a single-writer
loop. Record the choice in the control record. A valid decision can be "no
subagents yet", but it must include the reason and the condition that would
trigger fan-out.

Codex warns when Ultra reasoning effort is selected while multi-agent
concurrency is configured high. The warning does not block or change settings;
treat it as a signal to lower concurrency or reasoning effort, not as
permission to ignore configured concurrency limits.

In delegated Codex runs, read the delegation payload as context, not as a
complete execution contract. A `source_thread_id`, prior-thread handoff, or
instruction to "move fast" does not by itself identify the target workflow,
done condition, verifier, or safety boundary. If those are missing, do not spawn
workers or create sibling threads yet. First return or record the smallest decision
surface that would make the worker contract measurable.

Use a single-writer discovery loop when the likely target files are not yet
partitioned. Spawn workers only after the lead can give each worker owned paths
or sources, permission level, done condition, verifier, and return format.

## Isolation State Propagation

Before using a Codex worktree, cloud task, or other isolated surface, choose how
the isolated worker will see the parent run state:

- Copied brief: paste the objective, DONE, constraints, verifier, owned scope,
  return format, and relevant `control.md` / `verification.md` excerpts.
- Parent run-root pointer: provide an absolute path to the parent
  `.kybernetes/<slug>/` root and state whether the worker may read or write it.
- No-parent-state mode: state that the worker must not rely on parent run files
  and must return a self-contained report.

If `.kybernetes/` is ignored or unavailable in the isolated checkout, do not
assume the child can recover the parent control record. Missing state is a
boundary failure; pause or re-brief before edits.

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

## Elicitation

Use Codex chat, permission prompts, plan approval, app prompts, and tool approval
dialogs as the `elicitation` port. Ask only for missing decisions that change the
outcome. When approval arrives after a block, treat it as changed boundary
evidence and re-check the active objective, checklist item, verifier, and risk
before acting.

## Verification And Comparator Split

Codex review surfaces, reviewer subagents, and human second passes can play two
different roles:

- `verification_sensor`: the review has authority to reject output against DONE,
  and the result is recorded in `verification.md`.
- `comparator_augmentation`: the review is advisory input for a decision, and
  the lead still needs an admissible verifier before claiming completion.

Do not launder advisory comparison into verification. If a reviewer says "looks
reasonable" without a rejection-capable method, record it as comparator advice
and run or define a verifier.

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
- Outbound notification path or explicitly accepted manual checkpoint cadence
  when results may appear away from the parent chat.
- User approval for activation.

If any field is missing, do not create the automation. Offer a one-shot dry run,
manual checkpoint, or decision surface instead. Paused or draft automation
configuration is still a created runtime object; only produce it after the user
has accepted that artifact as the next actuation step.

## Approval Changes

When a user approves a previously blocked or HITL-gated action, treat that
approval as changed runtime evidence. It updates the boundary; it does not prove
that the old plan, checklist position, target surface, verifier, or risk posture
is still valid.

Before acting on approval:

- Re-read or request the active control record.
- Name the exact action now approved.
- Re-check objective, current checklist item, verifier, and safety boundary.
- Record the approval and resulting decision when durable state exists.

If the approval is vague, stale, broader than the requested action, or the active
state is unclear, choose `stop` and return a compact decision surface.

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
