# Codex bindings

Resolves the checklist placeholders for Codex and covers Codex-only caveats.

## Bindings
- `{SET_GOAL}` → `/goal <objective>`. A goal is a persistent objective on the
  **current thread**, set by a human in the composer. Objectives cap at 4,000
  characters — so keep the typed goal short and **point it at this checklist file**
  rather than pasting the contract. Control with `/goal pause | resume | clear`.
  Requires `features.goals` (enable in `config.toml` or `codex features enable goals`).
- `{SPAWN}` → ask explicitly to spawn subagents (Codex never fans out on hints).
  Built-in roles: **explorer** (read-only), **worker** (read-write), **default**.
  Custom agents: TOML files in `.agents/skills`-adjacent agent dirs / `~/.codex/agents/`,
  optionally pinning `model`, `model_reasoning_effort`, `sandbox_mode`, `mcp_servers`.
- `{ISOLATE}` → git worktree per writer.
- `{CONCURRENCY}` → `[agents] max_threads` (default 6); `max_depth` defaults to 1 and
  blocks nesting — raise deliberately, it fans out cost fast.
- `{INSPECT}` → `/agent` to switch/inspect/close threads; press `o` to open an inactive
  thread that raised an approval.
- `{MEMORY_FILE}` → `AGENTS.md`.

## How to start a run
Option A — invoke the skill: type `$parallel-coordinator` (or `/skills`). The skill
loads and reads `goal-checklist.md`.

Option B — set a goal that points at the checklist:
```
/goal Operate as parallel coordinator per the checklist at
.agents/skills/parallel-coordinator/references/goal-checklist.md (load and follow it,
including the pre-flight gate). OBJECTIVE: <…>. DONE: <…>. VERIFY WITH: <…>.
DO NOT TOUCH: <…>.
```
(Adjust the path to wherever you installed the skill. You can also `@`-mention the file.)

## Codex-only caveats
- **`/goal` does nothing inside a spawned worker's prompt.** Slash commands are a
  composer action; a worker receives its brief as plain text, so a leading `/goal` is
  inert and no goal is created. Give workers a TASK CONTRACT (checklist §9); keep `/goal`
  on the one human-set coordinator thread.
- `/goal` can also fail in the composer on some builds (stuck "Not sent"; Windows
  desktop "No commands"). If so, set the objective as a normal prompt that references the
  checklist, or use the "Set as goal" message action.
- Subagents inherit the session sandbox; in non-interactive runs an action needing fresh
  approval fails back to the parent — scope `/permissions` up front.

## Launcher (coding example)
```
/goal Coordinate per parallel-coordinator/references/goal-checklist.md.
OBJECTIVE: migrate <module> from <A> to <B>.
DONE: contract tests pass, legacy path keeps a rollback, CI green.
VERIFY WITH: `npm test`, `npm run build`, lint, typecheck.
DO NOT TOUCH: public API of <x>, the <y> schema.
```
