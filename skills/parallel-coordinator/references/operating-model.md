# Operating Model

Kybernetes treats coordinated work as a cybernetic control loop. The lead agent
is the controller. The objective and done condition are the setpoint. The repo,
documents, workers, and artifacts are the system. Verification is the
sensor. The next agent action should be chosen because it reduces the measured
gap to done.

## The Control Loop

```text
setpoint -> act -> system -> sensor -> compare -> correct -> act
   ^                                                   |
   +-------------------- control record --------------+
```

The loop fails when the sensor is vague, the setpoint is not measurable, the
controller forgets state, or the agent keeps acting without comparing.

## Requisite Variety

Ashby's law: only variety absorbs variety.

Before acting, estimate task variety:

- Size and duration.
- Number of independent parts.
- Ambiguity of the done condition.
- Risk, irreversibility, and blast radius.
- Need for specialized expertise.
- Need for durable state.

Then match controller variety:

- Low task variety: single thread, no heavy gate.
- Medium: small checklist, one or two adaptive questions, maybe one worker.
- High: durable control record, execution profile, explicit verification,
  worker contracts, checkpoints, and HITL triggers.

Under-matching loses control. Over-matching creates drag. The coordinator's job
is adaptive sizing.

## Execution Profile

The execution profile is the run's temporary operating identity. It answers:

- What kind of work is this?
- What stance should the lead adopt?
- What artifacts should exist?
- What verification proves progress?
- What risks require escalation?
- How often should the user hear from the agent?

Generate this from the task and user answers. Do not hardcode one personality or
one engineering ceremony. A product discovery run, security review, research
synthesis, implementation, writing task, and incident response need different
profiles.

## Attenuation And Amplification

A coordinator expands reach by spawning workers and reduces overload by requiring
distilled returns.

- Amplify: workers, worktrees, side chats, automation, external checks.
- Attenuate: summaries, owned scopes, task contracts, important-file lists,
  checklists, verification outputs, concise user options.

The human should not absorb all raw detail. The lead should not absorb every log.
Both need compressed signals.

## Durable State

The control record is the persistence vantage point. It keeps the loop visible
when context windows compress, chats resume, workers return, or the runtime loses
implicit skill state.

Use it to store:

- Objective, done condition, verification, constraints.
- Execution profile.
- Important files and references.
- Current checklist.
- Workers and ownership.
- Impediments.
- Escalations.
- Intervention requests.
- Decisions.
- Learnings.
- Next checkpoint.

Do not default to changing global agent instruction files such as `AGENTS.md` or
`CLAUDE.md`. Promote a lesson there only when it is durable, reusable, and
appropriate for that repository or user.

## Escalation Ladder

When error is not shrinking, climb the ladder:

1. Regulate: change the next action while keeping the same setpoint.
2. Re-frame: change the plan, decomposition, scope, or setpoint.
3. Learn: record what the controller should do differently next time.

Repeated verification failure is a signal, not a reason to loop forever.

## Human-In-The-Loop

The human is the higher-order controller. Ask for input when autonomy would
increase risk or when the setpoint needs judgment.

Good HITL asks are small:

- 2-4 options.
- One recommended default.
- One-line consequence for each option.
- A clear statement of what happens if the user says `go`.

Use HITL for irreversible actions, privacy/security concerns, production or
customer impact, publishing, external communication, unclear scope, repeated
failure, worker conflict, or major budget changes.

## Viable System Check

Use Beer's Viable System Model as a quick structural check:

- S1 Operations: who or what does each slice?
- S2 Coordination: how do slices avoid collisions?
- S3 Control: who owns budget, permissions, scheduling, and integration?
- S4 Intelligence: how does the run sense new information and stale
  assumptions?
- S5 Policy: what objective, constraints, and values define acceptable action?

If one is missing, name it before scaling the run.

## Stability

Avoid oscillation:

- Cap repeated attempts.
- Change approach after repeated failures.
- Keep settled decisions settled unless new evidence matters.
- Do not add workers when integration is the bottleneck.
- Do not ask the human again for decisions already made.
- Re-run verification after integration, not only per slice.
