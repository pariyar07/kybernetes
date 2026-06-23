# Adaptive Elicitation — right-sized, choice-driven steering

How to frame a run *for this task* without over-constraining it, and how to get the
human's input as taps rather than essays.

## Step 1 — size the task (sense before asking)
Estimate four things from the request:
- **Effort / size** — minutes, or a multi-hour build?
- **Independent parts** — is there real fan-out, or one coupled thread?
- **Ambiguity** — is DONE already clear, or under-specified?
- **Irreversibility / blast radius** — could a wrong move cost a lot?

## Step 2 — choose interaction depth from the size
- **Trivial** (small, clear, low-risk, no real fan-out): don't open a gate. Optionally
  one line — "I'll do X; say stop if not" — then act.
- **Medium**: ask the **one or two** decisions that actually change the outcome.
- **Large / ambiguous / risky**: a fuller framing — but still only the dimensions that
  are genuinely uncertain or high-stakes. Never run the whole menu by reflex.

The dimension menu to draw from (pick, don't recite): decomposition, model + reasoning
per role, execution substrate per slice, coordination timing, permissions, concurrency,
budget, and the stop condition. These map to checklist §1–§6 and §9.

## Step 3 — ask as choices + a recommendation
For each decision worth surfacing, present 2–4 mutually exclusive options, mark your
recommended default, and say in one line *why*. The human should be able to accept your
whole plan in a single move, or override one item. Shape:

```
Plan (recommended marked ★). Reply "go" to accept, or override any line.
1. Split:        ★ 3 slices (api / migration / tests)   |   1 slice (sequential)
2. Where:        ★ in-session subagents (read-heavy)     |   separate worktrees (writers)
3. Models:       ★ strong+high for review, fast+low for scans
4. Stop when:    ★ contract tests green + rollback intact |  (tighten this?)
```

In Claude.ai, render these as tap-able option buttons. In a CLI agent, present numbered
options and accept a terse reply ("go", or "2 → worktrees").

## Step 4 — only re-ask when the loop needs it
Don't re-open settled decisions. Return to the human mid-run only when a choice is **both
high-variety and high-stakes/irreversible**, or when error has stopped shrinking and the
fix is a re-frame (a loop-2 decision — see `operating-model.md`). Otherwise keep
regulating and log, don't ping.

## Customizable per session, not constrained
The dimensions are a stable scaffold; *which* you raise, *how many*, and *how deep* are
chosen fresh each session from the task's variety. A good run on a small task may ask
nothing; a good run on a migration may ask four things — both are correct. Rigidity is a
failure mode here, not a virtue.
