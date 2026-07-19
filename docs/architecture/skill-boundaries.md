# Skill Boundaries

Kybernetes should avoid one giant skill that tries to do everything.

## Current Installable Surface

`kybernetes:loop-governor` is the sole canonical lifecycle controller. Four
pressure-backed helpers may inspect state and return owned outputs, but they
cannot mutate parent canonical state or accept completion:

| Skill | Current boundary |
| --- | --- |
| `kybernetes:loop-governor` | Canonical readiness, altitude, state, lifecycle, runtime binding, coordination, integration, and completion authority. |
| `kybernetes:loop-architect` | Advisory execution-contract and task-derived lens design. |
| `kybernetes:loop-closeout` | Checkpoint, handoff, workstream, and program retirement proposals. |
| `kybernetes:verify-run` | Independent rejection-capable verification evidence. |
| `kybernetes:capture-learning` | Evidence-gated, owner-reviewed constraint proposals. |

The retired v0 name `parallel-coordinator` is not an installed alias. It names
one actuation mode, not the product's primary surface. This historical bare name
is distinct from the possible future `kybernetes:parallel-coordinator`
specialist below.

## Planned Or Conditional Skills

| Skill | Boundary |
| --- | --- |
| `kybernetes:parallel-coordinator` | Possible future specialist for worker leases, fork-join, integration, anti-collision rules, and bounded child loops if parallel behavior outgrows the main loop governor. |
| `kybernetes:runtime-codex` | Codex Goal mode, subagents, sibling threads, cloud tasks, and Codex-specific caveats. |
| `kybernetes:runtime-claude-code` | Claude Code task, resume, and worktree binding. |
| `kybernetes:portable-core` | Fallback launcher and minimal primitives for unknown runtimes. |

## Rule

Do not add a new `SKILL.md` until pressure scenarios show the failure the skill needs to fix.

Do not create placeholder folders under `skills/`. Planned skills live in architecture docs until they become installable.

For v1, partial adoption remains horizontal at the governor boundary: a user may
use only readiness plus verification and decline durable files, workers,
runtime adapters, audit, or learning capture. Installing a helper does not make
it a second governor.
