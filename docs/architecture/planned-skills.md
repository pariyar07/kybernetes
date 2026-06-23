# Planned Skills

Only real installable skills belong under `skills/`. Planned skills stay in this document until pressure scenarios justify creating a `SKILL.md`.

## Planned Skill Boundaries

| Skill | Intended scope | Creation gate |
| --- | --- | --- |
| `adaptive-coordinator` | Main coordinator behavior for long-running, ambiguous, or high-risk work. Includes adaptive intake, execution profile, durable control record selection, runtime binding selection, HITL, impediments, decisions, and learnings. | Create after pressure scenarios show the current seed fails outside explicitly parallel work. |
| `runtime-codex` | Codex Goal mode, `/goal` fallback prompts, subagents, side chats, feature detection, and Codex-specific caveats. | Create after Codex-specific pressure scenarios are tested. |
| `runtime-claude-code` | Claude Code lead prompt, Task tool/subagents, resume behavior, worktree isolation, hooks, and Claude-specific gates. | Create after Claude Code behavior is verified. |
| `portable-core` | Prompt-only fallback for unknown or lower-capability runtimes. Covers durable control record fallback, no-subagent execution, generic verification, and HITL prompts. | Create after a runtime gap proves the fallback needs separate skill behavior. |

## Why Not Placeholder Folders?

Placeholder folders under `skills/` make the repo look installable before behavior exists. Kybernetes treats skills as tested process artifacts, so a skill folder should mean there is a real `SKILL.md` and a behavior contract.

## Current Installable Skills

- [`skills/parallel-coordinator`](../../skills/parallel-coordinator/README.md)
