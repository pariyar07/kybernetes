# Portable Runtime Matrix

This matrix keeps runtime bindings aligned to L2 ports. The L2 contract is the
normative semantic layer; runtime cells are adapter guidance and must be probed
in the active environment before relying on a native surface. This file is a
condensed index — the full binding reference for each runtime is the source
of truth; sync this file when those references change materially.

See:

- [`l2-port-contracts.md`](l2-port-contracts.md)
- [`runtime-adapter-model.md`](runtime-adapter-model.md)
- `skills/kybernetes-loop-governor/references/codex.md`
- `skills/kybernetes-loop-governor/references/claude-code.md`
- `skills/kybernetes-loop-governor/references/portable-core.md`

| L2 port | Codex binding | Claude Code binding | Portable fallback | Evidence / state obligation |
| --- | --- | --- | --- | --- |
| `durable_objective` | Documented CLI `/goal` includes richer user subcommands. Active agent tool probe on 2026-07-17 exposed only read, create, and terminal complete/blocked update; no edit, pause, resume, clear, delete, or unblock. Advisory. | Lead prompt plus control record; model-callable goal management must be probed rather than inferred from user commands. | Objective, DONE, verifier, and constraints in prompt or `control.md`. | Mirror recovery pointer and objective state into `control.md`; never map recoverable waits to terminal blocked. |
| `planning_surface` | Plan surface for `up` altitude. | Planning prompt or native planning mode when available; a cloud-hosted variant (research preview) runs the pass in a separate session with browser review. | Compact plan in chat or `control.md`. | Accepted plan and next checkpoint go to L1 when durable. |
| `progress_surface` | In-session plan/checklist, goal progress, or app state. | Todo/session notes or control-record checklist. | `checklist.md` or concise `control.md` checklist. | Runtime progress is advisory unless mirrored. |
| `worker_spawn` | Subagents with bounded task contracts. | Task tool or configured subagents with bounded contracts. | Manual worker prompt or sequential lead work. | Worker output is evidence input; parent owns final verification. |
| `peer_workstream` | Parallel chats, sibling threads, cloud tasks, or Handoff when available. | Separate chats/sessions when explicitly scoped. | Human-created parallel note/thread. | Record owner, scope, pointer, return path, and integration plan. |
| `out_of_band_steering` | Codex Remote (GA): mobile app pairs with a connected host and can steer or approve work on that host — a distinct host-pairing model from Handoff. | Remote Control (research preview) syncs a session symmetrically across devices; available on Pro/Max/Team/Enterprise, not gated to Team/Enterprise as a whole. | Treat the session as single-client; do not assume a second device is attached. | Record which device answered, its context freshness if knowable, and any race/conflict between attached clients. |
| `isolation` | Worktrees confirmed as a desktop-app feature specifically, not CLI or IDE extension; cloud containers, sandbox policy, or manual worktrees elsewhere. | Git worktrees, branch/session boundaries; entering a worktree outside `.claude/worktrees/` prompts for confirmation. | Single-writer sequence with file ownership. | Record state propagation for `.kybernetes/` and conflict plan. |
| `inspect_status` | `/agent` (alias `/subagents`) and `/status` confirmed live CLI slash commands; automation panes or app/server state elsewhere. | Agent/session status or command output. | Ask for report or inspect artifacts manually. | Status is not DONE evidence without `verification_sensor`. |
| `verification_sensor` | Tests, commands, review, reviewer subagents, screenshots, citations, human acceptance. The security-scanning subsystem is NOT admissible here — no scan-level verdict exit code; it is `comparator_augmentation`. | Tests, commands, review subagents, human acceptance. A deep multi-agent cloud review feature is NOT admissible here — its CLI returns exit 0 regardless of findings; it is `comparator_augmentation`. | Smallest manual check that can reject bad output. | Record result, coverage, gaps, and rerun method in `verification.md`. |
| `comparator_augmentation` | Reviewer, subagent, or human second pass. The security-scanning subsystem and auto-review/`approvals_reviewer` (risk-elevated per Codex's own docs) belong here. | Advisor/reviewer-style second pass. The deep multi-agent cloud review feature belongs here — a high-confidence finding generator, not a verdict. | Human or independent reviewer advice. | Advisory only unless separately promoted to `verification_sensor`. |
| `scheduler` | App/cloud automations when approved and available. | Scheduled tasks/routines only when the active runtime supports them. | External cron/calendar or manual checkpoint. | Requires cadence, verifier, stop condition, and activation approval. |
| `event_sensor` | App/plugin/GitHub/cloud signals or polling when a source is named. | Channels, monitors, or plugin signals when available. | Manual polling or user-provided event. | Record source, owner, admissibility, and next activation. |
| `notification` | App notification, automation inbox, thread update, or configured outbound path. | Desktop/channel/session notification where configured. | Blocking chat message or human-created reminder. | Detached work fails closed without notification or accepted manual cadence. |
| `external_tool_provider` | MCP, browser, docs, GitHub, web, filesystem, shell, plugins, apps. Browser/Computer-use/Chrome extension are a higher-risk actuator tier (region-gated). Codex SDK/App Server/GitHub Action are embedding surfaces distinct from `codex mcp-server`. Slack/Linear are named integrations. | MCP, shell, browser, GitHub, plugin tools. MCP `roots/list` includes additional working directories. | Human runs tool or supplies output. | Record side effects, permission, result pointer, and evidence status. |
| `elicitation` | Chat, permission prompts, plan approval, app/tool approval prompts. Appshots (macOS hotkey) and Chronicle (opt-in passive screen-context) are privacy-caveated alternative input paths, not default sources. | Chat, permission prompts, plan approval, HITL prompts, voice dictation (provider-gated). Two-way Channels can relay an approval prompt to a remote device — first answer wins over the local dialog. | Ask in current conversation and wait, or stop. | Record answer/default and exact approved action when durable. |
| `permission_boundary` | Approval policy, sandbox mode, permissions, network/app/MCP approvals. A Rules mechanism allows/prompts/forbids specific command prefixes. Windows-native sandbox vs. WSL2 sandbox differ by shell. | Permission mode, allowed tools, directory access, safe mode. `auto-mode defaults/config/critique` subcommands self-audit the classifier. Fast mode is provider-gated. | Written assumptions plus explicit human approval; reduce to a local or no-send path when release scope is unclear. | Tool permission does not authorize unbounded information release. Record the approved action and, for release, destination, purpose, payload scope, exclusions, handling, approval evidence, and residual risk. |
| `lifecycle_recovery` | Negotiate the active callable repair transitions; use CLI, app, thread, or fresh-task surfaces only when confirmed. | Negotiate model-callable versus user/session recovery; use a fresh session when repair is unavailable. | Read the trust pair and create a fresh portable binding. | Re-anchor on canonical state, migrate when repair is unavailable, rebind required automation, and supersede stale handles. |
| `skill_package` | Agent Skills; plugins as optional distribution wrapper. Record & Replay (macOS) turns a demonstrated workflow into a reusable skill. Plugin install is a `permission_boundary` capability grant, not a bare skill load. | Skill/plugin packaging where available; same plugin-as-capability-grant caveat. | Prompt template plus markdown references. | Method guidance only; not verification. |
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
