# Skill Boundaries

Kybernetes should avoid one giant skill that tries to do everything.

## Current Seed

`parallel-coordinator` is the v0 seed skill. It coordinates parallel or multi-part work and carries the initial cybernetic operating model.

## Planned Skills

| Skill | Boundary |
| --- | --- |
| `adaptive-coordinator` | Main coordinator behavior for long-running or ambiguous tasks. |
| `parallel-coordinator` | Parallel execution, worker leases, fork-join, integration, and anti-collision rules. |
| `runtime-codex` | Codex Goal mode, subagents, and Codex-specific caveats. |
| `runtime-claude-code` | Claude Code task, resume, and worktree binding. |
| `portable-core` | Fallback launcher and minimal primitives for unknown runtimes. |

## Rule

Do not add a new `SKILL.md` until pressure scenarios show the failure the skill needs to fix.
