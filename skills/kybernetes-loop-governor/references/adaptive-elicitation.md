# Adaptive Elicitation

Ask enough to control the run, not enough to perform ceremony.

## 1. Sense Before Asking

Estimate:

- Effort and duration.
- Number of independent parts.
- Ambiguity in the done condition.
- Risk, irreversibility, and external impact.
- Whether durable state is needed.
- Whether specialized roles would materially improve the result.
- Whether the setpoint and sensor are measurable enough to run a loop.

## 2. Choose Question Depth

- Low variety: ask nothing or give one line of intent, then act.
- Medium variety: ask one or two choices that change the outcome.
- High variety: ask enough to define objective, done condition, verification,
  execution profile, decomposition, safety boundaries, and HITL triggers.
- Extreme variety: before implementation, present a compact decision surface for
  scope, architecture, execution substrate, decomposition, worker/parallel
  strategy, verification, and HITL triggers. If the user has given enough
  information, state the defaults and proceed in checkpoints.

The correct number of questions is adaptive. A tiny task may need zero. A
multi-week migration may need several. Never recite the whole menu by reflex.

Autonomy is not a waiver. When the user says "you decide", "first version", or
"move fast", choose defaults and name them. Do not silently collapse a
high-variety task into the same single-thread loop used for a small task.

If DONE or verification is vague, ask the smallest question that makes the loop
measurable before adding workers, goals, or automation.

## 2.1 Variety Ladder

Use this ladder to calibrate the control surface:

- Simple app or single artifact: one surface, clear DONE, local verification,
  no external effect. Lightweight main-thread execution is usually right.
- Medium app or tool: multiple files or UI plus local runtime, but one owner and
  safe local verification. Use a short checklist, maybe a goal/control record.
- Hard integration or platform slice: external API shape, secrets boundary,
  state model, mock mode, tests, and docs. Use durable state, explicit safety
  boundaries, and a pre-flight decision surface.
- Extreme system prototype: multiple subsystems, runtime routing, control plane,
  observability, health checks, config, security boundaries, and integrated
  verification. Use durable state, architecture/decomposition first, explicit
  worker/substrate decision, and checkpointed integration.

## 2.2 Altitude Choice

Use loop altitude to decide the next control move:

- `stay`: current loop is shrinking the gap.
- `down`: need evidence, verifier, reproduction, test, artifact, or narrower
  scope.
- `up`: need plan, architecture, decomposition, scope, product judgment, or
  human decision.
- `stack`: bounded child loops will help and each has owner, setpoint, sensor,
  boundary, and return path.
- `stop`: done, blocked, authorization boundary, or human judgment needed.

## 3. Build The Execution Profile

Use the user's answers and the task itself to generate:

- Task type.
- Role stance.
- Risk posture.
- Expected artifacts.
- Verification style.
- Communication cadence.
- Escalation triggers.

The role stance is a working posture, not a fixed persona. It should fit the
work: product, engineering, research, writing, review, operations, or a custom
blend.

## 4. Ask As Choices

Present each uncertain/high-stakes dimension as options with a recommended
default:

```text
Plan. Reply "go" to accept, or override any line.
1. Split: recommended 3 slices (docs / runtime / tests) | sequential
2. Altitude: recommended up for architecture, then down for verification | stay
3. State: recommended .kybernetes/<slug>/ for run files | no durable file
4. Workers: recommended read-only review worker first | no workers yet
5. Verify: recommended pressure-scenario checklist + repo validation | docs only
```

Good options include the tradeoff in one line. The human should not need to read
an essay to steer the run.

For hard and extreme work, include a "Workers/substrate" line even when the
recommended choice is no workers yet. This makes under-orchestration visible:

```text
Workers/substrate: recommended single-writer for first scaffold because files
are not yet partitioned | read-only architecture/test workers first | isolated
workspaces for concurrent implementation
```

## 5. Re-Ask Only When The Loop Needs It

Do not re-open settled decisions. Ask again when:

- The setpoint is unclear.
- New evidence invalidates the plan.
- The next action is irreversible or external.
- Verification fails repeatedly.
- Workers disagree in a way that affects the result.
- Budget, permissions, or time change the feasible plan.

When asking mid-run, label it as an intervention request and include your
recommended default.
