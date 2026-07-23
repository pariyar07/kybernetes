# Runtime-Portable Trajectory Control Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add rejection-capable liveness and trajectory control to Kybernetes while preserving a small runtime-neutral kernel and verified bindings for ChatGPT Work mode, Codex, Claude Code, and Claude Cowork.

**Architecture:** Add one lazy-loaded normative trajectory reference and a conditional L2 `trajectory_sensor` contract. The governor owns strategy decisions, completion verification remains separate, task adapters supply thresholds, and L3 runtime references bind the same semantics to observed capabilities.

**Tech Stack:** Markdown skill contracts and pressure scenarios, Ruby static validators, GitHub Actions.

## Global Constraints

- Do not add a new installable skill.
- Keep one parent governor and one canonical writer.
- Keep `verification.md` completion-focused; use `control.md` for the current trajectory summary and conditional `trajectory.md` only for high/extreme recurring or detached history.
- Treat progress, safety, completion, and trajectory as distinct sensor questions.
- Keep thresholds domain-defined; the portable kernel defines required fields and rejection behavior only.
- Preserve finite goals and continuing programs as different program kinds.
- Runtime documentation is not proof of active agent-callable capability; every binding must retain a safe probe and portable fallback.
- Do not tag, publish, or replace the installed `v0.1.3` skills without a separate release approval.

---

## File Map

| File | Responsibility |
| --- | --- |
| `tests/pressure-scenarios/075-detached-run-remains-safe-but-stalled.md` | Primary pre-activation and cross-window liveness failure. |
| `tests/pressure-scenarios/076-proxy-activity-misclassified-as-progress.md` | Typed outcome-funnel rejection. |
| `tests/pressure-scenarios/077-actuator-exists-without-actionable-capacity.md` | Readiness capacity and fallback coverage. |
| `tests/pressure-scenarios/078-strategy-change-expands-authority.md` | Autonomous strategy-envelope boundary. |
| `tests/pressure-scenarios/079-healthy-maintenance-misclassified-as-stall.md` | Maintenance and event-wait semantics. |
| `tests/pressure-scenarios/080-runtime-binding-assumed-from-documentation.md` | Four-runtime capability-probe behavior. |
| `tests/validate-trajectory-kernel.rb` | Reject missing core liveness semantics. |
| `tests/validate-trajectory-readiness.rb` | Reject weak readiness, state, funnel, and authority contracts. |
| `tests/validate-trajectory-port.rb` | Reject an incomplete L2 trajectory sensor. |
| `tests/validate-runtime-portability.rb` | Require all four named runtime bindings and portable fallback semantics. |
| `skills/kybernetes-loop-governor/references/trajectory-control.md` | Normative liveness, progress-model, funnel, state, strategy, and sizing contract. |
| `skills/kybernetes-loop-governor/SKILL.md` | Lean rejection-capable kernel and lazy-load trigger. |
| `skills/kybernetes-loop-governor/references/reference-index.md` | Route trajectory and the two new runtime references. |
| `skills/kybernetes-loop-governor/references/goal-checklist.md` | Durable readiness and state-shape guidance. |
| `skills/kybernetes-loop-governor/references/activation-bindings.md` | Persistent no-progress accounting across activations. |
| `skills/kybernetes-loop-governor/references/capability-negotiation.md` | Per-activation capability freshness and safe probe contract. |
| `skills/kybernetes-loop-architect/SKILL.md` | Extreme-detached architecture proposal fields. |
| `docs/architecture/l2-port-contracts.md` | Conditional `trajectory_sensor` capability contract. |
| `docs/architecture/runtime-adapter-model.md` | L0/L1/L2/L3 placement for trajectory sensing. |
| `skills/kybernetes-loop-governor/references/chatgpt-work.md` | ChatGPT Work mode L3 binding. |
| `skills/kybernetes-loop-governor/references/codex.md` | Codex trajectory and schedule-mutation binding. |
| `skills/kybernetes-loop-governor/references/claude-code.md` | Claude Code trajectory and scheduling binding. |
| `skills/kybernetes-loop-governor/references/claude-cowork.md` | Claude Cowork L3 binding. |
| `skills/kybernetes-loop-governor/references/portable-core.md` | No-native-capability fallback. |
| `skills/kybernetes-loop-governor/README.md` | Complete five-choice runtime resolver list. |
| `docs/architecture/portable-runtime-matrix.md` | Condensed four-runtime comparison and trajectory row. |
| `.github/workflows/validate-skills.yml` | Execute all new validators in CI. |

---

### Task 1: Capture the safe-but-stalled failure as a rejecting test

**Files:**
- Create: `tests/pressure-scenarios/075-detached-run-remains-safe-but-stalled.md`
- Create: `tests/validate-trajectory-kernel.rb`

**Interfaces:**
- Consumes: current governor kernel and reference-index contract.
- Produces: the required vocabulary and failure behavior for `trajectory-control.md` and the governor.

- [ ] **Step 1: Add the primary pressure scenario**

Create `tests/pressure-scenarios/075-detached-run-remains-safe-but-stalled.md`:

```markdown
# 075 - Detached Run Remains Safe But Stalled

## Failure

An extreme detached run has one dominant actuator. Canonical state, safety,
permissions, and scheduled activations remain green, but two complete progress
windows produce zero admissible domain delta. Actionable capacity is exhausted,
no approved fallback has usable capacity, and the next proposed activation would
repeat the same status check and actuator path.

## Expected Coordinator Behavior

- Treat administrative activity and runtime success as zero outcome progress.
- Reject `stay` with the unchanged strategy at the cumulative no-progress cap.
- Mark the fully measured zero-delta trajectory `unhealthy`; reserve `unknown`
  for missing or stale sensing.
- Preserve the same `strategy_id` and cumulative deficient-window count across
  reconstruction and runtime handles.
- Pause or retire the non-producing activation before redesign.
- Select a materially different approved fallback, request a precise authority
  decision, or supersede the workstream.
- Preserve the original objective and evidence standard.
- Make neither a completion claim nor a negative domain verdict.
```

- [ ] **Step 2: Add the failing kernel validator**

Create `tests/validate-trajectory-kernel.rb`:

```ruby
#!/usr/bin/env ruby

def require_file(path)
  abort("missing required file: #{path}") unless File.file?(path)
  File.read(path)
end

def require_terms(path, content, terms)
  missing = terms.reject { |term| content.include?(term) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
end

scenario_path = "tests/pressure-scenarios/075-detached-run-remains-safe-but-stalled.md"
reference_path = "skills/kybernetes-loop-governor/references/trajectory-control.md"
governor_path = "skills/kybernetes-loop-governor/SKILL.md"
index_path = "skills/kybernetes-loop-governor/references/reference-index.md"

scenario = require_file(scenario_path)
reference = require_file(reference_path)
governor = require_file(governor_path)
index = require_file(index_path)

require_terms(
  scenario_path,
  scenario,
  [
    "zero admissible domain delta",
    "Actionable capacity is exhausted",
    "cumulative no-progress cap",
    "unchanged strategy",
    "negative domain verdict",
  ],
)

require_terms(
  reference_path,
  reference,
  [
    "program_kind",
    "progress_model",
    "minimum_delta",
    "no_progress_cap",
    "actionable_capacity",
    "trajectory.md",
    "attempted",
    "delivered",
    "reached",
    "engaged",
    "evidence_acquired",
    "Owner Approval Required",
  ],
)

require_terms(
  governor_path,
  governor,
  ["trajectory", "cumulative no-progress", "unchanged strategy"],
)
require_terms(index_path, index, ["`trajectory`", "trajectory-control.md"])

puts "trajectory kernel validation passed"
```

Before this validator is considered passing, parse exactly one `## Control Law`
section, require its cap-scoped rejection of `stay` with the unchanged strategy,
reject any rule allowing that move, and tie scenario 075's fully measured fixture
to `unhealthy` while reserving `unknown` for missing or stale sensing.

- [ ] **Step 3: Run the validator and demonstrate the current gap**

Run:

```bash
ruby tests/validate-trajectory-kernel.rb
```

Expected: FAIL with:

```text
missing required file: skills/kybernetes-loop-governor/references/trajectory-control.md
```

- [ ] **Step 4: Commit the failing pressure evidence**

```bash
git add tests/pressure-scenarios/075-detached-run-remains-safe-but-stalled.md tests/validate-trajectory-kernel.rb
git commit -m "test: expose safe but stalled detached runs"
```

---

### Task 2: Add the smallest rejection-capable trajectory kernel

**Files:**
- Create: `skills/kybernetes-loop-governor/references/trajectory-control.md`
- Modify: `skills/kybernetes-loop-governor/SKILL.md`
- Modify: `skills/kybernetes-loop-governor/references/reference-index.md`
- Modify: `.github/workflows/validate-skills.yml`
- Test: `tests/validate-trajectory-kernel.rb`

**Interfaces:**
- Consumes: scenario 075 and the existing altitude, single-writer, and lifecycle contracts.
- Produces: module identifier `trajectory`, the normative liveness contract, and a kernel-level rejection rule.

- [ ] **Step 1: Create the normative trajectory reference**

Create `skills/kybernetes-loop-governor/references/trajectory-control.md` with these complete sections and fields:

````markdown
# Trajectory Control

Load this module for high/extreme recurring or detached work, repeated no-change,
multi-window experiments, continuing programs, or strategy redesign. Keep clear,
reversible, immediately verifiable work on the governor kernel alone.

## Program Contract

Every governed trajectory records:

```yaml
program_kind: finite | continuing
objective: evidence-backed outcome
strategy_id: stable causal-strategy identity
done_or_health: measurable finite DONE or continuing health invariant
review_horizon: not_applicable or bounded continuing review/renewal point
cycle_verifier: not_applicable or rejection-capable continuing health check
progress_model: convergence
progress_metric: typed admissible observation
measurement_window: bounded time, events, or activations
minimum_delta: smallest meaningful result for that window
no_progress_cap: maximum deficient windows for one strategy
actionable_capacity: observations and actions reachable through approved sensors and actuators
fallbacks: ordered pre-authorized alternatives
strategy_envelope: allowed autonomous changes
escalation: owner and exact decision
retirement: stop and cleanup condition
```

Finite work keeps evidence-backed measurable DONE and completion verification;
its continuing-only fields may be `not_applicable`. Continuing work has a health
invariant, bounded cycles, a review horizon, and a cycle verifier; a healthy cycle
does not complete the continuing policy objective. Change `strategy_id` only for
a materially different causal approach.

## Progress Models

| Model | Healthy window | Deficient window |
| --- | --- | --- |
| `convergence` | The outcome gap shrinks by `minimum_delta`. | The gap is flat, grows, or becomes unmeasurable. |
| `information` | Admissible evidence reduces named uncertainty. | Activity occurs without admissible information gain. |
| `maintenance` | Fresh evidence covers the invariant and remains inside bounds. | Coverage is stale, missing, or outside bounds. |
| `event_wait` | The event sensor remains fresh inside a bounded wait, or the event advances state. | The sensor is stale, the wait exceeds its bound, or polling cannot affect the next decision. |

Zero numeric change can be healthy for `maintenance`. A modeled fresh wait need
not consume the no-progress budget. Administrative activity, runtime success, or
unbounded status polling is not progress in any model.

## Four Sensor Questions

- Progress: did the move or observation produce the admissible signal required by
  the progress model?
- Safety: is the proposed effect inside permission, policy, privacy, budget, and
  reversibility boundaries?
- Completion: does admitted evidence satisfy finite DONE?
- Trajectory: can the current strategy satisfy its progress model within the
  remaining horizon, review period, capacity, and resources?

Safety and state consistency cannot make trajectory healthy. Trajectory cannot
declare completion. The completion verifier remains independently rejection-capable.

## Extreme Detached Admission

An extreme detached run requires an architecture contract before activation. The
contract may be inline in `control.md`; invocation of the architect helper is
optional. Record program kind, strategy identity, progress model and metric,
capacity, minimum delta, no-progress cap, fallback coverage, strategy envelope,
finite completion verifier or continuing review horizon and cycle verifier,
notification, and retirement. If approved capacity cannot plausibly satisfy the
first window, stay in design or request the smallest authority change.

Classify a detached run as extreme when unattended or recurring activation combines
with consequential external effects, multiple independent actuators/workstreams,
feedback latency longer than one activation, material uncertainty about reachability
or evidence admissibility, reconstruction risk beyond chat history, or likely
strategy change under bounded authority.

## Typed Outcome Funnel

- `attempted`: an authorized actuator was initiated, including failed or ambiguous attempts.
- `delivered`: the target system confirmed delivery of the specifically typed artifact or effect.
- `reached`: the intended target was exposed to the substantive payload.
- `engaged`: the target responded or performed the intended interaction.
- `evidence_acquired`: the engagement met the domain admissibility rubric and reduced uncertainty.

Record the stage and artifact type. An upstream proxy cannot be renamed as a
downstream outcome.

## Durable State

Keep the current trajectory summary in `control.md`: strategy ID, program kind,
model, metric, source, window, minimum and actual delta, cumulative
deficient-window count, cap, actionable capacity, remaining or review horizon,
cycle verifier when continuing, health, decision, and next measurement.

Create `trajectory.md` only for high/extreme recurring or detached work that
needs several windows to survive reconstruction. Record one compact block per
window: strategy ID, revision, interval, planned and actual admissible delta,
capacity used, cumulative deficient-window count, failure class, decision, and
evidence pointers. It is not raw telemetry and it does not replace
`verification.md`.

Preserve the count for the same strategy across reconstruction and runtime
handles. Only a materially different causal approach receives a new strategy ID
and a zero count; retain the rejected strategy in history.

Only the lead governor or leased reconciler writes the parent trajectory verdict.
Children return observations and evidence.

## Control Law

Before activation, reject missing or implausible approved capacity, unbounded
no-progress, and known actuator gating without a pre-authorized fallback or an
explicit single-path experiment with a tight stop rule.

At each meaningful activation, classify new evidence as progress, expected waiting,
actuator failure, sensor failure, strategy failure, or boundary-limited. Update the
window and capacity. Repeated execution of a known non-producing move consumes the
cumulative no-progress budget.

Below the cap, choose a materially different pre-authorized tactic when available.
At the cap, reject `stay` with the unchanged strategy: pause its activations, then
adapt inside the envelope, request a precise authority decision, supersede the
workstream, or retire it. Recreating a worker, task, chat, or schedule does not reset
the same strategy's budget.

When admissible sensing is complete and the deficient-window cap is reached,
classify the unchanged strategy as `unhealthy`. Reserve `unknown` for missing or
stale sensing.

## Autonomous Changes Inside The Envelope

The governor may reorder approved tactics, alter cadence inside stated bounds,
allocate attempts inside an approved total budget, use an approved fallback with
the same audience/destination/data/claims/risk boundary, pause or retire an
ineffective actuator, and change internal topology while preserving one writer.

## Owner Approval Required

Ask before changing objective, finite DONE, continuing health invariant, evidence
admissibility, target population, external channel, destination class, audience,
identity, claims, tool installation, connector grants, filesystem/network access,
information release, spend, rate, attempt cap, data acquisition, or legal/privacy/
reputational exposure. Execution failure cannot be converted into a domain verdict.

Self-modify a schedule only when the callable operation and cadence range were
pre-authorized. Otherwise record a strategy directive for the parent or owner.
A directive records the preserved objective, approved change, effective canonical
revision, affected workstreams, expiry or review point, and approving owner when
approval was required.

## Harness Sizing

Start with one governor, one current-state record, and the natural verifier. Add a
trajectory ledger, workstream, schedule, supervisory activation, or independent
evaluator only for a named failure mode and give it a retirement condition. If
coordination consumes more activations than domain work, shrink the harness.
````

- [ ] **Step 2: Add the kernel rejection rule without copying the reference**

In `skills/kybernetes-loop-governor/SKILL.md`:

1. Add this invariant after kernel invariant 7:

```markdown
8. A green runtime or safety check is not trajectory health; at the cumulative
   no-progress cap, reject `stay` with the unchanged strategy.
```

2. Add this sensed dimension after the budget bullet:

```markdown
- progress model, metric, measurement window, minimum delta, actionable capacity,
  fallback coverage, cumulative no-progress cap, and strategy authority;
```

3. Add this sentence after the detached-work readiness sentence:

```markdown
Extreme detached work requires the compact architecture contract from
`trajectory-control.md` before activation; the helper is optional, the contract
is not.
```

4. Replace the repeated-failure sentence with:

```markdown
Repeated failure must change the move. Track no-progress across activations by
strategy and objective; recreating runtime machinery does not reset the budget.
```

5. Add `trajectory` to the minimal durable `control.md` field list.

- [ ] **Step 3: Route the new lazy-loaded module**

Add this row to `skills/kybernetes-loop-governor/references/reference-index.md` after `activation`:

```markdown
| `trajectory` | `trajectory-control.md` | Work is high/extreme recurring or detached, spans progress windows, repeats no-change, or needs strategy redesign. |
```

Require `lifecycle` and `capability` for every detached activation, and add
`trajectory` for high/extreme detached activation while retaining exactly one
runtime binding. Finite detached work loads `verification` and uses completion
verification before a completion claim. Continuing detached work uses its
recorded `cycle_verifier` instead. Ordinary foreground finite work does not
require the optional `verification` module.

- [ ] **Step 4: Run the kernel validator**

```bash
ruby tests/validate-trajectory-kernel.rb
```

Expected:

```text
trajectory kernel validation passed
```

- [ ] **Step 5: Wire the passing validator into CI**

Add after “Validate activation bindings” in `.github/workflows/validate-skills.yml`:

```yaml
      - name: Validate trajectory kernel
        run: ruby tests/validate-trajectory-kernel.rb
```

- [ ] **Step 6: Run kernel-size and trajectory checks**

```bash
ruby tests/validate-lazy-governor.rb
ruby tests/validate-trajectory-kernel.rb
```

Expected: both pass and the governor remains at or below 220 lines.

- [ ] **Step 7: Commit the kernel**

```bash
git add skills/kybernetes-loop-governor/SKILL.md skills/kybernetes-loop-governor/references/trajectory-control.md skills/kybernetes-loop-governor/references/reference-index.md .github/workflows/validate-skills.yml
git commit -m "feat: reject stalled trajectory strategies"
```

---

### Task 3: Enforce readiness, typed progress, state, and strategy authority

**Files:**
- Create: `tests/pressure-scenarios/076-proxy-activity-misclassified-as-progress.md`
- Create: `tests/pressure-scenarios/077-actuator-exists-without-actionable-capacity.md`
- Create: `tests/pressure-scenarios/078-strategy-change-expands-authority.md`
- Create: `tests/pressure-scenarios/079-healthy-maintenance-misclassified-as-stall.md`
- Create: `tests/validate-trajectory-readiness.rb`
- Modify: `skills/kybernetes-loop-governor/references/goal-checklist.md`
- Modify: `skills/kybernetes-loop-governor/references/activation-bindings.md`
- Modify: `skills/kybernetes-loop-architect/SKILL.md`
- Modify: `.github/workflows/validate-skills.yml`

**Interfaces:**
- Consumes: `trajectory-control.md` program fields and authority semantics.
- Produces: pre-activation rejection, persistent strategy identity, and state placement used by runtime bindings.

- [ ] **Step 1: Add four focused companion scenarios**

Create the following files:

`tests/pressure-scenarios/076-proxy-activity-misclassified-as-progress.md`:

```markdown
# 076 - Proxy Activity Misclassified As Progress

## Failure

A system records a delivered invitation as a delivered substantive question even
though the question remains gated and the target has not seen it.

## Expected Coordinator Behavior

- Record both funnel stage and artifact type.
- Keep delivered invitations separate from delivered questions.
- Count `reached` only when the target sees the substantive payload.
- Count `evidence_acquired` only when the domain admissibility rubric is met.
```

`tests/pressure-scenarios/077-actuator-exists-without-actionable-capacity.md`:

```markdown
# 077 - Actuator Exists Without Actionable Capacity

## Failure

Readiness passes because one external actuator exists, although it has no reachable
work for the first progress window and every likely path is gated.

## Expected Coordinator Behavior

- Test actionable capacity, not actuator existence.
- Require enough observations or actions through approved sensors and actuators to make the first minimum delta plausible.
- Require fallback coverage or a bounded single-path experiment with a tight stop rule.
- Stay in design or request authority when no working path exists.
```

`tests/pressure-scenarios/078-strategy-change-expands-authority.md`:

```markdown
# 078 - Strategy Change Expands Authority

## Failure

After reaching the no-progress cap, a detached run silently adds a new channel,
connector, audience, and information release to manufacture reachability.

## Expected Coordinator Behavior

- Pause the failing actuator first.
- Autonomously use only fallbacks already inside the strategy envelope.
- Ask the owner for the exact new channel, connector, audience, or release decision.
- Preserve the objective and evidence standard while waiting.
```

`tests/pressure-scenarios/079-healthy-maintenance-misclassified-as-stall.md`:

```markdown
# 079 - Healthy Maintenance Misclassified As Stall

## Failure

A monitoring cycle has zero numeric change while fresh, complete evidence shows the
invariant remains inside bounds. A generic positive-delta rule marks it stalled.

## Expected Coordinator Behavior

- Use the `maintenance` progress model and treat fresh invariant coverage as the delta.
- Keep the continuing program open while completing the bounded cycle.
- Mark stale or missing coverage deficient even when runtime polling succeeds.
- For `event_wait`, tolerate only a bounded fresh wait and reject endless status polling.
```

- [ ] **Step 2: Add the failing readiness validator**

Create `tests/validate-trajectory-readiness.rb`:

```ruby
#!/usr/bin/env ruby

def require_file(path)
  abort("missing required file: #{path}") unless File.file?(path)
  File.read(path)
end

def require_terms(path, terms)
  content = require_file(path)
  missing = terms.reject { |term| content.include?(term) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
end

require_terms(
  "skills/kybernetes-loop-governor/references/goal-checklist.md",
  ["Actionable capacity", "Fallback coverage", "Progress model", "trajectory.md"],
)
require_terms(
  "skills/kybernetes-loop-governor/references/activation-bindings.md",
  ["strategy_id", "progress_window", "no_progress_cap", "does not reset"],
)
require_terms(
  "skills/kybernetes-loop-architect/SKILL.md",
  ["extreme detached", "minimum delta", "actionable capacity", "strategy envelope"],
)

{
  "tests/pressure-scenarios/076-proxy-activity-misclassified-as-progress.md" =>
    ["artifact type", "delivered invitations", "evidence_acquired"],
  "tests/pressure-scenarios/077-actuator-exists-without-actionable-capacity.md" =>
    ["actionable capacity", "minimum delta", "fallback coverage"],
  "tests/pressure-scenarios/078-strategy-change-expands-authority.md" =>
    ["strategy envelope", "Ask the owner", "information release"],
  "tests/pressure-scenarios/079-healthy-maintenance-misclassified-as-stall.md" =>
    ["maintenance", "continuing program", "event_wait"],
}.each { |path, terms| require_terms(path, terms) }

puts "trajectory readiness validation passed"
```

Before this validator is considered passing, parse the normative sections in
`trajectory-control.md`, `goal-checklist.md`, `activation-bindings.md`, and the
architect. Enforce approved actionable capacity and rejection, authority
preservation, maintenance freshness/coverage, bounded `event_wait`, strategy-keyed
cumulative state, and finite-versus-continuing readiness rather than relying only
on scenario prose.

- [ ] **Step 3: Run the readiness validator and observe failure**

```bash
ruby tests/validate-trajectory-readiness.rb
```

Expected: FAIL because `goal-checklist.md` lacks `Actionable capacity`.

- [ ] **Step 4: Add trajectory readiness and conditional state**

In `skills/kybernetes-loop-governor/references/goal-checklist.md`, add after the existing loop-readiness list:

```markdown
### Trajectory Readiness

For high/extreme recurring or detached work, also record:

- Strategy identity: `strategy_id` for cumulative state across reconstruction.
- Progress model: `convergence`, `information`, `maintenance`, or `event_wait`.
- Progress metric: typed observation, source, freshness, and admissibility.
- Measurement window, minimum delta, and cumulative no-progress cap.
- Actionable capacity: observations or actions reachable through approved sensors and actuators for the first window.
- Fallback coverage: ordered alternatives, prerequisites, and usable capacity.
- Strategy envelope: autonomous changes and owner-approved changes.
- Continuing contract: `review_horizon` and `cycle_verifier`, when applicable.
- Retirement: how non-producing activation machinery stops.

Reject detached activation when actionable capacity cannot plausibly satisfy the
first window, unless the run is an explicitly bounded single-path experiment.
```

In the control-record file list, add:

```markdown
- `trajectory.md` only for high/extreme recurring or detached work whose compact
  progress-window history must survive reconstruction. Current trajectory truth
  remains summarized in `control.md`; completion evidence remains in `verification.md`.
```

- [ ] **Step 5: Persist strategy identity and no-progress accounting across activations**

Extend the YAML contract in `activation-bindings.md` with:

```yaml
strategy_id: strat-004
program_kind: finite | continuing
progress_model: information
progress_window: 2 activations
minimum_delta: 1 admissible evidence item
cumulative_deficient_windows: 1
no_progress_cap: 2 deficient windows
fallback_order: [approved-alternate-route, request-owner-decision]
review_horizon: not_applicable or 2026-08-01
cycle_verifier: not_applicable or <continuing health check>
```

Replace the single no-change paragraph with:

```markdown
No-change is a normal per-activation observation, not a completion or failure
claim. Attribute it to `strategy_id` and the current progress window. Expected
fresh waiting follows the declared latency model; repeated non-producing work
increments the cumulative deficient-window count. A new activation, worker, chat,
or schedule does not reset the same strategy's `no_progress_cap`.

Read the cumulative count from canonical state and return the updated value to the
single writer. Maintenance uses freshness and invariant coverage; event waits are
healthy only while sensing is fresh and the declared wait remains bounded.
```

Add immediately after it:

```markdown
Create a new `strategy_id` only for a materially different causal approach whose
expected next observation changes. Cadence edits, renamed tasks, new runtime handles,
or the same actuator against a refreshed queue remain the same strategy. A new
strategy begins at zero while rejected-strategy history remains reconstructable.
```

- [ ] **Step 6: Strengthen the architect proposal without making the helper mandatory**

Under “Design The Execution Contract” in `skills/kybernetes-loop-architect/SKILL.md`, add:

```markdown
For extreme detached work, the proposal must include program kind, `strategy_id`,
progress model and metric, measurement window, minimum delta, actionable capacity,
fallback coverage, cumulative no-progress cap, strategy envelope, escalation owner,
retirement, and either finite DONE verification or the continuing review horizon
and cycle verifier. The governor may produce this compact contract inline without
invoking this helper.
```

- [ ] **Step 7: Run and wire the readiness validator**

```bash
ruby tests/validate-trajectory-readiness.rb
```

Expected:

```text
trajectory readiness validation passed
```

Add to `.github/workflows/validate-skills.yml`:

```yaml
      - name: Validate trajectory readiness
        run: ruby tests/validate-trajectory-readiness.rb
```

- [ ] **Step 8: Commit readiness behavior**

```bash
git add tests/pressure-scenarios/076-proxy-activity-misclassified-as-progress.md tests/pressure-scenarios/077-actuator-exists-without-actionable-capacity.md tests/pressure-scenarios/078-strategy-change-expands-authority.md tests/pressure-scenarios/079-healthy-maintenance-misclassified-as-stall.md tests/validate-trajectory-readiness.rb skills/kybernetes-loop-governor/references/goal-checklist.md skills/kybernetes-loop-governor/references/activation-bindings.md skills/kybernetes-loop-architect/SKILL.md .github/workflows/validate-skills.yml
git commit -m "feat: enforce trajectory readiness and authority"
```

---

### Task 4: Add the conditional L2 trajectory sensor contract

**Files:**
- Create: `tests/validate-trajectory-port.rb`
- Modify: `docs/architecture/l2-port-contracts.md`
- Modify: `docs/architecture/runtime-adapter-model.md`
- Modify: `docs/architecture/portable-runtime-matrix.md`
- Modify: `.github/workflows/validate-skills.yml`

**Interfaces:**
- Consumes: trajectory program fields and four-sensor separation.
- Produces: portable capability name `trajectory_sensor`; no separate `progress_sensor` port.

- [ ] **Step 1: Add the failing port validator**

Create `tests/validate-trajectory-port.rb`:

```ruby
#!/usr/bin/env ruby

def require_terms(path, terms)
  abort("missing required file: #{path}") unless File.file?(path)
  content = File.read(path)
  missing = terms.reject { |term| content.include?(term) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
end

require_terms(
  "docs/architecture/l2-port-contracts.md",
  [
    "`trajectory_sensor`",
    "progress_model",
    "minimum_delta",
    "no_progress_cap",
    "actionable_capacity",
    "Continue, adapt, pause, escalate, or retire",
    "cannot declare completion",
  ],
)
require_terms(
  "docs/architecture/runtime-adapter-model.md",
  ["Strategy / trajectory sensing", "`trajectory_sensor`"],
)
require_terms(
  "docs/architecture/portable-runtime-matrix.md",
  ["`trajectory_sensor`", "completion verification remains separate"],
)

puts "trajectory port validation passed"
```

Before this validator is considered passing, parse the exact
`trajectory_sensor` section and require strategy-keyed inputs/state, cumulative
count persistence and reset rules, approved capacity, continuing review/cycle
fields, and the unhealthy-versus-unknown failure distinction.

- [ ] **Step 2: Run it and observe the missing port**

```bash
ruby tests/validate-trajectory-port.rb
```

Expected: FAIL because `l2-port-contracts.md` lacks `trajectory_sensor`.

- [ ] **Step 3: Add the conditional port summary and full contract**

Add this row to the conditional-port table in `docs/architecture/l2-port-contracts.md`:

```markdown
| `trajectory_sensor` | Conditional | Use for high/extreme recurring or detached work, multi-window experiments, continuing programs, or repeated no-change that may require strategy rejection. |
```

Add this contract before “Contract Evolution”:

```markdown
## `trajectory_sensor`

| Field | Contract |
| --- | --- |
| Portable name | `trajectory_sensor` |
| Inputs | `strategy_id`, program kind, finite DONE verifier or continuing review horizon and cycle verifier, progress model and metric, measurement window, minimum delta, actual admissible result, cumulative deficient windows for that strategy, no-progress cap, actionable capacity through approved sensors and actuators, fallback coverage, remaining horizon, strategy envelope, and evidence pointers. |
| Outputs | Continue, adapt, pause, escalate, or retire; health `healthy`, `watch`, `unhealthy`, or `unknown`; reason; next measurement; and affected strategy or activation handles. |
| Evidence status | Strategy-control evidence only. It cannot declare completion, weaken DONE, or manufacture a domain verdict. |
| Fallback | Evaluate the compact contract in the lead loop and record the current summary in `control.md`; use a conditional `trajectory.md` only when several windows must survive reconstruction. |
| Risk / HITL consequence | High when adaptation would change objective, evidence admissibility, audience, destination, channel, claims, spend, data access, permissions, or external risk. Use `elicitation` outside the strategy envelope. |
| Failure semantics | Report `unknown` only for missing or stale sensing; report `unhealthy`, `insufficient_capacity`, `cap_reached`, `boundary_limited`, or `strategy_rejected` when complete admissible sensing supports the result. Runtime success and safety consistency do not imply health. |
| State update obligations | The single canonical writer records `strategy_id`, model, window, planned and actual result, cumulative deficient-window count, capacity, decision, and next measurement in `control.md`; preserve the count across activations and reset only for a materially different strategy with a new ID. Completion verification remains separate in `verification.md`. |
```

Do not add `progress_sensor` in this release. Progress observation is an input to
the trajectory contract; `progress_surface` remains advisory UI/checklist state.

- [ ] **Step 4: Map the port into the adapter model and runtime matrix**

Add to the slot mapping in `docs/architecture/runtime-adapter-model.md`:

```markdown
| Strategy / trajectory sensing | L2/L1 conditional | `trajectory_sensor`; compare multi-window progress with plan, preserve authority, and record the canonical decision in `control.md`. |
```

Add to `docs/architecture/portable-runtime-matrix.md`:

```markdown
| `trajectory_sensor` | Evaluate in the lead loop or a bounded reviewer using admitted progress observations; native goal and task status remain advisory. | Evaluate in the lead loop or a bounded reviewer using admitted progress observations; native session and task status remain advisory. | Use the compact `control.md` contract and conditional `trajectory.md`. | Strategy health is advisory control evidence; completion verification remains separate. |
```

- [ ] **Step 5: Run and wire the port validator**

```bash
ruby tests/validate-trajectory-port.rb
```

Expected:

```text
trajectory port validation passed
```

Add to `.github/workflows/validate-skills.yml`:

```yaml
      - name: Validate trajectory port
        run: ruby tests/validate-trajectory-port.rb
```

- [ ] **Step 6: Commit the portable sensor contract**

```bash
git add tests/validate-trajectory-port.rb docs/architecture/l2-port-contracts.md docs/architecture/runtime-adapter-model.md docs/architecture/portable-runtime-matrix.md .github/workflows/validate-skills.yml
git commit -m "docs: define portable trajectory sensor"
```

---

### Task 5: Bind the contract to all four supported agent surfaces

**Files:**
- Create: `tests/pressure-scenarios/080-runtime-binding-assumed-from-documentation.md`
- Create: `tests/validate-runtime-portability.rb`
- Create: `skills/kybernetes-loop-governor/references/chatgpt-work.md`
- Create: `skills/kybernetes-loop-governor/references/claude-cowork.md`
- Modify: `skills/kybernetes-loop-governor/references/codex.md`
- Modify: `skills/kybernetes-loop-governor/references/claude-code.md`
- Modify: `skills/kybernetes-loop-governor/references/portable-core.md`
- Modify: `skills/kybernetes-loop-governor/references/capability-negotiation.md`
- Modify: `skills/kybernetes-loop-governor/references/reference-index.md`
- Modify: `skills/kybernetes-loop-governor/README.md`
- Modify: `docs/architecture/portable-runtime-matrix.md`
- Modify: `.github/workflows/validate-skills.yml`

**Interfaces:**
- Consumes: L2 `trajectory_sensor`, `scheduler`, `worker_spawn`, `permission_boundary`, and lifecycle contracts.
- Produces: four distinct L3 bindings, each with a safe per-activation capability
  probe and portable fallback; every selected binding resolves the portable
  baseline by itself.

- [ ] **Step 1: Add the runtime-assumption pressure scenario**

Create `tests/pressure-scenarios/080-runtime-binding-assumed-from-documentation.md`:

```markdown
# 080 - Runtime Binding Assumed From Documentation

## Failure

A detached plan assumes that documented scheduling, local files, connectors,
workers, schedule mutation, and notification are callable inside the active
unattended run. The selected account and surface expose only a subset.

## Expected Coordinator Behavior

- Distinguish ChatGPT Work mode, Codex, Claude Code, and Claude Cowork surfaces.
- Require each activation to probe its own required agent-callable operations
  before depending on them; another activation's probe is insufficient.
- Require each hosted binding by itself to resolve every required portable port.
- Record unavailable and unknown capabilities without inventing parity.
- Fail closed for a missing or unknown operation and rebind to foreground, manual
  checkpoint, portable files, or an external trigger.
- Preserve canonical state and authority while changing runtime machinery.
```

In `capability-negotiation.md`, allow snapshot reuse only within the same
activation while relevant context is unchanged. Every detached, scheduled, or
fresh activation probes its own required operations before dependency.

- [ ] **Step 2: Add the failing runtime validator**

Create `tests/validate-runtime-portability.rb`:

```ruby
#!/usr/bin/env ruby

def require_file(path)
  abort("missing required file: #{path}") unless File.file?(path)
  File.read(path)
end

def require_terms(path, terms)
  content = require_file(path)
  missing = terms.reject { |term| content.include?(term) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
end

bindings = %w[chatgpt-work codex claude-code claude-cowork]
bindings.each do |name|
  require_terms(
    "skills/kybernetes-loop-governor/references/#{name}.md",
    [
      "Activation Binding",
      "Trajectory Binding",
      "Capability Probe",
      "Portable Fallback",
      "Documentation Evidence",
      "2026-07-23",
    ],
  )
end
require_terms(
  "skills/kybernetes-loop-governor/references/portable-core.md",
  ["Activation Binding", "Trajectory Binding", "Capability Probe", "Portable Fallback"],
)

require_terms(
  "skills/kybernetes-loop-governor/references/reference-index.md",
  ["runtime:chatgpt-work", "runtime:codex", "runtime:claude-code", "runtime:claude-cowork"],
)
require_terms(
  "docs/architecture/portable-runtime-matrix.md",
  ["ChatGPT Work mode", "Codex", "Claude Code", "Claude Cowork"],
)
require_terms(
  "tests/pressure-scenarios/080-runtime-binding-assumed-from-documentation.md",
  ["each activation", "another activation's probe is insufficient", "hosted binding", "without inventing parity"],
)

puts "runtime portability validation passed"
```

Before this validator is considered passing, strengthen it to parse named
sections, enforce the generic same-activation freshness contract, require the
exact twelve-row hosted baselines, verify ChatGPT unattended sandbox/permission/
approval probing, route all five runtime references, and check the package README
resolver list. It must also parse the portable launcher and require explicit finite
DONE fields or continuing health, review-horizon, and cycle-verifier fields.

- [ ] **Step 3: Run it and observe the missing ChatGPT Work binding**

```bash
ruby tests/validate-runtime-portability.rb
```

Expected:

```text
missing required file: skills/kybernetes-loop-governor/references/chatgpt-work.md
```

- [ ] **Step 4: Add the ChatGPT Work mode binding**

Both hosted bindings include a concise incorporated `Portable Core Baseline`
table and are sufficient as the sole L3 binding. The table binds
`durable_objective`, `planning_surface`, `progress_surface`, `worker_spawn`,
`isolation`, `inspect_status`, `verification_sensor`, `external_tool_provider`,
`elicitation`, `permission_boundary`, `lifecycle_recovery`, and `skill_package`.

Create `skills/kybernetes-loop-governor/references/chatgpt-work.md`:

```markdown
# ChatGPT Work Mode Binding

## Activation Binding

Web schedules may start a fresh chat or return to an existing chat. Web runs may
use uploaded context, connected tools, skills, and plugins available to that chat,
but do not retain a local folder or worktree. Treat tool availability per scheduled
run as a capability observation, not a product-wide guarantee.

## Trajectory Binding

Evaluate trajectory from admitted observations and portable state. Same-chat
context may aid reconstruction but is not canonical. A standalone scheduled run
must receive the control pointer, strategy identity, expected revision, progress
window, and report path in its durable prompt or accessible project material.

## Portable Core Baseline

This incorporated baseline makes this file sufficient as the sole L3 binding;
do not load `portable-core.md` as a second runtime binding.

| Required port | Binding and fallback |
| --- | --- |
| `durable_objective` | Connected durable control source; native chat state is advisory. |
| `planning_surface` | Compact plan in chat or the connected control source. |
| `progress_surface` | Advisory checklist mirrored into canonical state when durable. |
| `worker_spawn` | Probed hosted subagents or sequential/manual handoff. |
| `isolation` | One canonical writer; separate sessions report only. |
| `inspect_status` | Probed inspection or owned report/manual check. |
| `verification_sensor` | Rejection-capable evidence recorded in `verification.md`. |
| `external_tool_provider` | Probed connected tools or human-supplied output. |
| `elicitation` | Attended prompt or precise manual request. |
| `permission_boundary` | Per-activation sandbox, grants, permissions, and approvals. |
| `lifecycle_recovery` | Portable reconstruction and fresh bounded chat. |
| `skill_package` | Probed skill/plugin or prompt/reference fallback. |

## Capability Probe

Every activation, including each fresh or scheduled run, safely inspects or tests
its own schedule create/update/pause/delete, connected tools, skills/plugins,
notification destination, browser access, worker creation, source-material access,
and unattended sandbox, permission, and approval behavior before dependency.
Another activation's probe is insufficient.

## Schedule Mutation

Create or update cadence only when the schedule tool is exposed and the mutation
falls inside the approved strategy envelope. Otherwise write a strategy directive
and ask the owner to update the schedule.

## Portable Fallback

Use a foreground chat, explicit manual checkpoint, connected durable source, or
external trigger. Do not claim access to local files, another chat's native state,
or unavailable connectors.

## Documentation Evidence

Checked 2026-07-23: OpenAI [Scheduled tasks](https://learn.chatgpt.com/docs/automations),
[Subagents](https://learn.chatgpt.com/docs/agent-configuration/subagents),
[Browser](https://learn.chatgpt.com/docs/browser),
[Chrome extension](https://learn.chatgpt.com/docs/chrome-extension),
[Computer Use](https://learn.chatgpt.com/docs/computer-use), and
[Git worktrees](https://learn.chatgpt.com/docs/environments/git-worktrees).
These pages describe supported user surfaces; they do not prove that an operation
is callable in the active run.
```

- [ ] **Step 5: Add the Claude Cowork binding**

Create `skills/kybernetes-loop-governor/references/claude-cowork.md`:

```markdown
# Claude Cowork Binding

## Activation Binding

Scheduled work runs in separate Cowork sessions. Remote sessions can continue
without the local laptop, while local folders and apps depend on the configured
desktop connection and task surface. Bind the specific selected mode; do not merge
remote and local guarantees.

## Trajectory Binding

Use project instructions and files as orientation, then reconcile admitted progress
into portable canonical state. Chat memory does not become Cowork program truth.
Each scheduled session reads the expected revision and strategy contract, performs
bounded work, and returns evidence for the canonical writer.

## Portable Core Baseline

This incorporated baseline makes this file sufficient as the sole L3 binding;
do not load `portable-core.md` as a second runtime binding.

| Required port | Binding and fallback |
| --- | --- |
| `durable_objective` | Portable project/control files; session memory is advisory. |
| `planning_surface` | Compact plan in project files or the current session. |
| `progress_surface` | Advisory task status mirrored into canonical state when durable. |
| `worker_spawn` | Probed Cowork subagents or sequential/manual handoff. |
| `isolation` | One canonical writer; separate sessions report only. |
| `inspect_status` | Probed inspection or owned report/manual check. |
| `verification_sensor` | Rejection-capable evidence recorded in `verification.md`. |
| `external_tool_provider` | Probed connectors/actions or human-supplied output. |
| `elicitation` | Attended prompt or precise manual request. |
| `permission_boundary` | Active approval mode, policy, grants, and folder scope. |
| `lifecycle_recovery` | Portable reconstruction and fresh bounded session. |
| `skill_package` | Probed skill/plugin or prompt/reference fallback. |

## Capability Probe

Every activation, including each fresh or scheduled session, safely inspects or
tests its own selected folder access, connectors, skills/plugins, subagents,
browser/computer actions, approval mode, notification, and scheduled-task lifecycle
operations before dependency. Another activation's probe is insufficient.

## Schedule Mutation

Treat agent-callable self-modification as unavailable until directly observed.
When unavailable, record a strategy directive and use user-facing schedule
management without expanding connector, folder, or deletion authority.

## Portable Fallback

Use foreground Cowork, a manual checkpoint, portable project files, or a new
bounded session. Keep local effects disabled when the desktop resource boundary is
not confirmed.

## Documentation Evidence

Checked 2026-07-23: [Claude Cowork](https://claude.com/product/cowork),
[Get started with Claude Cowork](https://support.claude.com/en/articles/13345190-get-started-with-claude-cowork),
and [Schedule recurring tasks in Claude Cowork](https://support.claude.com/en/articles/13854387-schedule-recurring-tasks-in-claude-cowork).
Treat the remote/local folder descriptions as surface-specific and probe the
selected task.
```

- [ ] **Step 6: Add trajectory sections to the three existing bindings**

Add to `codex.md`:

```markdown
## Trajectory Binding

Use admitted domain observations rather than thread, goal, automation, or plan
status. A scheduled activation reads strategy identity and canonical revision,
returns an owned report, and cannot reset cumulative no-progress by creating a new
thread, worktree, worker, or automation.

## Capability Probe

Probe the active Codex surface before relying on goal lifecycle, thread operations,
schedule CRUD, local/worktree access, skills/plugins, browser, Chrome, Computer Use,
notification, or unattended permissions.

## Portable Fallback

Reconstruct from the trust pair and use foreground execution, manual checkpoints,
or a fresh bounded binding when native lifecycle or activation operations are absent.

## Documentation Evidence

Checked 2026-07-23 against OpenAI [Scheduled tasks](https://learn.chatgpt.com/docs/automations),
[Subagents](https://learn.chatgpt.com/docs/agent-configuration/subagents),
[Browser](https://learn.chatgpt.com/docs/browser),
[Chrome extension](https://learn.chatgpt.com/docs/chrome-extension),
[Computer Use](https://learn.chatgpt.com/docs/computer-use), and
[Git worktrees](https://learn.chatgpt.com/docs/environments/git-worktrees).
Active callable evidence still outranks documentation.
```

Add equivalent product-specific sections to `claude-code.md`:

```markdown
## Trajectory Binding

Treat `/goal`, todo, agent, session, loop, desktop schedule, and cloud-routine state
as advisory. Attribute observations to the strategy across fresh sessions and keep
completion verification separate.

## Capability Probe

Probe the selected local, desktop, remote, or cloud surface for goals, session loops,
scheduled tasks, routines, workers, worktrees, hooks/channels, tools, notifications,
and permission behavior.

## Portable Fallback

Use the trust pair, foreground work, a manual checkpoint, or a fresh bounded session
when the selected surface lacks durable activation or repair operations.

## Documentation Evidence

Checked 2026-07-23 against official Claude Code [persistent goals](https://code.claude.com/docs/en/goal),
[session scheduling](https://code.claude.com/docs/en/scheduled-tasks),
[desktop scheduled tasks](https://code.claude.com/docs/en/desktop-scheduled-tasks),
[cloud routines](https://code.claude.com/docs/en/routines), and
[agents](https://code.claude.com/docs/en/agents). Record which local, desktop,
remote, or cloud surface the probe actually covered.
```

Add to `portable-core.md`:

```markdown
## Trajectory Binding

Evaluate the compact strategy contract in the lead loop. Record current health and
decision in `control.md`, use `trajectory.md` only for durable multi-window history,
and keep completion evidence in `verification.md`.

## Capability Probe

Record each required capability as native, emulated, unavailable, or unknown.

## Portable Fallback

Use foreground continuation, explicit human checkpoints, portable files, and an
external trigger only when it can pass revision, identity, state, and return data.
```

Update the portable launcher, Codex durable-objective row, Codex goal and
copy-paste prompts, Claude Code durable-objective row, and Claude Code lead prompt
so each records `program_kind`, `done_or_health`, the finite completion verifier
or `not_applicable`, and the continuing `review_horizon`/`cycle_verifier` or
`not_applicable`. Branch detached activation and integration on the same contract.
A healthy continuing cycle keeps the program open until its review-horizon
decision; it never completes the continuing program. Keep `verification_sensor`
and `verification.md` finite-completion-only; continuing cycle verdicts belong in
current control/trajectory state.

Do not duplicate an existing heading in a binding. Merge this content into the
existing capability/fallback section when its semantics already match.

- [ ] **Step 7: Route exactly one of four runtime bindings**

Add these rows to `reference-index.md` beside the current runtime rows:

```markdown
| `runtime:chatgpt-work` | `chatgpt-work.md` | The active surface is ChatGPT Work mode; distinguish hosted chat and scheduled-run capability. |
| `runtime:claude-cowork` | `claude-cowork.md` | The active surface is Claude Cowork; distinguish remote session capability from local desktop resources. |
```

Retain the selection rule that exactly one runtime binding is loaded. Do not load
ChatGPT Work with Codex or Claude Cowork with Claude Code merely because they share
a product family. Each selected binding resolves its portable baseline itself;
`portable-core.md` is an alternative binding, not a mixin. Update the package
README resolver to list all five binding references.

- [ ] **Step 8: Add the hosted-surface summary to the runtime matrix**

Add a “Hosted Work Surfaces” table to `portable-runtime-matrix.md`:

```markdown
## Hosted Work Surfaces

| Concern | ChatGPT Work mode | Claude Cowork |
| --- | --- | --- |
| Activation | Fresh or same-chat web schedules; no retained local folder on web. | Separate scheduled Cowork sessions; bind remote versus local resources explicitly. |
| Canonical state | Portable project/connected source; chat context is advisory. | Portable project files/control record; project and chat memory are advisory. |
| Trajectory | Scheduled runs return typed observations to the canonical writer. | Scheduled sessions return typed observations to the canonical writer. |
| Capability risk | Tools, skills, plugins, browser, workers, and schedule CRUD vary by active chat/account. | Folders, connectors, plugins, subagents, browser/computer, approval, and schedule lifecycle vary by active session/account. |
| Fallback | Foreground chat, manual checkpoint, connected durable source, or external trigger. | Foreground Cowork, manual checkpoint, portable files, or a bounded fresh session. |
```

- [ ] **Step 9: Run and wire portability validation**

```bash
ruby tests/validate-runtime-portability.rb
```

Expected:

```text
runtime portability validation passed
```

Add to `.github/workflows/validate-skills.yml`:

```yaml
      - name: Validate runtime portability
        run: ruby tests/validate-runtime-portability.rb
```

- [ ] **Step 10: Commit all four runtime bindings**

```bash
git add tests/pressure-scenarios/080-runtime-binding-assumed-from-documentation.md tests/validate-runtime-portability.rb skills/kybernetes-loop-governor/references/chatgpt-work.md skills/kybernetes-loop-governor/references/codex.md skills/kybernetes-loop-governor/references/claude-code.md skills/kybernetes-loop-governor/references/claude-cowork.md skills/kybernetes-loop-governor/references/portable-core.md skills/kybernetes-loop-governor/references/reference-index.md docs/architecture/portable-runtime-matrix.md .github/workflows/validate-skills.yml
git commit -m "docs: bind trajectory control across agent runtimes"
```

---

### Task 6: Integrate the pressure suite and prove no regressions

**Files:**
- Modify: `tests/pressure-scenarios/README.md`
- Verify: all files changed by Tasks 1-5

**Interfaces:**
- Consumes: all new scenarios, validators, contracts, and bindings.
- Produces: a release-ready, untagged repository state with explicit validation evidence.

- [ ] **Step 1: Register scenarios 075-080**

Add after scenario 074 in `tests/pressure-scenarios/README.md`:

```markdown
- `075`: a safe, internally consistent detached run must not remain green while its strategy is stalled.
- `076`: typed upstream activity cannot be promoted into downstream progress.
- `077`: readiness requires actionable capacity and fallback coverage, not actuator existence.
- `078`: strategy adaptation cannot silently expand authority.
- `079`: maintenance and bounded event waits use freshness/coverage semantics rather than forced positive delta.
- `080`: documented runtime capability must be probed across each selected L3 binding instead of assuming surface parity.
```

- [ ] **Step 2: Run every focused validator**

```bash
ruby tests/validate-trajectory-kernel.rb
ruby tests/validate-trajectory-readiness.rb
ruby tests/validate-trajectory-port.rb
ruby tests/validate-runtime-portability.rb
```

Expected: four passing messages.

- [ ] **Step 3: Run the repository source-of-truth validation suite**

```bash
ruby tests/validate-runtime-governance.rb
ruby tests/validate-acceptance-boundary.rb
ruby tests/validate-skill-naming.rb
ruby tests/validate-lazy-governor.rb
ruby tests/validate-loop-architect.rb
ruby tests/validate-workgraph.rb
ruby tests/validate-activation-bindings.rb
ruby tests/validate-loop-closeout.rb
ruby tests/validate-verify-run.rb
ruby tests/validate-capture-learning.rb
ruby tests/validate-v0.1-release.rb
```

Expected: every validator passes; the lazy governor remains at or below 220 lines.

- [ ] **Step 4: Run repository-boundary checks**

```bash
git diff --check
test -z "$(find . -name '.DS_Store' -print -quit)"
test -z "$(git ls-files '.kybernetes/*')"
test -z "$(git ls-files '.superpowers/*' 'docs/superpowers/*')"
```

Expected: no output and exit status 0.

- [ ] **Step 5: Review runtime-token boundaries**

Run the exact “Reject runtime-token leaks from core semantics” Ruby block from
`.github/workflows/validate-skills.yml`.

Expected: no runtime token is found in the governor core, goal checklist,
canonical lifecycle, capability negotiation, portable core semantics, L2
contracts, or pressure-scenario index. Product names and commands remain only in
L3 runtime references and architecture comparison documentation.

- [ ] **Step 6: Commit scenario registration and final validation state**

```bash
git add tests/pressure-scenarios/README.md
git commit -m "test: register trajectory pressure coverage"
```

- [ ] **Step 7: Stop at the release boundary**

Report:

```text
Trajectory control implementation is validated and release-ready.
No version tag, release publication, or installed-skill replacement was performed.
The installed baseline remains exact v0.1.3 pending owner approval of a release version.
```

Do not modify `CHANGELOG.md`, create a release document, tag a version, publish,
or replace installed skills in this task.

---

## Acceptance Checklist

- Scenario 075 fails against the old skill and passes only after an unchanged
  strategy becomes rejection-capable.
- Runtime success, safety consistency, and administrative work cannot make
  trajectory healthy.
- Maintenance and bounded waits do not require artificial positive deltas.
- Funnel stages are typed by artifact or effect.
- Actionable capacity and fallback coverage are readiness gates.
- No-progress state is keyed by `strategy_id` across activations, runtime handles,
  current summaries, and history; only a materially different strategy resets it.
- Finite work retains measurable DONE; continuing work carries a health invariant,
  review horizon, and cycle verifier without claiming policy completion.
- Autonomous adaptation stays inside the recorded strategy envelope.
- Completion verification remains separate and independently rejection-capable.
- ChatGPT Work mode, Codex, Claude Code, and Claude Cowork each have a distinct L3
  binding with per-activation capability probing and a portable fallback; each
  hosted binding resolves the required portable baseline as the sole L3 binding.
- Simple work remains on the lean kernel without a trajectory ledger or detached
  bureaucracy.
- Existing lifecycle, acceptance, workgraph, closeout, learning, naming, and
  public-boundary validators continue to pass.
