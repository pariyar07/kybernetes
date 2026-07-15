# Contributing

Kybernetes is early. Contributions should preserve the project boundary: generic runtime-adaptive agent coordination first, optional runtime or product adapters second.

## What Helps

- Pressure scenarios that expose coordinator failures.
- Runtime binding notes for Codex, Claude Code, and other skill-compatible agents.
- Small skill improvements backed by a before/after scenario.
- Examples of durable control records, worker contracts, and goal prompts.

## Skill Changes

Skills are process code. Treat them like tested behavior:

1. Write or update a pressure scenario in `tests/pressure-scenarios/`.
2. Show the failure or gap the skill must address.
3. Change the smallest relevant skill text.
4. Re-run the scenario and record what changed.

Do not add new `SKILL.md` files for planned skills until the pressure scenarios justify them.

## Pull Requests

Keep pull requests focused. Include:

- what behavior changed
- which scenario or example supports it
- any runtime-specific assumptions
- any known limits

## Stacking Pull Requests

If a second branch depends on a first, unmerged branch (a "stacked" PR),
choose one of these before either PR merges:

- Merge the base PR with a merge commit (not squash), so the base branch's
  history is a real ancestor of `main`. The dependent PR can then be
  retargeted to `main` and will merge cleanly.
- If the base PR must be squash-merged, manually retarget the dependent
  PR's base to `main` immediately after the base PR merges, before doing
  anything else with that PR.

Do not assume GitHub retargets a dependent PR automatically after a
squash-merge — it does not. A squash-merge creates a new commit with
different content hashes than the original branch commits, even when the
text is identical, so a dependent PR left pointed at the old base will
show false merge conflicts on every line the base PR touched, and in the
worst case can report "MERGED" after merging into an orphaned branch that
never reaches `main` at all.
