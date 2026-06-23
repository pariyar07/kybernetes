# Skill Boundaries

Kybernetes should avoid one giant skill that tries to do everything.

## Current Seed

`parallel-coordinator` is the v0 seed skill. It currently carries the core Kybernetes loop: adaptive intake, execution profile, durable control record, runtime binding, worker coordination, HITL, impediments, decisions, and learnings.

## Planned Skills

| Skill | Boundary |
| --- | --- |
| `adaptive-coordinator` | Possible future home for general coordination once pressure scenarios prove it should split from the seed skill. |
| `parallel-coordinator` | Current seed and future parallel execution boundary: worker leases, fork-join, integration, anti-collision rules. |
| `runtime-codex` | Codex Goal mode, subagents, and Codex-specific caveats. |
| `runtime-claude-code` | Claude Code task, resume, and worktree binding. |
| `portable-core` | Fallback launcher and minimal primitives for unknown runtimes. |

## Rule

Do not add a new `SKILL.md` until pressure scenarios show the failure the skill needs to fix.

Do not create placeholder folders under `skills/`. Planned skills live in architecture docs until they become installable.
