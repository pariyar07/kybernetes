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

## 2. Choose Question Depth

- Low variety: ask nothing or give one line of intent, then act.
- Medium variety: ask one or two choices that change the outcome.
- High variety: ask enough to define objective, done condition, verification,
  execution profile, decomposition, safety boundaries, and HITL triggers.

The correct number of questions is adaptive. A tiny task may need zero. A
multi-week migration may need several. Never recite the whole menu by reflex.

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
2. State: recommended .agent-runs/kybernetes/control.md | no durable file
3. Workers: recommended read-only review worker first | no workers yet
4. Verify: recommended pressure-scenario checklist + repo validation | docs only
```

Good options include the tradeoff in one line. The human should not need to read
an essay to steer the run.

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
