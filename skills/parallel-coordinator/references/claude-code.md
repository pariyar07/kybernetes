# Claude Code bindings

Resolves the checklist placeholders for Claude Code and covers its differences.

## Bindings
- `{SET_GOAL}` → **no persistent-goal command.** The durable objective is the lead
  prompt that points at the checklist. Shape it in **plan mode** first if it's fuzzy.
  Resumability comes from commits + `claude --resume`, not a goal object.
- `{SPAWN}` → the **Task tool** spawns subagents — isolated Claude instances, each with
  its own context window, tools, and model, returning a summary to the lead. Define
  reusable specialists as markdown files in `.claude/agents/` (frontmatter: name,
  description, tools, model; add `isolation: worktree` to give each invocation its own
  checkout). For big fan-out use **Dynamic Workflows** (the lead plans and runs tens to
  hundreds, with a grader that revises results against a rubric).
- `{ISOLATE}` → git worktree: `claude --worktree` for sessions you run yourself, or
  `isolation: worktree` on a subagent definition for spawned workers.
- `{CONCURRENCY}` → ~3–5 concurrent subagents is the everyday sweet spot; beyond that,
  summary-merging eats the gains (Dynamic Workflows pushes this higher for clean fan-out).
- `{INSPECT}` → `/agents` (Running tab) for in-session subagents; `claude agents` (agent
  view) for background sessions.
- `{MEMORY_FILE}` → `CLAUDE.md` (also reads `AGENTS.md`).

## How to start a run
Option A — invoke the skill: mention `parallel-coordinator` (or `$parallel-coordinator`).
It loads and reads `goal-checklist.md`.

Option B — lead prompt that references the checklist:
```
Act as a parallel coordinator. Operate strictly per
@.claude/skills/parallel-coordinator/references/goal-checklist.md — load it now and
follow it, including the pre-flight gate (propose a plan and wait for my confirmation
before spawning).

OBJECTIVE: <…>   DONE: <…>   VERIFY WITH: <…>   DO NOT TOUCH: <…>
```

## Claude Code notes
- **Subagents only report to the lead.** If workers must talk to each other, use
  **Agent Teams** (experimental, `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`): a lead +
  teammates share a task list and message each other. Teammates aren't worktree-isolated,
  so partition files so each owns a distinct set.
- The lead is the integration layer — don't ask subagents to integrate their own work, or
  you get duplication and conflicts.
- Gate worker output with a `SubagentStop` hook (tests pass, no secrets in diff, no
  out-of-scope writes) before folding a result back in.

## Launcher (coding example)
```
Act as parallel coordinator per
@.claude/skills/parallel-coordinator/references/goal-checklist.md.
OBJECTIVE: migrate <module> from <A> to <B>.
DONE: contract tests pass, legacy path keeps a rollback, CI green.
VERIFY WITH: npm test, npm run build, lint, typecheck.
DO NOT TOUCH: public API of <x>, the <y> schema.
Use isolated worktrees for any concurrent writers.
```
