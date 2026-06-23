# parallel-coordinator

The first Kybernetes seed skill. It turns a compatible agent into a
feedback-controlled lead for work that is multi-part, long-running, ambiguous,
risky, parallelizable, or needs durable state.

It does four jobs:

- Asks adaptive pre-flight questions only when the task needs them.
- Builds an execution profile for the work instead of hardcoding one persona.
- Creates or reuses a durable control record for checklist, impediments,
  decisions, learnings, and worker state.
- Coordinates workers, subagents, side chats, or worktrees while keeping the
  lead responsible for integration and verification.

## Install

From the repository root or from GitHub, prefer the skills CLI:

```bash
npx skills add pariyar07/kybernetes --list
npx skills add pariyar07/kybernetes --global --agent '*' --skill parallel-coordinator --copy --yes
```

For project-local installation, omit `--global`.

Manual install is still possible: copy this whole `parallel-coordinator/` folder
into the target agent's skills directory.

## Use

Invoke the skill as `$parallel-coordinator` or ask the agent to use the parallel
coordinator skill.

The skill loads:

1. `references/operating-model.md`
2. `references/goal-checklist.md`
3. `references/adaptive-elicitation.md`
4. The current runtime binding: `references/codex.md`,
   `references/claude-code.md`, or `references/portable-core.md`

For Codex, the `/goal` prompt should stay short and point to the control record.
For runtimes without a goal command, the lead prompt plus control record is the
durable objective.

## Files

```text
parallel-coordinator/
  SKILL.md
  agents/openai.yaml
  references/
    adaptive-elicitation.md
    claude-code.md
    codex.md
    goal-checklist.md
    operating-model.md
    portable-core.md
  README.md
```

The repository-level inspiration and diagrams live at the repo root. The
installed skill stays focused on operational instructions.
