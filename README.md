# Kybernetes

Runtime-adaptive control plane for agentic work.

Kybernetes helps coding agents and skill-compatible runtimes coordinate long-running work through feedback loops: define a goal, ask adaptive questions, create durable control records, choose execution mode, coordinate workers, surface impediments, and verify completion.

## Why

Agents lose state, over-plan small tasks, under-plan risky tasks, confuse worker boundaries, and forget why they made decisions. Kybernetes gives the lead agent a small cybernetic control system: hold a setpoint, sense the gap, act, measure, correct, and learn.

## Why The Name Kybernetes

`Kybernetes` comes from the Greek idea of a steersman, pilot, or governor. It is also the root lineage behind cybernetics: systems that steer through control, communication, and feedback.

That is the product metaphor. Kybernetes is not meant to be another checklist. It is the steersman for agentic work: it holds the goal, senses drift, chooses the right amount of machinery, coordinates workers, asks for human steering when needed, and corrects course until the work is verified.

The name also keeps the project independent from any one runtime or knowledge system. Ariadne can wrap it later through an adapter, but Kybernetes should remain useful for Codex, Claude Code, and other skill-compatible agents.

## Current Status

This repository is in early seed form.

The first usable skill is:

- [`skills/parallel-coordinator`](skills/parallel-coordinator/README.md)

Future work may split the broader system into `adaptive-coordinator`, runtime bindings, portable core fallbacks, examples, and tested pressure scenarios. Planned skills live in architecture docs until pressure scenarios prove they need a real installable `SKILL.md`.

## Control Model

![Governor loop](docs/assets/diagrams/1-governor-loop.svg)

![Requisite variety](docs/assets/diagrams/2-requisite-variety.svg)

![Three loops](docs/assets/diagrams/3-three-loops.svg)

The deeper rationale is in [INSPIRATION.md](INSPIRATION.md).

## Repository Shape

```text
skills/
  parallel-coordinator/      # v0 seed skill

docs/
  product/
  architecture/

examples/
  codex-goal-run/
  portable-run/

tests/
  pressure-scenarios/
```

Planned skills are documented in [docs/architecture/planned-skills.md](docs/architecture/planned-skills.md). They will move into `skills/` only after pressure scenarios justify publishing a real `SKILL.md`.

## Install The Seed Skill

Use the skills CLI to install from GitHub.

List available Kybernetes skills:

```bash
npx skills add pariyar07/kybernetes --list
```

Install the seed skill globally for all supported agents:

```bash
npx skills add pariyar07/kybernetes \
  --global \
  --agent '*' \
  --skill parallel-coordinator \
  --copy \
  --yes
```

For project-local installation, omit `--global`.

Then invoke it as `$parallel-coordinator` or ask your agent to use the parallel coordinator skill for a large, multi-part, or long-running task.

## Public Guardrails

- Public defaults must be generic. Satyam-specific dogfooding belongs in private notes or optional adapters.
- New `SKILL.md` files require pressure scenarios first.
- Runtime-specific assumptions belong in runtime bindings, not generic coordinator behavior.
- Irreversible actions, secrets, publishing, deploys, and external communications require explicit human approval.

## License

MIT. See [LICENSE](LICENSE).
