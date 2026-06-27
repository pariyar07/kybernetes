# Skill Boundaries

Kybernetes should avoid one giant skill that tries to do everything.

## Current Seed

`kybernetes:loop-governor` is the primary installable skill. It carries the core Kybernetes loop: loop readiness, loop altitude, adaptive intake, execution profile, durable control record, runtime binding, worker coordination, HITL, impediments, decisions, verification, and learning capture.

`parallel-coordinator` is a legacy/v0 name for the seed behavior. It names one actuation mode, not the product's primary surface.

## Planned Skills

| Skill | Boundary |
| --- | --- |
| `kybernetes:loop-governor` | Current primary loop controller: readiness, altitude, durable state, verification, HITL, runtime binding, worker coordination, and learning capture. |
| `kybernetes:parallel-coordinator` | Possible future specialist for worker leases, fork-join, integration, anti-collision rules, and bounded child loops if parallel behavior outgrows the main loop governor. |
| `kybernetes:runtime-codex` | Codex Goal mode, subagents, side chats, and Codex-specific caveats. |
| `kybernetes:runtime-claude-code` | Claude Code task, resume, and worktree binding. |
| `kybernetes:portable-core` | Fallback launcher and minimal primitives for unknown runtimes. |

## Rule

Do not add a new `SKILL.md` until pressure scenarios show the failure the skill needs to fix.

Do not create placeholder folders under `skills/`. Planned skills live in architecture docs until they become installable.
