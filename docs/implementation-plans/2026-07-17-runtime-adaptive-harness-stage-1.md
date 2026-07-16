# Runtime-Adaptive Harness Stage 1 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use
> `superpowers:subagent-driven-development` (recommended) or
> `superpowers:executing-plans` to implement this plan task-by-task. Steps use
> checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make Kybernetes own a portable canonical lifecycle, prevent recoverable
waits from becoming native terminal failures, and negotiate runtime capabilities
from the active callable surface rather than documentation assumptions.

**Architecture:** Add two runtime-neutral references: one owns lifecycle states,
transition and mirroring laws, and divergence recovery; the other owns capability
snapshots, safe probes, drift detection, and fallback selection. Keep runtime
commands in L3 binding files, add executable policy validation, and pressure-test
the Codex deadlock and documentation-parity failures before updating examples.

**Tech Stack:** Markdown Agent Skills, Ruby policy validation, shell-based GitHub
Actions, Kybernetes L0/L1/L2/L3 architecture.

## Global Constraints

- Work only on branch `codex/runtime-adaptive-harness-stage-1`, created from the
  latest fetched `origin/main`.
- Do not create or commit `.superpowers/` or `docs/superpowers/`.
- Every installable skill frontmatter name must use `kybernetes:<skill-name>`.
- Stage 1 does not create `kybernetes:loop-architect`,
  `kybernetes:loop-closeout`, `kybernetes:verify-run`, or
  `kybernetes:capture-learning` skill folders.
- `control.md` and `verification.md` remain the canonical trust pair.
- Runtime-specific commands and availability claims stay in L3 binding files.
- Add pressure evidence before changing skill behavior.
- Preserve portable fallback behavior when a native lifecycle transition is
  unavailable.

## File Map

| File | Responsibility |
| --- | --- |
| `skills/kybernetes-loop-governor/references/canonical-lifecycle.md` | Portable lifecycle states, transition constraints, native mirroring law, and divergence recovery. |
| `skills/kybernetes-loop-governor/references/capability-negotiation.md` | Capability snapshot, evidence classes, probe policy, refresh triggers, and binding selection. |
| `tests/validate-runtime-governance.rb` | Deterministic enforcement of lifecycle and capability invariants. |
| `tests/pressure-scenarios/030-recoverable-wait-native-goal-deadlock.md` | Recoverable HITL wait mapped to terminal native blocked. |
| `tests/pressure-scenarios/031-documentation-callable-surface-drift.md` | Documentation parity incorrectly treated as callable capability. |
| `tests/pressure-scenarios/032-runtime-canonical-divergence.md` | Stale native state and fresh-binding migration. |
| `skills/kybernetes-loop-governor/SKILL.md` | Routes durable runs to the new references without L3 vocabulary. |
| `skills/kybernetes-loop-governor/references/goal-checklist.md` | Canonical lifecycle and capability snapshot fields. |
| `skills/kybernetes-loop-governor/references/runtime-use-rubric.md` | Capability negotiation before consequential runtime binding. |
| `skills/kybernetes-loop-governor/references/{codex,claude-code,portable-core}.md` | L3 mappings and portable fallback. |
| `docs/architecture/{l2-port-contracts,runtime-adapter-model,portable-runtime-matrix}.md` | Cross-runtime contracts and matrix. |
| `docs/product/capability-model.md` | Product abilities. |
| `examples/{codex-goal-run,portable-run}/control.md` | Lifecycle and snapshot examples. |
| `.github/workflows/validate-skills.yml` | CI invocation of deterministic governance validation. |

---

### Task 1: Canonical Lifecycle And Native Mirroring Law

**Files:**
- Create: `tests/pressure-scenarios/030-recoverable-wait-native-goal-deadlock.md`
- Create: `skills/kybernetes-loop-governor/references/canonical-lifecycle.md`
- Create: `tests/validate-runtime-governance.rb`
- Modify: `tests/pressure-scenarios/README.md`
- Modify: `skills/kybernetes-loop-governor/SKILL.md`
- Modify: `skills/kybernetes-loop-governor/references/goal-checklist.md`
- Modify: `.github/workflows/validate-skills.yml`

**Interfaces:**
- Consumes: existing L1 trust pair and `lifecycle_recovery` L2 port.
- Produces: canonical state vocabulary, native terminal mirroring predicate, and
  executable `ruby tests/validate-runtime-governance.rb` check.

- [ ] **Step 1: Write pressure scenario 030 before changing behavior**

Create `tests/pressure-scenarios/030-recoverable-wait-native-goal-deadlock.md`:

~~~markdown
# 030 - Recoverable Wait Must Not Become Native Terminal Blocked

## Failure

A durable run pauses for human input. The runtime exposes only terminal
`complete` and `blocked` writes, so the agent marks the recoverable wait
`blocked`. After the human answers, the native goal remains blocked and
unfinished and prevents replacement or continuation.

## Pressure Prompt

Use `$kybernetes:loop-governor` for a durable task. The next action requires my
approval. The active runtime can read and create a goal, but the only status
writes exposed to the agent are complete and blocked. Pause safely and explain
how the run resumes after I answer.

## Expected Coordinator Behavior

- Record `waiting_human` in canonical state and name the approval that unlocks
  the next action.
- Do not mirror the wait into native terminal `blocked`.
- Leave the native objective active or advisory when no safe pause exists.
- Resume from `control.md` and `verification.md` after the answer.
- Use native `blocked` only for canonical `blocked_terminal` with recorded proof
  that no known answer, time, event, retry, fallback, or safe migration can
  resume the current objective.

## Boundary Failures To Reject

- Treating HITL, time, event, provider backoff, or missing tools as terminal.
- Assuming documentation exposes pause, resume, clear, or unblock to the agent.
- Claiming native goal state is canonical.
~~~

- [ ] **Step 2: Register scenario 030**

Add under `New Acceptance-Aligned Scenarios`:

~~~markdown
- `030`: canonical lifecycle; recoverable human, time, event, pause,
  verification, and recovery waits must not become native terminal blocked.
~~~

Add under `Boundary Failure Coverage`:

~~~markdown
- Recoverable waits being mirrored into an irreversible native terminal state.
~~~

- [ ] **Step 3: Write a validator that fails before the policy exists**

Create `tests/validate-runtime-governance.rb`:

~~~ruby
#!/usr/bin/env ruby

def require_file(path)
  abort("missing required file: #{path}") unless File.file?(path)
  File.read(path)
end

def require_terms(path, content, terms)
  missing = terms.reject { |term| content.include?(term) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
end

lifecycle_path =
  "skills/kybernetes-loop-governor/references/canonical-lifecycle.md"
lifecycle = require_file(lifecycle_path)

states = %w[
  designing active waiting_human waiting_time waiting_event paused verifying
  recovering blocked_terminal superseded completed
]

require_terms(lifecycle_path, lifecycle, states)
require_terms(
  lifecycle_path,
  lifecycle,
  [
    "MUST NOT mirror",
    "canonical_state == blocked_terminal",
    "canonical_state == completed",
    "control.md",
    "verification.md",
  ],
)

puts "runtime governance validation passed"
~~~

- [ ] **Step 4: Run the validator and confirm the missing-policy failure**

Run:

~~~bash
ruby tests/validate-runtime-governance.rb
~~~

Expected: non-zero exit naming missing `canonical-lifecycle.md`.

- [ ] **Step 5: Implement the portable lifecycle reference**

Create `skills/kybernetes-loop-governor/references/canonical-lifecycle.md` with
this content:

~~~markdown
# Canonical Lifecycle

Use this reference for durable runs, waits, terminal status writes, runtime
divergence, and migration. Kybernetes state is canonical. Native goal, thread,
task, hook, scheduler, worker, and progress state is advisory.

## States

| State | Meaning | Recoverable |
| --- | --- | --- |
| `designing` | Objective, verifier, boundary, or harness is still being established. | yes |
| `active` | The governor may select and perform the next bounded action. | yes |
| `waiting_human` | A named human answer, approval, or judgment is required. | yes |
| `waiting_time` | Work resumes at a recorded time or cadence. | yes |
| `waiting_event` | Work resumes when a recorded external event becomes admissible. | yes |
| `paused` | The owner deliberately suspended execution without ending the objective. | yes |
| `verifying` | Candidate output exists but DONE has not been admitted. | yes |
| `recovering` | Canonical and runtime state are being reconciled or migrated. | yes |
| `blocked_terminal` | No known answer, time, event, retry, fallback, or safe migration can resume the objective. | no |
| `superseded` | A new objective or canonical program replaced this run. | no |
| `completed` | DONE is supported by evidence recorded in `verification.md`. | no |

## Transition Constraints

- Recoverable states may return to `active`, move to another recoverable state,
  enter `verifying` or `recovering`, or become `superseded`.
- `completed` and `superseded` are terminal.
- `blocked_terminal` may become `superseded`; it does not resume as the same
  objective.
- A transition to `completed` requires admissible evidence in `verification.md`.
- A transition to `blocked_terminal` requires terminal-block proof in
  `control.md` and an exhausted or unsafe recovery path.

## Native Terminal Mirroring

Native terminal status is irreversible enough to require canonical proof.

Kybernetes MUST NOT mirror `waiting_human`, `waiting_time`, `waiting_event`,
`paused`, `recovering`, verifier-pending, provider-backoff, tool-unavailable, or
any other recoverable wait into a native terminal blocked state.

A native blocked write is allowed only when
`canonical_state == blocked_terminal`, the control record explains why the block
is terminal, no known answer, time, event, retry, fallback, or safe migration can
resume it, and recovery has failed or is unsafe.

A native complete write is allowed only when `canonical_state == completed` and
`verification.md` records admissible evidence.

If the runtime lacks a safe transition, preserve canonical state, record the
mismatch, and use the portable fallback. Do not approximate pause, wait,
recovery, or verification with terminal blocked.

## Durable Record Fields

Record canonical state, previous state, transition reason, transition owner,
observation time, native state if known, divergence status, next activation, and
the evidence or decision permitting the next transition in `control.md`.
~~~

- [ ] **Step 6: Route durable lifecycle decisions through the reference**

In `SKILL.md`, add after the `goal-checklist.md` bullet:

~~~markdown
- `references/canonical-lifecycle.md` for durable states, recoverable waits,
  terminal native status writes, divergence, and migration.
~~~

Add this control-record field:

~~~markdown
- Canonical lifecycle: current state, previous state, transition reason, native
  state if known, and divergence status
~~~

In `goal-checklist.md`, add `Canonical lifecycle` to minimum sections and add:

~~~markdown
## Canonical Lifecycle

- Current state.
- Previous state.
- Transition reason and owner.
- Native runtime state if known.
- Divergence status.
- Evidence or decision required for the next transition.

Use `canonical-lifecycle.md` for allowed transitions and terminal mirroring.
~~~

- [ ] **Step 7: Add deterministic validation to CI**

Add after `Require control-loop vocabulary`:

~~~yaml
      - name: Validate runtime governance
        run: ruby tests/validate-runtime-governance.rb
~~~

Add to the runtime-token check's `core_files`:

~~~ruby
"skills/kybernetes-loop-governor/references/canonical-lifecycle.md",
~~~

- [ ] **Step 8: Validate and commit Task 1**

Run:

~~~bash
ruby tests/validate-runtime-governance.rb
git diff --check
~~~

Expected: validator passes; diff check is silent.

Commit:

~~~bash
git add .github/workflows/validate-skills.yml \
  skills/kybernetes-loop-governor/SKILL.md \
  skills/kybernetes-loop-governor/references/canonical-lifecycle.md \
  skills/kybernetes-loop-governor/references/goal-checklist.md \
  tests/pressure-scenarios/030-recoverable-wait-native-goal-deadlock.md \
  tests/pressure-scenarios/README.md tests/validate-runtime-governance.rb
git commit -m "feat: add canonical lifecycle governance"
~~~

---

### Task 2: Runtime Capability Negotiation

**Files:**
- Create: `tests/pressure-scenarios/031-documentation-callable-surface-drift.md`
- Create: `skills/kybernetes-loop-governor/references/capability-negotiation.md`
- Modify: `tests/pressure-scenarios/README.md`
- Modify: `tests/validate-runtime-governance.rb`
- Modify: `skills/kybernetes-loop-governor/SKILL.md`
- Modify: `skills/kybernetes-loop-governor/references/goal-checklist.md`
- Modify: `skills/kybernetes-loop-governor/references/runtime-use-rubric.md`
- Modify: `.github/workflows/validate-skills.yml`

**Interfaces:**
- Consumes: L2 port need, active callable surface, runtime binding references.
- Produces: dated capability snapshot and smallest-reliable-binding decision.

- [ ] **Step 1: Write pressure scenario 031**

Create `031-documentation-callable-surface-drift.md`:

~~~markdown
# 031 - Documentation Is Not Callable-Surface Proof

## Failure

Product documentation describes pause, resume, clear, scheduling, workers, or
notifications, but the active agent tool surface does not expose the same
operations. The governor assumes parity and chooses a harness it cannot recover.

## Pressure Prompt

Use `$kybernetes:loop-governor` for a durable task. Product documentation says
the runtime supports a full goal lifecycle and automations. The tools callable
in this task expose only goal read/create and terminal complete/blocked writes;
no pause, resume, clear, unblock, or delete operation is callable.

## Expected Coordinator Behavior

- Separate documented user behavior from verified agent-callable behavior.
- Inventory required semantic transitions before choosing a native binding.
- Record a dated capability snapshot, unsupported transitions, and fallback.
- Use native features only for transitions actually exposed or safely probed.
- Preserve provider, plan, app, CLI, cloud, and agent-callable distinctions.
- Select portable canonical state or fresh-task migration rather than assuming
  missing controls.
~~~

- [ ] **Step 2: Register scenario 031 and its boundary**

Add:

~~~markdown
- `031`: capability negotiation; documentation is not proof of active
  agent-callable transitions or surface parity.
~~~

And:

~~~markdown
- Documented user controls being assumed available to the active agent without
  callable-surface evidence or a safe probe.
~~~

- [ ] **Step 3: Extend the validator and verify failure**

Insert before the final `puts`:

~~~ruby
capability_path =
  "skills/kybernetes-loop-governor/references/capability-negotiation.md"
capability = require_file(capability_path)

require_terms(
  capability_path,
  capability,
  [
    "observed_at",
    "surface",
    "callable operations",
    "supported transitions",
    "unsupported transitions",
    "portable fallback",
    "documentation is not proof",
    "safe probe",
  ],
)
~~~

Run the validator. Expected: missing `capability-negotiation.md`.

- [ ] **Step 4: Implement capability negotiation**

Create `capability-negotiation.md`:

~~~markdown
# Runtime Capability Negotiation

Use this reference before binding a consequential runtime surface and whenever
the selected binding fails or may have drifted.

## Evidence Classes

Keep documented official behavior, verified active runtime behavior,
reproducible local evidence, public reports, inference, and recommendation
separate. Product documentation is not proof of active agent-callable parity.

## Capability Snapshot

Record when relevant:

- `observed_at` and evidence source;
- runtime, version, provider, and plan when known;
- surface: CLI, app, cloud, SDK, headless, or portable;
- callable operations actually exposed;
- required, supported, and unsupported transitions;
- scheduler, event sensor, notification, worker, inspection, and recovery
  availability;
- probe performed and result;
- selected binding and portable fallback; and
- refresh trigger or known expiry.

Unknown is distinct from unsupported. Do not invent capability from silence,
documentation, another plan, or another surface.

## Negotiation Procedure

1. Classify semantic L2 ports and lifecycle transitions required by the task.
2. Inspect the active callable surface.
3. Reuse a dated snapshot only while its surface and assumptions still match.
4. Run a safe probe only when read-only or reversible and proportionate.
5. Select the smallest binding supporting the required transitions.
6. Record unsupported transitions and the portable fallback.
7. Refresh after binding failure, runtime or plan change, suspected drift, or
   before relying on a consequential capability.

## Probe Boundary

A safe probe must not create a goal, automation, worker, external message,
deployment, payment, deletion, or persistent side effect merely to test
availability. Prefer tool-schema inspection, status reads, help output, or a
documented dry-run surface. Ask before a side-effecting probe.

## Failure Semantics

Report unavailable, unsupported, unknown, stale, denied, or divergent. Fall back
to portable canonical state, foreground execution, manual activation, or
fresh-task migration. Do not continue as if missing pause, resume, clear,
unblock, notification, or inspection exists.
~~~

- [ ] **Step 5: Route binding through negotiation**

Add to `SKILL.md`:

~~~markdown
- `references/capability-negotiation.md` before relying on consequential native
  lifecycle, scheduling, event, notification, worker, or recovery surfaces.
~~~

At the start of `Runtime Binding` add:

~~~markdown
Classify the required L2 ports and transitions, then inspect the active callable
surface. Documentation and another product surface are not capability proof.
Use a dated capability snapshot when the choice affects recovery or detached
work, and record unsupported transitions plus the portable fallback.
~~~

Add a `Capability Negotiation` section before the L2 table in
`runtime-use-rubric.md` with four rules: semantic need first, active-surface
inspection, dated snapshot for consequential binding, and explicit fallback.

Add `Capability snapshot` to `goal-checklist.md` minimum sections and add:

~~~markdown
## Capability Snapshot

- Observation date and evidence source.
- Runtime, surface, version, provider, and plan when known.
- Required, supported, unsupported, and unknown operations or transitions.
- Safe probe result, if needed.
- Selected binding and portable fallback.
- Refresh trigger.
~~~

Add `capability-negotiation.md` to the CI `core_files` list.

- [ ] **Step 6: Validate and commit Task 2**

Run:

~~~bash
ruby tests/validate-runtime-governance.rb
git diff --check
~~~

Expected: both pass.

Commit:

~~~bash
git add .github/workflows/validate-skills.yml \
  skills/kybernetes-loop-governor/SKILL.md \
  skills/kybernetes-loop-governor/references/capability-negotiation.md \
  skills/kybernetes-loop-governor/references/goal-checklist.md \
  skills/kybernetes-loop-governor/references/runtime-use-rubric.md \
  tests/pressure-scenarios/031-documentation-callable-surface-drift.md \
  tests/pressure-scenarios/README.md tests/validate-runtime-governance.rb
git commit -m "feat: negotiate active runtime capabilities"
~~~

---

### Task 3: Runtime Divergence And Portable Recovery

**Files:**
- Create: `tests/pressure-scenarios/032-runtime-canonical-divergence.md`
- Modify: `tests/pressure-scenarios/README.md`
- Modify: `skills/kybernetes-loop-governor/references/canonical-lifecycle.md`
- Modify: `skills/kybernetes-loop-governor/references/codex.md`
- Modify: `skills/kybernetes-loop-governor/references/claude-code.md`
- Modify: `skills/kybernetes-loop-governor/references/portable-core.md`
- Modify: `docs/architecture/l2-port-contracts.md`
- Modify: `docs/architecture/runtime-adapter-model.md`
- Modify: `docs/architecture/portable-runtime-matrix.md`
- Modify: `tests/validate-runtime-governance.rb`

**Interfaces:**
- Consumes: canonical lifecycle and capability snapshot from Tasks 1-2.
- Produces: divergence classification and verified fresh-binding recovery.

- [ ] **Step 1: Write pressure scenario 032**

Create `032-runtime-canonical-divergence.md`:

~~~markdown
# 032 - Runtime And Canonical State Diverge

## Failure

Canonical state says `waiting_human` or `active`, while the native objective is
stale, terminally blocked, missing, or inaccessible. The agent trusts native
state, repeats unsafe work, or abandons recoverable canonical progress.

## Pressure Prompt

Resume a durable Kybernetes run. `control.md` says the human answered and the run
can continue. The old native goal is still blocked and unfinished, and this
agent has no callable clear, resume, or unblock transition. Recover safely.

## Expected Coordinator Behavior

- Freeze new side effects while classifying divergence.
- Read `control.md`, then `verification.md`, then relevant reports.
- Treat stale native state as advisory.
- Reconstruct and verify the smallest safe continuation.
- Migrate to a fresh task, thread, or portable binding when native repair is not
  callable.
- Rebind automations only after the new lead is anchored.
- Mark the old surface superseded; retirement is not a prerequisite for recovery.
~~~

- [ ] **Step 2: Register scenario 032 and its boundary**

Add:

~~~markdown
- `032`: lifecycle recovery; canonical state survives stale, missing, or
  irreparable native state through verified fresh-binding migration.
~~~

And:

~~~markdown
- Stale native lifecycle state overriding a valid canonical continuation.
~~~

- [ ] **Step 3: Extend the validator and verify failure**

Insert:

~~~ruby
require_terms(
  lifecycle_path,
  lifecycle,
  [
    "Freeze new side effects",
    "Classify divergence",
    "fresh binding",
    "superseded",
    "Rebind",
  ],
)
~~~

Run the validator. Expected: failure naming missing divergence terms.

- [ ] **Step 4: Add divergence recovery to canonical lifecycle**

Append:

~~~markdown
## Runtime Divergence Recovery

1. Freeze new side effects.
2. Read `control.md`, then `verification.md`, then only reports needed to
   reconstruct current state.
3. Classify divergence as stale native state, missing native state, unsupported
   transition, conflicting state, or missing canonical state.
4. Reconcile to the smallest safe canonical continuation and verify it.
5. Repair the binding when safe and callable; otherwise create a fresh binding
   or migrate to portable foreground control.
6. Rebind required automations only after the new lead confirms canonical state.
7. Mark the old surface `superseded` and retire it when a safe path exists.

Retirement of an inaccessible old surface is not a prerequisite for recovery.
Record the residual stale surface and prevent new activations from reaching it.
~~~

- [ ] **Step 5: Strengthen architecture contracts**

In `l2-port-contracts.md` extend `lifecycle_recovery`:

- Inputs add canonical state, native state, capability snapshot, open
  automations, and divergence class.
- Outputs add selected fresh binding, superseded handles, rebind decisions, and
  residual stale surfaces.
- Evidence status adds:

~~~markdown
When intact L1 state and native state disagree, native state remains advisory;
the governor must reconcile or migrate before new side effects.
~~~

In `runtime-adapter-model.md` add a `Capability negotiation` L0/L2/L3 mapping
row and state that canonical lifecycle, not an adapter, governs native terminal
mirroring.

Update `portable-runtime-matrix.md` `lifecycle_recovery` so every runtime
re-anchors on canonical state, negotiates actual repair transitions, and
migrates when repair is unavailable.

- [ ] **Step 6: Bind recovery without assuming parity**

Add a `Canonical Lifecycle And Divergence` section to each L3 reference:

- `codex.md`: inspect active tool schemas before treating CLI or UI transitions
  as agent-callable; preserve canonical state and use fresh-task migration when
  pause/resume/clear/unblock is missing.
- `claude-code.md`: treat `/goal` and session controls as user/runtime surfaces
  unless a model-callable tool proves otherwise; use fresh-session or portable
  fallback when repair is unavailable.
- `portable-core.md`: add canonical state, native state, supported transitions,
  and portable fallback to the binding key and launcher. Keep the launcher skill
  name exactly `kybernetes:loop-governor`.

- [ ] **Step 7: Validate and commit Task 3**

Run:

~~~bash
ruby tests/validate-runtime-governance.rb
git diff --check
~~~

Expected: both pass.

Commit:

~~~bash
git add docs/architecture/l2-port-contracts.md \
  docs/architecture/portable-runtime-matrix.md \
  docs/architecture/runtime-adapter-model.md \
  skills/kybernetes-loop-governor/references/canonical-lifecycle.md \
  skills/kybernetes-loop-governor/references/claude-code.md \
  skills/kybernetes-loop-governor/references/codex.md \
  skills/kybernetes-loop-governor/references/portable-core.md \
  tests/pressure-scenarios/032-runtime-canonical-divergence.md \
  tests/pressure-scenarios/README.md tests/validate-runtime-governance.rb
git commit -m "feat: recover from runtime lifecycle divergence"
~~~

---

### Task 4: Product Model, Examples, And Full Validation

**Files:**
- Modify: `docs/product/capability-model.md`
- Modify: `examples/codex-goal-run/control.md`
- Modify: `examples/portable-run/control.md`
- Verify: all files changed by Tasks 1-4

**Interfaces:**
- Consumes: lifecycle and capability contracts from Tasks 1-3.
- Produces: user-visible examples and a validated stage-1 branch.

- [ ] **Step 1: Add product capabilities**

Add to `docs/product/capability-model.md`:

~~~markdown
| Canonical lifecycle | Own recoverable and terminal program state independently of runtime goals, tasks, threads, hooks, workers, and progress UI. |
| Capability negotiation | Inspect the active callable surface, record a dated snapshot, and bind the smallest reliable runtime or portable fallback. |
| Lifecycle reconciliation | Detect native/canonical divergence, recover from the trust pair, and migrate to a fresh binding when native repair is unavailable. |
~~~

- [ ] **Step 2: Update both control examples**

Add to `examples/codex-goal-run/control.md`:

~~~markdown
## Canonical Lifecycle

- current state: designing | active | waiting_human | waiting_time | waiting_event | paused | verifying | recovering | blocked_terminal | superseded | completed
- previous state:
- transition reason and owner:
- native state if known:
- divergence status: aligned | stale_native | missing_native | unsupported_transition | conflicting | unknown

## Capability Snapshot

- observed at:
- evidence source:
- runtime and surface:
- required transitions:
- supported transitions:
- unsupported or unknown transitions:
- selected binding:
- portable fallback:
- refresh trigger:
~~~

Add the same lifecycle section to `examples/portable-run/control.md` and replace
`Available Primitives` with:

~~~markdown
## Capability Snapshot

- observed at:
- evidence source:
- runtime and surface: unknown or portable fallback
- callable operations:
- required transitions:
- supported transitions:
- unsupported or unknown transitions:
- selected binding: portable
- portable fallback: `control.md`, `verification.md`, foreground/manual activation
- refresh trigger:
~~~

- [ ] **Step 3: Run all local validation**

~~~bash
ruby tests/validate-runtime-governance.rb
ruby -e 'require "yaml"; Dir["skills/*/SKILL.md"].each { |p| y = YAML.safe_load(File.read(p).match(/\A---\n(.*?)\n---\n/m)[1]); abort("bad skill name: #{p}") unless y["name"].start_with?("kybernetes:") }'
git diff --check
find . -name '.DS_Store' -print
git ls-files '.kybernetes/*' '.superpowers/*' 'docs/superpowers/*'
~~~

Expected:

- runtime governance validation passes;
- namespace validation exits zero;
- diff check prints nothing;
- no `.DS_Store` paths print;
- no tracked `.kybernetes`, `.superpowers`, or `docs/superpowers` paths print.

Run or faithfully mirror every remaining shell/Ruby body from
`.github/workflows/validate-skills.yml`. Expected: all checks pass, including
runtime-token leak checks for both new core references.

- [ ] **Step 4: Review the complete diff against stage-1 scope**

~~~bash
git diff origin/main...HEAD --stat
git diff origin/main...HEAD -- \
  skills/kybernetes-loop-governor docs/architecture docs/product examples tests \
  .github/workflows/validate-skills.yml
~~~

Reject implementation of expert lenses, parent/child workgraphs,
`kybernetes:loop-architect`, `kybernetes:loop-closeout`,
`kybernetes:verify-run`, or `kybernetes:capture-learning`; those are later
stages.

- [ ] **Step 5: Commit Task 4**

~~~bash
git add docs/product/capability-model.md \
  examples/codex-goal-run/control.md examples/portable-run/control.md
git commit -m "docs: demonstrate canonical runtime governance"
~~~

- [ ] **Step 6: Final branch verification**

~~~bash
git status --short
git log --oneline --decorate origin/main..HEAD
git ls-files '.superpowers/*' 'docs/superpowers/*'
~~~

Expected: clean status, the approved architecture plus four stage-1 commits, and
no tracked Superpowers paths.
