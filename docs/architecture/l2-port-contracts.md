# L2 Port Contracts

These contracts define the required v1 capability ports used by runtime
adapters. They are runtime-neutral: native availability, version gates, app/cloud
caveats, and selected native surfaces belong in L3 binding references.

For the full layer legend, see
[`layered-runtime-substrate.md`](layered-runtime-substrate.md).
For proportionate use guidance, see the loop-governor
[`runtime-use-rubric.md`](../../skills/kybernetes-loop-governor/references/runtime-use-rubric.md).

L0 chooses a control move. L1 preserves state and evidence. L2 names the
semantic capability an adapter must provide or safely emulate. An adapter may
return `unavailable`, but it must preserve the fallback, failure semantics, and
state update obligations below.

## Required Port Summary

| Port | Purpose | Evidence status |
| --- | --- | --- |
| `durable_objective` | Hold or simulate a persistent objective. | Advisory unless mirrored into L1. |
| `planning_surface` | Support `up` altitude before action. | Advisory unless accepted as the active plan in L1. |
| `progress_surface` | Track progress without making runtime UI canonical. | Advisory unless mirrored into L1. |
| `worker_spawn` | Start bounded child work. | Worker output is evidence, not final verification. |
| `isolation` | Prevent concurrent write collision and define state propagation. | Advisory boundary unless validated by inspection. |
| `inspect_status` | Check worker, background, schedule, or workflow status. | Evidence only for status, not for DONE. |
| `verification_sensor` | Run evidence that can reject bad output. | Admissible verification when independent of the generator claim. |
| `external_tool_provider` | Expose tools as bounded sensors or actuators. | Depends on tool output and permission boundary. |
| `elicitation` | Ask the human for steering, permission, missing input, or acceptance. | Human answer is evidence for the boundary or decision. |
| `permission_boundary` | Represent allowed, denied, asked, external effects, and information release. | Boundary evidence; not DONE evidence. |
| `lifecycle_recovery` | Resume, compact, branch, rewind, cancel, or recover state. | Advisory until re-anchored to L1. |
| `skill_package` | Load reusable workflow behavior. | Method guidance only; not verification. |

## Conditional And Deferred Ports

The required tier above is the minimum v1 adapter surface. Conditional ports are
L2 semantics only when the active task exercises that pattern; deferred ports are
named so L3 bindings can discuss them without making them always-on machinery.

| Port | Tier | Promotion rule |
| --- | --- | --- |
| `peer_workstream` | Conditional | Use when work leaves the lead loop into a human-visible peer stream with its own owner, pointer, and return contract. |
| `comparator_augmentation` | Conditional | Use when a second pass informs judgment but cannot reject DONE as an admissible verifier. |
| `scheduler` | Conditional | Use when scheduled, recurring, detached, or background activation is explicitly requested and has a stop condition plus notification or accepted manual checkpoint cadence. |
| `event_sensor` | Conditional | Use when a concrete event source is named and its admissibility, owner, and next activation can be recorded. |
| `notification` | Conditional | Use before detached work can block away from the parent surface, unless the human explicitly accepts a manual checkpoint cadence. |
| `out_of_band_steering` | Conditional | Use when a session can be steered or answered by more than one attached client (a second device pairs with or syncs to the same running loop), and pairing/attach state plus answer provenance can be recorded. |
| `trajectory_sensor` | Conditional | Use for high/extreme recurring or detached work, multi-window experiments, continuing programs, or repeated no-change that may require strategy rejection. |
| `audit_hook` | Deferred | Keep out of v1 current-truth machinery until pressure evidence justifies audit hooks. |

## `durable_objective`

| Field | Contract |
| --- | --- |
| Portable name | `durable_objective` |
| Inputs | Program kind, objective, measurable finite DONE plus completion verifier or continuing health invariant plus review horizon and cycle verifier, target surface, constraints, active control record path when durable state exists, stop condition, and owner. |
| Outputs | Objective handle or prompt, stated scope, recovery pointer, current status, and whether persistence is native, simulated, or unavailable. |
| Evidence status | Advisory control state. It can orient future work, but it does not satisfy `verification_sensor` and is not canonical unless mirrored into `control.md`. |
| Fallback | Put program kind, objective, finite DONE and verifier or continuing health/review/cycle contract, constraints, and recovery pointer in the lead prompt or `control.md`. |
| Risk / HITL consequence | Medium when it can steer future turns or autonomous work. If target, verifier, or boundary is missing, use `elicitation` before creating or returning an objective. |
| Failure semantics | Report `unavailable`, `rejected`, `ambiguous`, or `stale`. Do not proceed as if persistence exists; continue only from L1 state or ask for steering. |
| State update obligations | Record the objective text, handle or fallback prompt, recovery pointer, verifier, and any failure in `control.md`. |

## `planning_surface`

| Field | Contract |
| --- | --- |
| Portable name | `planning_surface` |
| Inputs | Objective, current state, constraints, risk boundary, uncertainty, intended altitude, candidate decomposition, and verifier. |
| Outputs | Proposed plan, assumptions, open decisions, risk notes, verification plan, and approval or rejection status when human approval is required. |
| Evidence status | Advisory until accepted by the lead loop or human. It may guide action, but it cannot prove completion. |
| Fallback | Write a compact plan in chat, `control.md`, or a project-local plan/checklist file. |
| Risk / HITL consequence | Medium to high when plan choices affect architecture, external effects, or irreversible work; route through `elicitation` when multiple defensible paths exist. |
| Failure semantics | Report `not_needed`, `unavailable`, `rejected`, or `underdetermined`. If underdetermined, go `down` for evidence or `stop` for HITL. |
| State update obligations | Record accepted plan, rejected alternatives when meaningful, open questions, and next checkpoint in `control.md` or `checklist.md`. |

## `progress_surface`

| Field | Contract |
| --- | --- |
| Portable name | `progress_surface` |
| Inputs | Active checklist or task list, current checkpoint, owner, status vocabulary, and durability tier. |
| Outputs | Updated status, completed items, blockers, next item, and whether the surface is recoverable after handoff or compaction. |
| Evidence status | Advisory. Progress indicators show motion; they do not prove DONE without `verification_sensor`. |
| Fallback | Maintain a concise checklist in `control.md` or `checklist.md`. For low-variety work, summarize progress in the final response. |
| Risk / HITL consequence | Low unless progress state can trigger detached or external work; then pair with `permission_boundary` and `elicitation`. |
| Failure semantics | Report lost, stale, conflicting, or non-recoverable state. Reconstruct from L1 before continuing. |
| State update obligations | Mirror durable status, blockers, next checkpoint, and next activation into `control.md` when the run is durable. |

## `worker_spawn`

| Field | Contract |
| --- | --- |
| Portable name | `worker_spawn` |
| Inputs | Worker objective, owned scope, sources, permission level, isolation choice, done condition, verifier for the slice, return format, impediment path, and parent integration owner. |
| Outputs | Worker handle or prompt, ownership boundary, expected report path or return channel, status, findings, changes, risks, questions, and slice verification. |
| Evidence status | Worker output is input evidence. Parent integration and final verification remain owned by the lead loop. |
| Fallback | Give the human or current lead a bounded worker prompt and perform the slice sequentially. |
| Risk / HITL consequence | Medium by default; high for write access, external effects, secrets, or production surfaces. Require explicit permission for high-risk worker actions. |
| Failure semantics | Report spawn failure, timeout, conflict, missing report, exceeded scope, or verifier failure. Do not integrate unbounded output silently. |
| State update obligations | Record worker contract, owner, scope, status, report pointer, impediments, and integration decision in `control.md` or worker files. |

## `isolation`

| Field | Contract |
| --- | --- |
| Portable name | `isolation` |
| Inputs | Concurrent write risk, owned files, branch/workspace boundary, shared state needs, run root location, secrets boundary, and merge/integration plan. |
| Outputs | Isolation mode, writer ownership map, state-propagation rule, conflict handling plan, and cleanup or merge obligation. |
| Evidence status | Boundary control state. It becomes evidence only when inspection confirms the intended separation and state propagation. |
| Fallback | Use a single-writer sequence with explicit file ownership and no concurrent writes. |
| Risk / HITL consequence | High when separate workspaces can lose `.kybernetes/` state, diverge from parent constraints, or collide at integration. Ask before risky merges or external effects. |
| Failure semantics | Report missing state, collision, divergent base, untracked artifacts, or unsafe merge. Pause integration until the parent trust pair is restored. |
| State update obligations | Record isolation mode, owned paths, state-propagation choice for `.kybernetes/` records, integration plan, and conflict outcome in `control.md`. |

## `inspect_status`

| Field | Contract |
| --- | --- |
| Portable name | `inspect_status` |
| Inputs | Handle or surface to inspect, expected owner, expected state, timeout or cadence, and relevant control-record pointer. |
| Outputs | Current status, latest result or report pointer, blocker, completion state, cancellation state, and staleness assessment. |
| Evidence status | Evidence for runtime or worker state only. It does not satisfy DONE unless paired with `verification_sensor`. |
| Fallback | Ask the worker or human for a status report, or inspect files and control records manually. |
| Risk / HITL consequence | Medium when detached work may block away from the parent; missing inspection should fail closed to foreground/manual control. |
| Failure semantics | Report inaccessible, stale, ambiguous, cancelled, failed, or no-such-handle. Do not assume success from silence. |
| State update obligations | Record inspected surface, timestamp or checkpoint, status, report pointer, blocker, and next action in `control.md`. |

## `verification_sensor`

| Field | Contract |
| --- | --- |
| Portable name | `verification_sensor` |
| Inputs | DONE condition, artifact under test, accepted evidence type, command or review method, independence requirement, expected pass/fail signal, and rerun instructions. |
| Outputs | Pass, fail, inconclusive, blocked, or not run; evidence snippet or artifact pointer; scope covered; gaps; and rerun command or method. |
| Evidence status | Admissible verification only when it can reject bad output without relying on the generator's self-claim. Advisory review is not verification unless it has rejection authority and is recorded as evidence. |
| Fallback | Use the smallest manual check that can reject bad output, record limits, or stop and ask for a verifier. |
| Risk / HITL consequence | High when verification is missing for external, irreversible, production, or customer-visible work. Stop or ask for HITL instead of claiming completion. |
| Failure semantics | Report failing, inconclusive, missing verifier, command unavailable, partial coverage, or blocked. Re-route rather than repeatedly applying the same failing move. |
| State update obligations | Record evidence, command/method, result, coverage, gaps, and acceptance decision in `verification.md`; mirror current verification status in `control.md`. |

## `external_tool_provider`

| Field | Contract |
| --- | --- |
| Portable name | `external_tool_provider` |
| Inputs | Tool purpose, requested operation, input data, allowed side effects, network or filesystem boundary, secrets policy, and expected evidence. |
| Outputs | Tool result, side effects performed, errors, permissions used, evidence pointer, and whether output is sufficient for the intended control move. |
| Evidence status | Tool output can be sensor evidence when the tool is appropriate and the result is recorded. Tool availability itself is not proof of DONE. |
| Fallback | Ask the human to run the tool, use a local non-side-effecting alternative, or proceed with a documented lower-confidence manual check. |
| Risk / HITL consequence | Medium to high depending on side effects. External writes, messages, deployments, payments, or secret exposure require explicit permission. |
| Failure semantics | Report denied permission, unavailable tool, partial result, stale output, unsafe input, or external failure. Do not retry destructive operations blindly. |
| State update obligations | Record tool, operation, side effects, result pointer, errors, and permission decision in `control.md` or `verification.md` as appropriate. |

## `elicitation`

| Field | Contract |
| --- | --- |
| Portable name | `elicitation` |
| Inputs | Missing decision, options, recommended default, consequence, urgency, and whether work can continue safely without an answer. |
| Outputs | Human answer, timeout/default if allowed, changed constraints, approval, rejection, or requested pause. |
| Evidence status | Human input is evidence for intent, acceptance, boundary, or permission. It does not replace technical verification unless human acceptance is the named verifier. |
| Fallback | Ask directly in the current conversation. If no answer is available and no safe default exists, stop. |
| Risk / HITL consequence | High for irreversible, external, private, budgeted, or production-impacting choices. Low for reversible preference choices. |
| Failure semantics | Report unanswered, ambiguous, stale, contradictory, or insufficient authority. Continue only under an explicitly safe default. |
| State update obligations | Record the question, answer or default, changed boundary, approved action, and next decision in `control.md` when durable state exists. |

## `permission_boundary`

| Field | Contract |
| --- | --- |
| Portable name | `permission_boundary` |
| Inputs | Requested action, actor, workspace or external surface, allowed tools, denied tools, approval mode, data sensitivity, and reversibility. For information release: destination, purpose, minimum necessary payload, exclusions, and inspection or sanitization method. |
| Outputs | Allowed, denied, ask, or externally approved; constraints; required approval; approved destination and payload scope when information leaves the current boundary; handling decision; and residual risk. |
| Evidence status | Boundary evidence. It authorizes or blocks action but does not prove the work is correct. Permission to invoke a tool does not authorize an unbounded information release through it. |
| Fallback | Use least-privilege local work, reduce and inspect the payload, ask the human, or choose a local or no-send fallback before crossing the boundary. |
| Risk / HITL consequence | High when action is irreversible, external, production-facing, secret-bearing, billing-related, or customer-visible. |
| Failure semantics | Report denied, unknown, ambiguous, expired, or mismatched permission, destination, payload scope, data sensitivity, or approving authority. Fail closed before release when the payload cannot be inspected or authority remains unclear; do not expand authority from a vague autonomy or tool grant. |
| State update obligations | Record permission assumption, approval, denied action, boundary change, and exact unlocked action in `control.md`. For information release, also record destination, purpose, payload scope, exclusions, handling, approval evidence, and residual risk. |

## `lifecycle_recovery`

| Field | Contract |
| --- | --- |
| Portable name | `lifecycle_recovery` |
| Inputs | Recovery trigger, canonical state, native state, capability snapshot, available state surfaces, active control record path, verification record path, current branch/workspace, open workers, open automations, divergence class, and requested recovery action. |
| Outputs | Recovered state, chosen continuation point, selected fresh binding, superseded handles, rebind decisions, residual stale surfaces, unresolved gaps, and next checkpoint. |
| Evidence status | Advisory until the recovered state is reconciled against `control.md` and `verification.md`. When intact L1 state and native state disagree, native state remains advisory; the governor must reconcile or migrate before new side effects. |
| Fallback | Read `control.md`, then `verification.md`, checklist, decisions, and worker reports; reconstruct the smallest safe state and ask when underdetermined. |
| Risk / HITL consequence | Medium to high when recovery can discard work, change branches, rewind decisions, cancel work, or resume stale plans. Ask before destructive recovery. |
| Failure semantics | Report missing trust pair, stale state, conflicting state, inaccessible surface, unsupported transition, unsafe recovery, or underdetermined continuation. Native state must not override intact L1 truth. |
| State update obligations | Record recovered source, chosen continuation, discarded or stale surfaces, open gaps, and next activation in `control.md`; update `verification.md` if evidence state changes. |

## `out_of_band_steering`

| Field | Contract |
| --- | --- |
| Portable name | `out_of_band_steering` |
| Inputs | Active session/loop handle, candidate device/client identity, pairing or attach method, and (if the runtime exposes one) a precedence rule for concurrent answers from different attached clients. |
| Outputs | Attached-client list or count, steering action or answer received, which client supplied a given answer, and whether that answer arrived while the loop was already acting on other input. |
| Evidence status | Same as `elicitation`: a remote answer is evidence for intent, permission, or acceptance — it does not replace `verification_sensor`. An answer supplied from a notification or lock-screen surface is weaker evidence of informed consent than an answer supplied from a client that had the current diff/state in view. Do not treat all attached-client answers as equally informed. |
| Fallback | Treat the session as single-client. Do not assume a second device is attached or watching unless the active binding confirms pairing/attachment. |
| Risk / HITL consequence | Higher than plain `elicitation` for approval-style prompts specifically, because the answering device may lack full context. For irreversible, external, or production-impacting actions, prefer requiring the answer come from the client with the most current state visible, or escalate for confirmation rather than accepting the first answer from any attached device. |
| Failure semantics | Report `no_client_attached`, `ambiguous_answer` (two clients answered the same prompt differently), `stale_context` (the answering client's state is known to lag the loop's current state), or `unavailable`. Do not silently pick one of two conflicting answers without recording the conflict. |
| State update obligations | Record which device/client answered, the device's context freshness if knowable, and any detected race or conflict in `control.md`. Treat this as a `permission_boundary`-adjacent record, not just an `elicitation` log entry, since the answering device's context strength affects how much the resulting approval should be trusted. |

## `skill_package`

| Field | Contract |
| --- | --- |
| Portable name | `skill_package` |
| Inputs | Requested method, package or reference name, local path if known, runtime compatibility, and target task boundary. |
| Outputs | Loaded instructions or fallback prompt, namespace resolution status, relevant references, and any packaging caveat. |
| Evidence status | Method guidance only. A skill package cannot verify its own result without `verification_sensor`. |
| Fallback | Use a prompt template plus markdown references, or proceed with the portable core behavior. |
| Risk / HITL consequence | Low for read-only guidance; medium when package behavior can trigger tools, workers, or external effects through the active runtime. |
| Failure semantics | Report missing package, namespace mismatch, incompatible runtime, stale reference, or unreadable instructions. Do not invent package behavior. |
| State update obligations | Record selected method package, references used, fallback, and any namespace caveat in `control.md` when it affects recovery. |

## `trajectory_sensor`

| Field | Contract |
| --- | --- |
| Portable name | `trajectory_sensor` |
| Inputs | `strategy_id`, program kind, finite DONE verifier or continuing review horizon and cycle verifier, progress model and metric, measurement window, minimum delta, actual admissible result, cumulative deficient windows for that strategy, no-progress cap, actionable capacity through approved sensors and actuators, fallback coverage, remaining horizon, strategy envelope, and evidence pointers. |
| Outputs | Continue, adapt, pause, escalate, or retire; health `healthy`, `watch`, `unhealthy`, or `unknown`; reason; next measurement; and affected strategy or activation handles. |
| Evidence status | Strategy-control evidence only. It cannot declare completion, weaken DONE, or manufacture a domain verdict. |
| Fallback | Evaluate the compact contract in the lead loop and record the current summary in `control.md`. Use a conditional `trajectory.md` only for high/extreme recurring or detached history when several windows must survive reconstruction; otherwise current summaries stay in `control.md`. |
| Risk / HITL consequence | High when adaptation would change objective, evidence admissibility, audience, destination, channel, claims, spend, data access, permissions, or external risk. Use `elicitation` outside the strategy envelope. |
| Failure semantics | Report `unknown` only for missing or stale sensing; report `unhealthy`, `insufficient_capacity`, `cap_reached`, `boundary_limited`, or `strategy_rejected` when complete admissible sensing supports the result. Runtime success and safety consistency do not imply health. |
| State update obligations | The single canonical writer records `strategy_id`, model, window, planned and actual result, cumulative deficient-window count, capacity, decision, and next measurement in `control.md`. Preserve the count for the same strategy across activations and reconstruction; reset only for a materially different causal strategy with a new ID, retaining prior history. Completion verification remains separate in `verification.md`. |

The trajectory program supplies the canonical fields `strategy_id`,
`progress_model`, `minimum_delta`, `no_progress_cap`, `actionable_capacity`,
`review_horizon`, and `cycle_verifier`.

## Contract Evolution

Ports may merge, split, or be sunset when the change preserves L0 semantics, L1
trust-pair obligations, fallback behavior, evidence status, HITL consequences,
failure semantics, and state update obligations. Conditional ports get contracts
when their execution pattern is exercised. Deferred ports stay out of the
required tier until pressure evidence promotes them.
