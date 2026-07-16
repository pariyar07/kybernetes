# kybernetes:loop-governor

The primary Kybernetes skill. It turns a compatible agent into a
runtime-adaptive loop controller for work that is multi-part, long-running,
ambiguous, risky, parallelizable, or needs durable state.

It does six jobs:

- Checks loop readiness before adding machinery.
- Chooses loop altitude: `stay`, `down`, `up`, `stack`, or `stop`.
- Builds an execution profile for the work instead of hardcoding one persona.
- Creates or reuses `.kybernetes/<slug>/` run memory for control records,
  verification, checklists, impediments, decisions, learnings, and worker state.
- Coordinates workers, peer workstreams, or isolated work only when bounded child
  loops create real leverage.
- Converts repeated failures into durable constraints before adding reminders.

The always-loaded `SKILL.md` is intentionally lean. Small foreground work uses
the kernel alone. Durable or higher-variety work resolves focused modules from
`references/reference-index.md`; `.kybernetes/<slug>/manifest.md` records the
selected modules and runtime binding for reconstruction across turns.

## Install

From the repository root or from GitHub, prefer the skills CLI:

```bash
npx skills add <owner>/kybernetes --list
npx skills add <owner>/kybernetes --global --agent '*' --skill 'kybernetes:loop-governor' --copy --yes
```

For project-local installation, omit `--global`.

Manual install is still possible: copy this whole `kybernetes-loop-governor/`
folder into the target agent's skills directory.

## Use

Invoke the skill as `$kybernetes:loop-governor` or ask the agent to use the
Kybernetes loop governor skill.

Legacy note: older drafts used `$parallel-coordinator`. Treat that name as a
compatibility alias only. New docs, prompts, tests, and examples should use
`$kybernetes:loop-governor`.

The skill loads references conditionally. Read `references/reference-index.md`
to map task signals to modules, and use `manifest.md` as the portable schema for
durable reconstruction. Exactly one runtime binding is selected from observed
capability: `references/codex.md`, `references/claude-code.md`, or
`references/portable-core.md`.

For runtimes with a native durable-objective surface, keep the objective brief
and point to the control record. Otherwise, the lead prompt plus control record
is the durable objective.

## Files

```text
kybernetes-loop-governor/
  SKILL.md
  manifest.md
  agents/openai.yaml
  references/
    adaptive-elicitation.md
    claude-code.md
    codex.md
    failure-to-constraint.md
    goal-checklist.md
    operating-model.md
    portable-core.md
    reference-index.md
    runtime-use-rubric.md
  README.md
```

The repository-level inspiration and diagrams live at the repo root. The
installed skill stays focused on operational instructions.
