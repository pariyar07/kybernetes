# Kybernetes - Agent Instructions

Kybernetes is an open-source steering layer for coding agents. Keep repository guidance generic, portable, and independent from any maintainer's private workspace.

## Repository Shape

```text
skills/
  kybernetes-loop-governor/  # public installable skill, `kybernetes:loop-governor`
docs/
  architecture/              # runtime and boundary design
  product/                   # product model and non-goals
examples/                    # durable example control records
tests/
  pressure-scenarios/        # behavioral pressure scenarios for skill changes
```

## Public Boundary

- Public defaults must work for people who do not know the maintainer's private projects, vaults, or workflows.
- Do not add private workspace content, customer context, secrets, credentials, internal URLs, or production data.
- Do not make any personal knowledge base, issue tracker, chat service, or project-management tool the default persistence layer.
- Runtime-specific assumptions belong in runtime binding references, not in generic loop-governor semantics.
- New installable skills need pressure-scenario evidence before creating a `SKILL.md`; planned skills stay in `docs/architecture/planned-skills.md`.
- Committed `.kybernetes/` and `.agent-runs/` live-run artifacts are out of bounds unless they are intentionally promoted examples under `examples/` or tests.

## Working Rules

- Read `PUBLIC_BOUNDARY.md` before changes that could affect public/private scope.
- Read `CONTRIBUTING.md` before changing skill behavior.
- For skill changes, update or add a pressure scenario in `tests/pressure-scenarios/`, show the failure or gap, then change the smallest relevant skill text.
- Keep `skills/kybernetes-loop-governor/SKILL.md` focused on operational instructions. Put deeper runtime details in `references/`.
- Do not add placeholder folders under `skills/`; every folder there must contain a real `SKILL.md`.
- Preserve the V1 contract: one public installable skill, `kybernetes:loop-governor`, until pressure evidence justifies a split.

## Validation

There is no package install step for the current repo shape. Use the GitHub workflow definitions as the source of truth for repository checks.

Useful local checks:

```bash
git status --short
find . -name '.DS_Store' -print
git ls-files '.kybernetes/*'
```

For skill-boundary edits, mirror the relevant shell/Ruby checks from `.github/workflows/validate-skills.yml`, especially:

- skill folders have `SKILL.md` with `kybernetes:*` frontmatter
- pressure scenarios exist for skill behavior
- core semantics avoid runtime-token leakage
- `.agent-runs` references do not reappear in public defaults
- `.kybernetes/` live artifacts are not tracked

## Review Expectations

- Keep pull requests focused and explain changed behavior, scenario evidence, runtime assumptions, and known limits.
- Prefer constraints, tests, fixtures, or boundary docs over another reminder paragraph when fixing repeated failures.
- Before calling work done, run the smallest check that can reject the change and state any validation gaps.
