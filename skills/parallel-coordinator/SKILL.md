---
name: parallel-coordinator
description: Use when a task is multi-part, long-running, ambiguous, risky, parallelizable, or needs a durable goal, checklist, control record, subagents, worktrees, or auditable coordination.
---

# Parallel Coordinator

Use this skill as the lead-agent control loop for work that may need planning,
adaptive questions, durable state, parallel workers, or careful handoff across
turns. The goal is not "more process"; the goal is a small cybernetic loop:
sense the task, compare reality to the desired setpoint, act, measure, correct,
and learn.

Read these before a coordinated run:

- `references/operating-model.md` for the control principles.
- `references/goal-checklist.md` for the control record shape.
- `references/adaptive-elicitation.md` for question sizing.
- One runtime binding: `references/codex.md`, `references/claude-code.md`, or
  `references/portable-core.md`.

## First Decision

Before creating machinery, decide whether this task actually needs it.

- Low variety: small, clear, low-risk, no real fan-out. Say in one line why the
  coordinator is staying lightweight, then do the work.
- Medium variety: ask only the one or two decisions that change the outcome,
  then create a short checklist.
- High variety: create or locate a durable control record, ask adaptive
  pre-flight questions, bind to the runtime, then execute in checkpoints.

Never run a fixed questionnaire. Ask the missing dimensions that matter for this
task and present choices with a recommended default.

## Build The Execution Profile

For any non-trivial run, define the operating stance before significant work:

- Task type: product, engineering, research, writing, operations, review, or a
  custom mix.
- Role stance: the temporary expert posture the agent should take for this work.
  Generate it from the task and user answers; do not hardcode personas.
- Risk posture: reversible, review-required, irreversible, or external-impact.
- Expected artifacts: checklist, plan, ADR, HLD, LLD, code, docs, issue, PR,
  vault note, report, or other.
- Verification style: tests, diff review, citations, screenshots, human review,
  validator output, acceptance criteria, or another measurable check.
- Communication cadence: brief updates, checkpoint summaries, or quiet until
  blocked.
- Escalation triggers: which conditions require human-in-the-loop.

Store this profile in the control record when one exists. If no file can be
written, keep it in the lead response and make it easy to copy.

## Durable Control Record

Create or reuse a control record when work is long-running, cross-turn,
parallel, high-risk, goal-driven, or needs auditability. Prefer a project-local
location. If the project has no convention, use:

```text
.agent-runs/<slug>/control.md
```

If the user works in an Obsidian vault, use the relevant vault/workstream path
only when the user has explicitly targeted that vault or scope in the current
turn. For example:

```text
Agent/Workstreams/<slug>/Control.md
```

The control record should include:

- Objective
- Done condition
- Verification
- Constraints and out of scope
- Execution profile
- Important files and references
- Current checklist
- Worker registry
- Impediments
- Escalations
- Intervention requests
- Decisions
- Learnings
- Next checkpoint

Update the record after each meaningful result, blocker, routing decision, or
scope change. Keep it concise. Move detailed logs into separate files when they
start to drown the current checklist.

## Runtime Binding

Bind the loop to the current environment instead of assuming one tool.

- In Codex, use `references/codex.md`. If a goal tool is available, create the
  goal with the minimal prompt shape there. If the agent cannot create a goal,
  return a copy-paste `/goal` prompt to the user.
- In Claude Code, use `references/claude-code.md`.
- In any other skill-compatible agent, use `references/portable-core.md`.

The durable objective belongs to the lead/coordinator thread only. Do not put a
goal command inside worker prompts.

## Worker Rules

Spawn workers only when the split creates real leverage. Each worker gets a task
contract, not the whole run.

Worker contracts must include:

- Role and bounded objective.
- Owned files, paths, scope, or sources.
- Permission level: read-only, scoped write, isolated write, or external action
  prohibited.
- What the worker must not touch.
- Done condition and verification for that slice.
- Expected return format: findings, changes, risks, questions, and verification.
- How to report impediments or findings that affect other slices.

The lead integrates. Workers do not merge the full system by themselves. Never
let concurrent writers share one workspace unless the files are explicitly
partitioned and collision risk is negligible.

## Human-In-The-Loop

Ask for human input when the loop needs a higher-order controller:

- The setpoint, scope, or success criteria are unclear.
- An action is irreversible or externally visible.
- Secrets, private data, production data, customer data, publishing, deployment,
  deletion, billing, or external communication are involved.
- Worker outputs conflict or multiple plans are defensible.
- The same verification failure repeats.
- New evidence invalidates the plan.
- Budget, permissions, or time limits block progress.

When escalating, do not write an essay. Give the user the smallest useful
decision surface: 2-4 options, one recommended default, and the consequence of
choosing it.

## Checkpoint Loop

At each checkpoint:

1. Sense: what changed?
2. Compare: is the gap to DONE smaller?
3. Act: continue, re-route, spawn, integrate, verify, or escalate.
4. Record: update checklist, impediments, decisions, and learnings.
5. Explain: give the user 1-2 lines for meaningful routing decisions.

If the gap is not shrinking, climb the escalation ladder in
`references/operating-model.md`: regulate, re-frame, then learn. Do not retry the
same failing move indefinitely.

## Learning Policy

Write run-specific lessons to the control record. Promote reusable lessons into
project memory, repo instructions, or a public skill only when they are general,
validated, and appropriate for that audience. Do not hide private workflow facts
inside open-source defaults.
