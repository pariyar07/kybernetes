# Product Identity

Kybernetes is a runtime-adaptive steering layer and portable control contract
for agentic work.

It operationalizes loop engineering: agents should choose the smallest
sufficient control loop instead of blindly adding process or parallel workers.
The core posture vocabulary is `stay`, `down`, `up`, `stack`, and `stop`.

## Working Tagline

A cybernetic loop governor that helps agents hold goals, ask better questions, coordinate work, correct drift, and leave durable state behind.

## Name Rationale

`Kybernetes` means steersman, pilot, or governor. It points to the same lineage as cybernetics: steering a system through feedback.

The product should feel like a calm lead at the helm of agentic work. It keeps a goal visible, senses drift, chooses the right operating model, coordinates workers, and brings the human back in when the next move needs judgment.

The name is intentionally broader than any one knowledge system or agent framework. Tool-specific integrations can become adapters, but Kybernetes stays a runtime-adaptive control plane.

## What It Is

- a control model for long-running agent work
- a five-skill harness with one canonical loop governor and four bounded helpers
- a runtime binding layer for Codex, Claude Code, and future agent runtimes
- a durable state pattern for goals, checklists, workers, impediments, decisions, and learnings
- a human-in-the-loop steering pattern with options and recommendations

“Control plane” describes semantic ownership: Kybernetes keeps canonical loop
state independent from runtime goals, workers, hooks, schedules, and UI. The
current package is not a production scheduler or transactional orchestration
backend, and its outcome and overhead claims have not yet been established by a
controlled external-user study.

## What It Is Not

- a single-knowledge-system workflow
- one tool's feature
- a single checklist file
- an autonomous daemon that acts without boundaries
- a replacement for agent runtimes
- a reason to over-process small tasks
