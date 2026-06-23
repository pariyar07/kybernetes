# Coordinator Operating Checklist

The contract of record for a coordinated run. Tool-specific names appear as
`{PLACEHOLDERS}` — resolve them from the per-tool reference file
(`codex.md`, `claude-code.md`) or `portable-core.md`. The human's durable
objective (Codex `/goal`, or the lead prompt in other tools) should point at THIS
file so it stays the single source of truth.

## 0. Inputs the run needs (fill at kickoff)
- **OBJECTIVE** — one objective, in a sentence or two.
- **DONE** — the single condition that must be verifiably true to stop.
- **VERIFY WITH** — the test / check / artifact / command that proves DONE.
- **CONSTRAINTS / DO NOT TOUCH** — what must not change or regress; out of scope.

## 1. Pre-flight — sense first, then right-size the gate
This gate is adaptive, not fixed (see `operating-model.md` and `adaptive-elicitation.md`).
- **Sense.** Estimate the task's variety: size, independent parts, ambiguity, and
  irreversibility/risk.
- **Size the interaction.** Trivial → don't gate, act. Medium → surface one or two
  decisions. Large/ambiguous/risky → a fuller framing.
- **Ask only what's uncertain or high-stakes** *for this task*, drawn from the dimension
  menu below — never the whole list by reflex. Present each as 2–4 tap-able options with a
  recommended default, so the human accepts the plan in one move or overrides one line.
- **Don't spawn until confirmed** (unless an autonomous mode is set, in which case proceed
  on your recommended defaults and log them). If DONE isn't measurable, fix that first.

Dimension menu (pick what matters; details in the sections below):
decomposition · model + reasoning per role (§2) · execution substrate per slice (§3) ·
coordination timing (§4) · permissions (§5) · concurrency within `{CONCURRENCY}` ·
budget (§6) · stop condition (§11).

## 2. Model & reasoning policy (suggest, then ask)
Propose a model + reasoning effort per role. Defaults to suggest:
- Coordinator / planning / integration: strongest available model, reasoning medium–high.
- Heavy reasoning / review / correctness-critical: strongest model, reasoning high.
- Read-heavy exploration / scan / triage / summarize: fast lightweight model, low–medium.
Use models CURRENTLY available on this surface; never hardcode a version. If one is
unavailable/deprecated, fall back to the nearest current model and report. If running
via a scheduler/automation, watch for an older default model and override.

## 3. Execution substrate — pick the lightest that still isolates risk
- **Main thread (no spawn)** — trivial/one-off, or work so coupled that splitting loses
  the reasoning trail.
- **In-session worker (`{SPAWN}`)** — read-heavy fan-out (exploration, triage, test/log
  analysis, drafting, summarization) and bounded steps of one plan. Returns a summary;
  cheapest to coordinate; up to `{CONCURRENCY}`. Use read-only roles for analysis.
- **Separate isolated workspace (`{ISOLATE}`)** — two or more slices that WRITE the same
  artifacts at once, or divergent approaches to compare. Each gets its own workspace so
  outputs don't collide; you integrate on completion.
- **External / background** — large fan-out, headless/CI, or another machine. Most
  control, most setup.
Rule of thumb: read-heavy → in-session workers; concurrent writers → separate
workspaces; trivial → main thread; big/headless → external. Never let two writers share
one workspace. Don't run a cross-cutting cleanup in parallel with other edits — sequence it.

## 4. Coordination timing — pick per slice, state your choice
- **Fork-join (default)** — spawn, let them finish, collect summaries, integrate. Best
  when slices are independent and need no mid-run steering.
- **Async / non-blocking** — don't wait; each worker reports to the coordinator on a
  meaningful event (checkpoint, blocker, scope change, finding affecting other slices)
  while others run. Requires isolated workspaces; else fall back to fork-join.
Substrate (§3, WHERE) and timing (WHEN you collect) are independent choices.

## 5. Permissions & safety
- Least privilege per role: explorers/research read-only; only builders write, within
  scope. Workers inherit the sandbox; an action needing fresh approval in an unattended
  run will FAIL back to you, so scope access up front.
- Irreversible actions (publish, deploy, push to shared branches, delete, external
  comms) require explicit human approval. Do not read or move secrets.

## 6. Budget & guardrails
- Ceiling: max parallel workers, a wall-clock/token budget, and max attempts per
  checkpoint. Stop and report rather than burn budget.
- No infinite repair loops: if the same approach fails twice, change approach or escalate.

## 7. Ground every decision
Workers consult primary sources before acting: official docs, upstream repos/specs, or
the existing material/code in scope. Prefer reading the real source over recall. A worker
that can't ground a decision surfaces the gap rather than guessing.

## 8. Shared contracts — single source of truth
If slices share an interface/schema/contract, ONE worker owns and writes it first;
others consume it read-only. Never let parallel writers edit the same shared definition.

## 9. Each worker gets a TASK CONTRACT (never prefix with a goal command)
State for each worker: one bounded objective + its own "done"; which sources to read
first; its permission scope and isolation; to work in checkpoints and persist progress
at each (commit / save artifact / append to the log) before continuing; and the summary
to return — distilled findings, decisions, open questions, not raw output. Keep a
registry of live workers (what each owns + status); close finished ones with `{INSPECT}`.

## 10. Integration, log & resumability
Keep one short progress log. You are the integration layer — integrate worker summaries
in the planned order, resolve conflicts, and RE-RUN VERIFY WITH on the INTEGRATED state
before the next wave (per-slice green ≠ integrated green). Make checkpoints resumable so a
paused/interrupted run continues without redoing finished work.

## 11. Stop conditions
- **Success** — DONE verifiably true via VERIFY WITH.
- **Blocked** — if no defensible path remains under current limits, stop and report the
  blocker plus the smallest decision/input that would unblock it. Do not loop.
- **Then learn** — persist any non-obvious lesson (what worked, what the sizing got wrong,
  a gotcha) to the project memory file so the next run starts smarter. See the escalation
  ladder in `operating-model.md`.
