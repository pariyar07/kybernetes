# Operating Model — the coordinator as a governor

This is the control model the coordinator runs on. The checklist
(`goal-checklist.md`) is its policy; this file explains *why* the policy is shaped the
way it is, so you can adapt it intelligently instead of following it rigidly.

## The control loop
A coordinated run is a feedback loop, not a list of steps:

```
reference (DONE) → [act] → system (workers/repo/artifacts) → sensor (VERIFY WITH)
        ▲                                                            │
        └──────────────── error (gap to DONE) ◄──────────────────────┘
```

Each checkpoint samples the system, computes the **error** (distance from DONE), and
the next action is whichever one shrinks that error most. Two consequences:
- **The sensor must be trustworthy.** A loop can't converge on a bad measurement, so a
  concrete VERIFY WITH is mandatory and vague worker status is rejected. If the goal
  isn't measurable, fix that *before* acting — an unmeasurable goal is an open loop.
- **Feedforward + feedback.** Pre-flight planning is feedforward (anticipate conflicts,
  dependencies, isolation needs); checkpoint reports are feedback (react to reality).
  Use both; don't plan everything up front, don't fly blind either.

## Requisite variety → adaptive sizing (Ashby's law)
"Only variety can absorb variety." The controller must carry at least as much variety
as the task it controls. So before acting, **estimate the task's variety**:
- size / effort, number of *independent* parts, ambiguity (how clear is DONE?),
  irreversibility & blast radius (how bad is a wrong move?).

Then match your machinery AND your questions to it:
- **Low variety** → single thread, no gate, just act.
- **Medium** → a couple of workers; ask only the one or two decisions that matter.
- **High / ambiguous / risky** → more parallel branches, more roles and checks, and a
  fuller framing conversation.

Under-matching means the controller can't absorb the task (failure). Over-matching
means wasted variety — a heavy gate on a small task. Variety-matching is the one
principle that prevents *both*.

## Attenuate and amplify
A controller manages complexity by amplifying its own action and attenuating incoming
variety:
- **Amplify** — spawn workers to extend the lead's reach.
- **Attenuate** — workers return distilled summaries, not raw logs, so the lead's
  context (a finite channel) isn't swamped.
- **Attenuate for the human too** — compress a complex decision into a few options + a
  recommendation, so the human steers with one tap instead of absorbing everything.

## The escalation ladder (single → double → triple loop)
When the error isn't shrinking, climb, don't grind:
1. **Regulate (loop 1)** — adjust the action and retry toward the same setpoint.
2. **Re-frame (loop 2)** — if loop 1 stalls or oscillates, question the plan,
   decomposition, or setpoint itself: re-scope, re-split, or renegotiate DONE with the
   human. This is the main trigger for surfacing to the human mid-run.
3. **Learn (loop 3)** — persist the lesson (to the project memory file: AGENTS.md /
   CLAUDE.md / memory) so the controller itself improves next session.

This replaces "don't loop forever" with a principled response to non-convergence.

## Stability / damping
Oscillation is a control failure (thrashing between approaches, over-correcting). Damp
it: cap attempts per checkpoint; change approach after two failures rather than
repeating; apply hysteresis to stop conditions (don't re-open a satisfied checkpoint);
and resist adding one-off instructions mid-run (they inject noise into a converging
loop) — tighten the setpoint instead.

## The human as higher-order controller
The human sets the reference signal and is the controller-of-last-resort. Route a
decision to them when it is **both high-variety and high-stakes/irreversible**, or when
error won't converge. Not constantly (that defeats autonomy), not never (that risks
divergence). The choice-plus-recommendation interface is the low-bandwidth, high-leverage
control channel for this.

## Structural check (Beer's Viable System Model)
A viable coordinator has all five; a missing one predicts the failure:
- **S1 Operations** — the workers doing the slices.
- **S2 Coordination** — anti-collision: worktree isolation, shared-contract single source
  of truth. *(Missing → writers collide.)*
- **S3 Control** — resources: budget, permissions, integration, scheduling waves.
  *(Missing → budget blowout, merge chaos.)*
- **S4 Intelligence** — sensing the task and environment: research, grounding in primary
  sources, the variety estimate. *(Missing → acts on stale assumptions.)*
- **S5 Policy** — identity and purpose: OBJECTIVE, DONE, constraints, values.
  *(Missing → drift; no stopping condition.)*

Use this as a pre-flight audit: name where each of S1–S5 lives in your plan.
