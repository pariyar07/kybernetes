# Portable Runtime Matrix

This matrix keeps runtime bindings aligned to L2 ports. The L2 contract is the
normative semantic layer; runtime cells are adapter guidance and must be probed
in the active environment before relying on a native surface.

See:

- [`l2-port-contracts.md`](l2-port-contracts.md)
- [`runtime-adapter-model.md`](runtime-adapter-model.md)
- `skills/kybernetes-loop-governor/references/codex.md`
- `skills/kybernetes-loop-governor/references/claude-code.md`
- `skills/kybernetes-loop-governor/references/portable-core.md`

| L2 port | Codex binding | Claude Code binding | Portable fallback | Evidence / state obligation |
| --- | --- | --- | --- | --- |
| `durable_objective` | Goal surface when available; advisory. | Lead prompt plus control record; no universal persistent command assumed. | Objective, DONE, verifier, and constraints in prompt or `control.md`. | Mirror recovery pointer and objective state into `control.md`. |
| `planning_surface` | Plan surface for `up` altitude. | Planning prompt or native planning mode when available. | Compact plan in chat or `control.md`. | Accepted plan and next checkpoint go to L1 when durable. |
| `progress_surface` | In-session plan/checklist, goal progress, or app state. | Todo/session notes or control-record checklist. | `checklist.md` or concise `control.md` checklist. | Runtime progress is advisory unless mirrored. |
| `worker_spawn` | Subagents with bounded task contracts. | Task tool or configured subagents with bounded contracts. | Manual worker prompt or sequential lead work. | Worker output is evidence input; parent owns final verification. |
| `peer_workstream` | Parallel chats, sibling threads, cloud tasks, or Handoff when available. | Separate chats/sessions when explicitly scoped. | Human-created parallel note/thread. | Record owner, scope, pointer, return path, and integration plan. |
| `out_of_band_steering` | Mobile app pairs with a connected host and can steer or approve work on that host. | Remote Control syncs a session symmetrically across devices when available. | Treat the session as single-client; do not assume a second device is attached. | Record which device answered, its context freshness if knowable, and any race/conflict between attached clients. |
| `isolation` | App worktrees, cloud containers, sandbox policy, or manual worktrees. | Git worktrees, branch/session boundaries. | Single-writer sequence with file ownership. | Record state propagation for `.kybernetes/` and conflict plan. |
| `inspect_status` | Agent/thread status, automation panes, command output, or app/server state. | Agent/session status or command output. | Ask for report or inspect artifacts manually. | Status is not DONE evidence without `verification_sensor`. |
| `verification_sensor` | Tests, commands, review, reviewer subagents, screenshots, citations, human acceptance. | Tests, commands, review subagents, human acceptance. | Smallest manual check that can reject bad output. | Record result, coverage, gaps, and rerun method in `verification.md`. |
| `comparator_augmentation` | Reviewer, subagent, or human second pass as advisory comparison. | Advisor/reviewer-style second pass as advisory comparison. | Human or independent reviewer advice. | Advisory only unless separately promoted to `verification_sensor`. |
| `scheduler` | App/cloud automations when approved and available. | Scheduled tasks/routines only when the active runtime supports them. | External cron/calendar or manual checkpoint. | Requires cadence, verifier, stop condition, and activation approval. |
| `event_sensor` | App/plugin/GitHub/cloud signals or polling when a source is named. | Channels, monitors, or plugin signals when available. | Manual polling or user-provided event. | Record source, owner, admissibility, and next activation. |
| `notification` | App notification, automation inbox, thread update, or configured outbound path. | Desktop/channel/session notification where configured. | Blocking chat message or human-created reminder. | Detached work fails closed without notification or accepted manual cadence. |
| `external_tool_provider` | MCP, browser, docs, GitHub, web, filesystem, shell, plugins, apps. | MCP, shell, browser, GitHub, plugin tools. | Human runs tool or supplies output. | Record side effects, permission, result pointer, and evidence status. |
| `elicitation` | Chat, permission prompts, plan approval, app/tool approval prompts. | Chat, permission prompts, plan approval, HITL prompts. | Ask in current conversation and wait, or stop. | Record answer/default and exact approved action when durable. |
| `permission_boundary` | Approval policy, sandbox mode, permissions, network/app/MCP approvals. | Permission mode, allowed tools, directory access, safe mode. | Written assumptions plus explicit human approval. | Permission authorizes action; it does not verify correctness. |
| `lifecycle_recovery` | Resume, compact, fork, Handoff, app/server resume. | Resume, checkpoints, branch/session recovery. | Read trust pair and reconstruct smallest safe state. | Re-anchor on `control.md` and `verification.md` before continuing. |
| `skill_package` | Agent Skills; plugins as optional distribution wrapper. | Skill/plugin packaging where available. | Prompt template plus markdown references. | Method guidance only; not verification. |
| `audit_hook` | Hooks only after pressure evidence justifies audit machinery. | Hooks/logs/plugins only after pressure evidence. | Manual verification notes. | Deferred; no current-truth role. |

## Matrix Rules

- Core asks for a port; the adapter chooses the native surface.
- Runtime availability is probed before use and never assumed from this matrix.
- Runtime memory, task state, goals, checkpoints, and transcripts are advisory
  unless mirrored into the L1 trust pair or independently recoverable through a
  recorded pointer.
- Comparator augmentation is never a substitute for an admissible verifier.
- Detached, scheduled, recurring, or background work requires an outbound
  notification path or explicitly accepted manual checkpoint cadence.
