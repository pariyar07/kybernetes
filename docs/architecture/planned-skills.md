# Planned Skills

Only real installable skills belong under `skills/`. Planned skills stay in this document until pressure scenarios justify creating a `SKILL.md`.

## Planned Skill Boundaries

| Skill | Intended scope | Creation gate |
| --- | --- | --- |
| `kybernetes:parallel-coordinator` | Specialist for bounded child loops, worker leases, fork-join, integration, and anti-collision rules if parallel execution outgrows the primary loop governor. | Create after pressure scenarios show the main loop governor should split parallel execution into a separate skill. |
| `kybernetes:runtime-codex` | Codex Goal mode, `/goal` fallback prompts, subagents, side chats, feature detection, and Codex-specific caveats. | Create after Codex-specific pressure scenarios are tested. |
| `kybernetes:runtime-claude-code` | Claude Code lead prompt, Task tool/subagents, resume behavior, worktree isolation, hooks, and Claude-specific gates. | Create after Claude Code behavior is verified. |
| `kybernetes:portable-core` | Prompt-only fallback for unknown or lower-capability runtimes. Covers durable control record fallback, no-subagent execution, generic verification, and HITL prompts. | Create after a runtime gap proves the fallback needs separate skill behavior. |
| `kybernetes:verify-run` | Independent verification, evidence review, sensor checks, and completion validation. | Create after verifier-specific pressure scenarios show this should be separated from loop-governor behavior. |
| `kybernetes:capture-learning` | Learning capture gate, reusable rule promotion, and skill-update safety. | Create after learning-capture scenarios show the main loop governor is too broad. |

## Why Not Placeholder Folders?

Placeholder folders under `skills/` make the repo look installable before behavior exists. Kybernetes treats skills as tested process artifacts, so a skill folder should mean there is a real `SKILL.md` and a behavior contract.

## Current Installable Skills

- [`skills/kybernetes-loop-governor`](../../skills/kybernetes-loop-governor/README.md), installed as `kybernetes:loop-governor`
