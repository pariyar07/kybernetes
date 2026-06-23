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
