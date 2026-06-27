---
name: "kybernetes:loop-governor"
description: Use when a task needs adaptive loop control: loop altitude, loop-readiness, durable state, verification, HITL, subagents, worktrees, or auditable coordination.
---

# Kybernetes Loop Governor

Use this skill as the lead-agent control loop for work that may need planning,
adaptive questions, durable state, verification, parallel workers, or careful
handoff across turns. The goal is not "more process" or "more agents"; the goal
is a cybernetic loop: sense the task, compare reality to the desired setpoint,
choose the right loop altitude, act, measure, correct, and learn.

Parallel coordination is one possible actuation mode. It is not the identity of
Kybernetes.

Read these before a coordinated run:

- `references/operating-model.md` for the control principles.
- `references/goal-checklist.md` for the control record shape.
- `references/adaptive-elicitation.md` for question sizing.
- One runtime binding: `references/codex.md`, `references/claude-code.md`, or
  `references/portable-core.md`.

## Loop Readiness Gate

Before creating machinery, decide whether the loop is ready and what altitude it
needs. A loop is ready when the loop governor can name:

- Setpoint: objective and measurable done condition.
- Sensor: the verification or evidence that can reject bad output.
- Actuators: main-thread work, checklist, goal, workers, worktrees, tools,
  research, tests, or HITL.
- State: whether durable run memory is needed.
- Stop condition: success, blocked, re-frame, or human decision.
- Boundary: permissions, external effects, secrets, budget, and human review.

If the setpoint or sensor is vague, go `down`: ask the smallest useful question,
find evidence, define a verifier, or reduce the problem before acting. Do not
create a large loop around an unmeasurable task.

## First Decision

After the readiness gate, choose the smallest useful loop altitude:

- `stay`: remain in the current loop when the gap to DONE is shrinking.
- `down`: descend into evidence, reproduction, tests, artifacts, narrower scope,
  or a concrete verifier when reliability is weak.
- `up`: ascend into planning, architecture, decomposition, scope, product
  judgment, or human decision when the current loop is too local.
- `stack`: create bounded child loops only when each has a setpoint, sensor,
  owner, boundary, and return path.
- `stop`: finish, block, ask HITL, or halt at an authorization or judgment
  boundary.

Then decide how much machinery the task actually needs.

- Low variety: small, clear, low-risk, no real fan-out. Say in one line why the
  loop is staying lightweight, then do the work. Do not create a goal or
  control record by default.
- Medium variety: ask only the one or two decisions that change the outcome,
  then create a short checklist. Use a goal or control record when the work has
  multiple files, meaningful verification, or may cross a turn.
- High variety: create or locate a durable control record, ask adaptive
  pre-flight questions, bind to the runtime, then execute in checkpoints.
- Extreme variety: create durable state and a runtime goal when available,
  produce a short architecture/decomposition pass before implementation, choose
  an execution substrate, then execute through checkpoints. Do not jump straight
  from prompt to full implementation.

Never run a fixed questionnaire. Ask the missing dimensions that matter for this
task and present choices with a recommended default.

If the user grants autonomy, such as "you decide" or "make a first version",
treat that as permission to choose safe defaults, not as permission to skip the
control decision. State the defaults you are choosing. For high and extreme
variety, present a compact plan that the user can accept with `go` or override
unless the prompt already provides all outcome-changing choices.

If you choose not to ask questions, spawn workers, browse, or use parallel
chats for a high-variety task, record why that lighter path is still sufficient.
The absence of fan-out should be an explicit control decision, not an accident.

## Build The Execution Profile

For any non-trivial run, define the operating stance before significant work:

- Task type: product, engineering, research, writing, operations, review, or a
  custom mix.
- Role stance: the temporary expert posture the agent should take for this work.
  Generate it from the task and user answers; do not hardcode personas.
- Risk posture: reversible, review-required, irreversible, or external-impact.
- Expected artifacts: checklist, plan, ADR, HLD, LLD, code, docs, issue, PR,
  knowledge-base note, report, or other.
- Verification style: tests, diff review, citations, screenshots, human review,
  validator output, acceptance criteria, or another measurable check.
- Communication cadence: brief updates, checkpoint summaries, or quiet until
  blocked.
- Escalation triggers: which conditions require human-in-the-loop.

Store this profile in the control record when one exists. If no file can be
written, keep it in the lead response and make it easy to copy.

## Durable Run Artifacts

Create Kybernetes run artifacts under one project-local run root. If the project
has no convention, use:

```text
.kybernetes/<slug>/
```

This applies to every file the Kybernetes skill creates for the run: control
records, checklists, plans, worker registries, worker summaries, evidence,
decision notes, and verification reports. Do not create run artifacts under
legacy run roots from early drafts.

Create or reuse a control record when work is long-running, cross-turn,
parallel, high-risk, goal-driven, or needs auditability. The default control
record path is:

```text
.kybernetes/<slug>/control.md
```

If the user explicitly targets an external knowledge base or workstream system,
use that system's path convention. For example:

```text
<workstream-system>/<slug>/Control.md
```

The control record should include:

- Objective
- Done condition
- Verification
- Constraints and out of scope
- Loop semantics: altitude, setpoint, sensor/evidence, actuators, stop
  condition, boundary, and next activation
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

The durable objective belongs to the lead loop-governor thread only. Do not put a
goal command inside worker prompts.

## Worker Rules

Spawn workers only when the split creates real leverage. This is the `stack`
altitude, and it must be bounded. Each worker gets a task contract, not the
whole run.

For high and extreme variety, actively evaluate whether workers, parallel chats,
or isolated workspaces would reduce risk or improve coverage. Consider fan-out
when the task has separable surfaces such as product/UX, architecture, data
model, implementation, tests, security, docs, or runtime verification. Do not
spawn workers merely because the task is large; use them when the slices are
cleanly owned and the integration cost is lower than the coverage gained.

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

Agent sprawl is a failure mode. If fan-out increases review burden, hides state,
duplicates work, or lacks an objective verifier, go `down` or `stop` instead of
adding workers.

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
3. Choose altitude: `stay`, `down`, `up`, `stack`, or `stop`.
4. Act: continue, gather evidence, re-route, spawn, integrate, verify, or
   escalate.
5. Record: update checklist, loop semantics, impediments, decisions, and
   learnings.
6. Explain: give the user 1-2 lines for meaningful routing decisions.

If the gap is not shrinking, climb the escalation ladder in
`references/operating-model.md`: regulate, re-frame, then learn. Do not retry the
same failing move indefinitely.

## Learning Policy

Write run-specific observations to the control record. Promote reusable lessons
into project memory, repo instructions, or a public skill only after a learning
capture gate:

- The lesson came from evidence, repeated pattern, or verified failure.
- The lesson is general enough to help future runs.
- The audience is correct: run-local, project-local, private memory, or public
  skill behavior.
- The lesson does not leak private workflow facts into open-source defaults.

Do not save a plausible hunch as a permanent rule.
