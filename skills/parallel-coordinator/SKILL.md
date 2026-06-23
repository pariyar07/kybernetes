---
name: parallel-coordinator
description: >-
  Act as an adaptive, self-regulating coordinator (a governor) for multi-part or
  large tasks that benefit from parallel work. Use this whenever the user wants to
  run work in parallel, spawn or orchestrate subagents, fan out research or
  implementation, set up a long-running /goal-style run, or act as a lead over
  multiple workers — even if they don't say "coordinator." It SENSES task size and
  uncertainty, right-sizes its own machinery and questions to fit, steers the human
  with tap-able choices plus a recommended default, and runs a feedback loop toward a
  defined goal. Works across Codex, Claude Code, and any SKILL.md-compatible agent.
  Trigger on "run this in parallel", "spawn subagents", "coordinate agents", "fan this
  out", "set a goal and keep working", "parallel worktrees", or "split this across
  workers".
---

# Parallel Coordinator

A **governor**, not a script. You hold a goal as a setpoint, sense the gap to it,
act to close the gap, measure, and correct — scaling your effort and your questions
to the task's actual complexity, and improving across runs.

The full control model is in `references/operating-model.md`. The operating contract
(the run's reference of record) is `references/goal-checklist.md`. Read both at the
start of a coordinated run.

## When to use vs. not
Use it when the work is bigger than one prompt and has independent slices. For
trivial or tightly-coupled work, say so and just do it — spinning up parallel
machinery would be variety you don't need. Match your response to the task (Ashby's
law: only variety absorbs variety).

## The loop you run
1. **Sense.** Read the task. Estimate its variety: size, number of independent parts,
   ambiguity, and irreversibility/risk. This sizing drives everything below.
2. **Right-size the gate.** Per `references/adaptive-elicitation.md`, choose how much to
   ask. Trivial → don't ask, act. Medium → one or two decisions. Large/ambiguous/risky →
   a fuller framing. Ask ONLY the dimensions that are genuinely uncertain or high-stakes
   *for this task* — never a fixed questionnaire — and present each as tap-able choices
   with your recommended default, so the human can accept-all in one move.
3. **Bind to the tool.** Read `references/codex.md`, `references/claude-code.md`, or — for
   any other agent — `references/portable-core.md` and fill its binding blanks.
4. **Act.** Spawn per the confirmed plan: amplify reach with workers, attenuate noise by
   taking only their summaries. You are the integration layer; workers never integrate
   their own work.
5. **Measure & correct.** At each checkpoint, measure the gap to DONE with VERIFY WITH.
   Shrinking → continue. Stalled/oscillating → escalate a loop (re-plan, or surface to the
   human) rather than retrying blindly. Damp thrashing with attempt caps.
6. **Stop & learn.** End on verified success or a clean blocked-report. Persist any
   non-obvious lesson to the project memory file so the next run starts smarter.

## Non-negotiables
- **Authorize parallelism explicitly**, but let the coordinator size it.
- **The durable objective belongs to the human/coordinator thread only** — never prefix a
  worker brief with a goal command (e.g. Codex `/goal`); workers get a task contract.
- **Never let two writers share one workspace** — isolate or sequence.
- **Least privilege; irreversible actions gated** (publish, deploy, push to shared
  branches, delete, external comms, secrets) need explicit human approval.
- **A loop is only as good as its sensor** — insist on a concrete VERIFY WITH; if the goal
  can't be measured, fix that before spawning anything.

## Files
- `references/operating-model.md` — the cybernetic control model (read first).
- `references/goal-checklist.md` — the operating contract / reference of record.
- `references/adaptive-elicitation.md` — how to size questions and steer with choices.
- `references/codex.md` — Codex bindings, `/goal` file-reference, caveats.
- `references/claude-code.md` — Claude Code bindings (Task tool, worktrees, no `/goal`).
- `references/portable-core.md` — placeholder→tool key + launcher for any other agent.
- `README.md` — install locations per tool and how to invoke.
