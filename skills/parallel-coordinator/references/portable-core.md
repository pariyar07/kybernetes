# Portable Core — bind the checklist to any agent

The operating checklist (`goal-checklist.md`) is tool-agnostic except for a few
`{PLACEHOLDERS}`. Bind a tool by filling these blanks. Codex and Claude Code are
pre-filled in their own reference files; for any other agent (opencode, etc.),
copy the table and fill the right column.

## Binding key

| Placeholder | What it means | Codex | Claude Code | Any other tool — fill in |
|---|---|---|---|---|
| `{SET_GOAL}` | How the durable objective is set | `/goal <objective>` (point it at this checklist file; 4,000-char cap) | Lead prompt; shape with plan mode; reference the checklist via `@` (no goal object) | `__________` |
| `{SPAWN}` | How the lead spawns an in-session worker | Ask explicitly to "spawn subagents"; roles: explorer (read-only), worker (read-write) | Task tool / subagents in `.claude/agents/` | `__________` |
| `{ISOLATE}` | Isolation for concurrent writers | git worktree | git worktree (`--worktree` / `isolation: worktree`) | `__________` |
| `{CONCURRENCY}` | Sensible concurrent cap | `[agents] max_threads` (default 6); `max_depth` 1 blocks nesting | ~3–5 (more via Dynamic Workflows) | `__________` |
| `{INSPECT}` | Inspect/switch/close running workers | `/agent` | `/agents`, `claude agents` | `__________` |
| `{MEMORY_FILE}` | Durable project guidance file | `AGENTS.md` | `CLAUDE.md` (or `AGENTS.md`) | `__________` |

If a tool lacks a primitive (e.g. no persistent-goal command — most don't), the
durable objective simply lives in the lead prompt that points at the checklist.
That is the normal case, not a gap.

## Tool-agnostic launcher (fill the 4 slots, keep the reference)

```
Act as a parallel coordinator. Operate strictly per the checklist at
<path-to>/references/goal-checklist.md — load it now and follow it, including the
pre-flight gate (propose a plan and wait for my confirmation before spawning).

OBJECTIVE:    [one objective]
DONE:         [the single condition that proves completion]
VERIFY WITH:  [test / check / artifact / command]
DO NOT TOUCH: [constraints / out of scope]
```

That launcher is all that goes in the prompt; everything else is in the checklist,
so the launcher stays short and the contract stays in one place.

## Adding a new tool
1. Identify its spawn, isolation, concurrency, inspect, and memory primitives.
2. Fill the table's right column (and whether it has a persistent-goal command).
3. Drop the skill folder into that tool's skills directory (see README).
4. Use the launcher above, pointing at this skill's `goal-checklist.md`.
