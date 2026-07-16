# Runtime-Adaptive Harness v0.1 Release Train

Status: approved for implementation
Date: 2026-07-17
Target release: `v0.1.0`
Required prerelease: `v0.1.0-rc.1`

## Executive Decision

Kybernetes will deliver the approved runtime-adaptive harness architecture as
one coordinated `v0.1.0` release assembled through nine focused stages.

One release does not mean one implementation PR. Each stage is reviewed and
verified independently against the release integration branch. The integration
branch produces one umbrella PR to `main`, one release-candidate prerelease, and
one final immutable release tag.

The release integration branch is:

```text
release/runtime-adaptive-harness-v0.1
```

It starts from the verified Stage 1 head, commit `0bc188e`.

## Release Goals

- Ship the full portable runtime-adaptive harness architecture as one coherent
  first semantic release.
- Preserve focused review, regression isolation, and stage-level rollback.
- Keep Kybernetes canonical across goals, tasks, threads, workers, schedulers,
  hooks, and progress surfaces.
- Add callable helper skills only after their pressure and fallback gates pass.
- Exercise Codex, Claude Code, and portable fallback behavior before release.
- Publish complete user, contributor, architecture, example, visual, and release
  documentation with no stale behavior claims.

## Release Non-Goals

- One giant implementation PR.
- Merging Stage 1 directly to `main` before the full release is ready.
- A production transactional orchestration service without evidence that the
  portable file-based substrate is insufficient.
- Hardcoded expert roles, provider-specific core semantics, or user-designed
  harness selection.
- Creating helper skill folders before their individual promotion gates pass.

## Branch And Pull Request Topology

```text
main
  \
   release/runtime-adaptive-harness-v0.1
      ├── stage-2 lean kernel
      ├── stage-3 loop architect
      ├── stage-4 workgraph
      ├── stage-5 activation bindings
      ├── stage-6 loop closeout
      ├── stage-7 verify run
      ├── stage-8 capture learning
      └── stage-9 release integration
```

### Umbrella Pull Request

- Open one draft umbrella PR from
  `release/runtime-adaptive-harness-v0.1` to `main`.
- Keep it draft until Stage 9 and `v0.1.0-rc.1` verification pass.
- Track stage status, evidence, known limitations, documentation coverage, and
  release readiness in its description.
- After the umbrella PR exists and is verified, close PR #23 as superseded
  without merging it. Link both PRs so history remains discoverable.

### Stage Pull Requests

- Create each stage branch from the current release branch head.
- Target every stage PR at `release/runtime-adaptive-harness-v0.1`.
- Use a merge commit for stage integration. Do not squash or rebase stage PRs
  after dependent work begins.
- Do not force-push the release branch after stage integration.
- The release branch accepts behavior changes only through reviewed stage PRs.
- Release metadata and conflict-only integration fixes may be committed directly
  only during Stage 9 and must be called out in the umbrella PR.

Suggested branch names:

```text
codex/v0.1.0-stage-2-lean-kernel
codex/v0.1.0-stage-3-loop-architect
codex/v0.1.0-stage-4-workgraph
codex/v0.1.0-stage-5-activation-bindings
codex/v0.1.0-stage-6-loop-closeout
codex/v0.1.0-stage-7-verify-run
codex/v0.1.0-stage-8-capture-learning
codex/v0.1.0-stage-9-release-integration
```

## Cross-Stage Skill Contract

Every Kybernetes installable skill:

- uses `kybernetes:<skill-name>` in frontmatter and documentation;
- is directly user-callable and governor-callable;
- declares required inputs, permission boundary, owned output, evidence,
  recommendation or proposed transition, and return path;
- cannot independently mutate parent canonical lifecycle state;
- has a portable fallback when the skill or runtime surface is unavailable;
- remains bounded by the active control record and verifier; and
- is created only after pressure evidence demonstrates a real independent
  behavior boundary.

`kybernetes:loop-governor` remains the only governor.

## Nine Stage Contracts

### Stage 1: Canonical Lifecycle And Capability Negotiation

Status: implemented and validated in the Stage 1 branch.

Deliverables:

- canonical lifecycle state vocabulary;
- recoverable-wait versus terminal-state mirroring law;
- active callable-surface capability negotiation;
- runtime/canonical divergence recovery;
- Codex, Claude Code, and portable binding updates;
- pressure scenarios `030` through `032`; and
- deterministic runtime-governance and forbidden-path validation.

Promotion gate:

- all Stage 1 local CI-equivalent checks pass;
- no `.superpowers/` or `docs/superpowers/` paths are tracked; and
- the release branch starts from the exact verified Stage 1 head.

### Stage 2: Lean Governor Kernel And Dynamic Loading

Deliverables:

- lean always-loaded `kybernetes:loop-governor` kernel;
- portable `manifest.md` schema and example;
- reference index with one-line descriptions and load conditions;
- conditional loading rules for lifecycle, capability, topology, recovery,
  verification, learning, and runtime bindings; and
- compatibility behavior for runtimes without dynamic skill/reference loading.

Promotion gate:

- existing pressure suite remains green;
- small tasks do not load unrelated runtime or orchestration material;
- durable tasks can reconstruct the correct reference set from the manifest;
- stale manifest revision fails closed to canonical reconciliation; and
- token/context measurements demonstrate a meaningful always-loaded reduction.

### Stage 3: `kybernetes:loop-architect`

Deliverables:

- user-callable and governor-callable helper skill;
- activation rules for high/extreme work, consequential unresolved uncertainty,
  major reframing, and substrate recovery;
- independent dynamically generated expert lenses;
- execution contract covering activation, topology, feedback, continuity,
  runtime needs, verification, boundary, and stop conditions;
- evidence-gated promotion from temporary lens to durable workstream; and
- standalone proposal fallback when no governor is active.

Promotion gate:

- small routine work skips the architect;
- short consequential work can trigger it;
- no fixed expert roster or role-type list becomes product law;
- independent lens disagreement is preserved for governor synthesis;
- advisory consensus is never promoted to verification; and
- the helper cannot change canonical lifecycle state.

### Stage 4: Parent And Child Workgraph

Deliverables:

- one parent program with lead-owned `control.md`;
- child workstream contract, status, and evidence schemas;
- inbox report envelope and activation identity;
- canonical revision checks;
- cooperative lease contract for portable files;
- single-writer reconciliation and admission rules;
- flat workgraph default and recursive-child creation gate; and
- migration path from existing worker registry records.

Promotion gate:

- duplicate reports are idempotent;
- stale revisions cannot perform new side effects;
- expired leases cannot continue writing;
- conflicting reports are quarantined and reconciled;
- children cannot self-accept or edit parent truth; and
- ignored `.kybernetes/` state remains recoverable across isolated workspaces.

### Stage 5: Activation And Notification Bindings

Deliverables:

- immediate, human, time, and event activation contracts;
- direct-event preference and scheduled-polling fallback;
- cadence, no-change, budget, attempt, stop, and retirement rules;
- scheduler, event sensor, notification, inspection, and automation L2/L3
  alignment;
- activation deduplication and idempotency requirements;
- notification/manual-checkpoint fail-closed gate; and
- runtime-specific Codex and Claude Code bindings plus portable fallback.

Promotion gate:

- missing notification prevents detached blocking;
- duplicate schedules or events do not duplicate effects;
- unreliable events select polling explicitly;
- no-change is a normal recorded outcome;
- stale activation revisions stop before side effects;
- automation retirement conditions are present before activation; and
- provider, plan, CLI, app, cloud, and agent-callable surfaces stay distinct.

### Stage 6: `kybernetes:loop-closeout`

Deliverables:

- user-callable and governor-callable helper skill;
- `checkpoint`, `handoff`, `workstream`, and `program` modes;
- evidence reconciliation before closeout;
- worker, goal, scheduler, event, and automation retirement inventory;
- temporary-permission revocation and retention rules;
- archive-by-default treatment for canonical state and admitted evidence; and
- fresh-task handoff contract.

Promotion gate:

- cleanup cannot delete unresolved or non-reproducible evidence;
- closeout stops bounded machinery and records failures to stop it;
- checkpoint mode does not falsely complete the program;
- handoff verifies state reconstruction before superseding the old lead;
- repeated invocation is idempotent; and
- the helper proposes transitions while the governor retains authority.

### Stage 7: `kybernetes:verify-run`

Deliverables:

- independent verification helper with rejection authority;
- verifier contract for deterministic, external, subjective, and human
  acceptance evidence;
- pass, fail, inconclusive, blocked, and not-run result model;
- evidence coverage, gap, rerun, and provenance fields;
- maker/checker separation rules; and
- fallback verifier behavior inside the governor when the helper is unavailable.

Promotion gate:

- producer self-approval is rejected;
- advisory review cannot masquerade as verification;
- subjective rubrics expose criteria and residual judgment;
- incomplete coverage cannot produce canonical completion;
- external verification respects permission boundaries; and
- failed or inconclusive verification routes to correction, reframing, or HITL.

### Stage 8: `kybernetes:capture-learning`

Deliverables:

- evidence-gated learning proposal helper;
- candidate destinations for tests, constraints, wrappers, schemas, docs,
  runtime bindings, or skill changes;
- representative-evidence, ownership, approval, rollback, and verification
  fields;
- separation of run-local observation from durable promoted learning;
- failure-to-constraint integration; and
- silent self-modification prohibition.

Promotion gate:

- one anecdote cannot become a durable rule;
- unsupported generalization remains run-local;
- public behavior changes require an accountable owner and pressure evidence;
- promoted constraints prove they catch or prevent the failure;
- rollback or removal conditions are explicit; and
- the helper cannot rewrite its own authority or canonical state.

### Stage 9: Integrated Release And Documentation

Deliverables:

- complete integrated pressure and deterministic test suite;
- clean-install skill discovery tests;
- dated live Codex and Claude Code probes where surfaces are available;
- portable fallback end-to-end tests;
- root and skill README updates;
- `CHANGELOG.md`, install guidance, examples, architecture, product, runtime,
  contributor, and planned-skill updates;
- diagram audit and updated or new diagrams when relationships need visual
  explanation;
- release evidence summary and known limitations;
- `v0.1.0-rc.1` GitHub prerelease; and
- final `v0.1.0` GitHub Release after the umbrella PR merges.

Promotion gate:

- all stage and regression checks pass from a clean checkout;
- all helper skills resolve under `kybernetes:<skill-name>`;
- no obsolete one-skill, hardcoded-role, runtime-parity, or lifecycle claims
  remain;
- docs, examples, references, and diagrams agree with implemented behavior;
- the prerelease passes clean-install and live-runtime probes;
- release notes distinguish portable guarantees, runtime-dependent behavior,
  known limitations, and deferred transactional orchestration; and
- the final tag points to the merged `main` commit, not the release branch.

## Integrated Verification

Every stage runs:

- dedicated pressure scenarios;
- full prior-scenario regression;
- deterministic policy or schema validation;
- namespace and runtime-token boundary checks;
- forbidden artifact and documentation-link checks;
- portable fallback verification; and
- focused diff and branch hygiene review.

Before `v0.1.0-rc.1`, run end-to-end scenarios for:

- human, time, and event waits;
- multiple child workstreams;
- duplicate activation and report delivery;
- stale revisions and expired leases;
- conflicting evidence and independent verification;
- native/canonical divergence and fresh-binding migration;
- detached work with notification failure;
- checkpoint, handoff, workstream, and program closeout; and
- learning proposals that are accepted, rejected, or kept run-local.

## Documentation And Visual Coverage

Stage 9 audits this chain for every implemented behavior:

```text
implemented behavior
-> normative skill/reference
-> architecture explanation
-> runnable example
-> pressure evidence
-> user-facing README or changelog entry
-> diagram when relationships are otherwise difficult to understand
```

Review and update when affected:

- root `README.md` and `CHANGELOG.md`;
- every installable `SKILL.md` and skill README;
- architecture, product, runtime-binding, L2 contract, portable matrix, and
  planned-skill documents;
- examples for manifests, control records, workstreams, verification, learning,
  launchers, activation, and closeout;
- contributor guidance and pressure-scenario indexes;
- existing SVG diagrams under `docs/assets/diagrams/`; and
- new diagrams only when they materially clarify lifecycle, workgraph ownership,
  helper invocation, activation, or release architecture.

Release closeout records durable evidence by pointer and does not duplicate repo
documentation. Optional knowledge-system adapters remain outside public defaults.

## Failure, Revert, And Rollback

- A failing stage PR does not enter the release branch.
- An integrated regression is reverted by reverting that stage's merge commit.
- Do not rewrite release-branch history after dependent work begins.
- Keep stage branches until the final release is published.
- `v0.1.0-rc.1` and `v0.1.0` tags are immutable after publication.
- A release blocker includes unresolved risk to canonical state, external side
  effects, verification authority, migration, or cleanup safety.
- Documentation drift blocks release when it can cause unsafe harness selection
  or incorrect runtime assumptions.

## Transactional Backend Boundary

`v0.1.0` ships the portable file-based workgraph with revision checks,
idempotency, cooperative leases, and fail-closed reconciliation.

A transactional orchestration backend is not part of the release unless
deterministic or live pressure evidence proves the portable substrate cannot
safely satisfy a required use case. If promoted, it receives a separate design,
storage contract, migration plan, operational model, and release decision. It
must not silently become a dependency of portable Kybernetes behavior.

## Release Publication

1. Complete and merge all stage PRs into the release branch.
2. Complete Stage 9 documentation and integration evidence.
3. Publish annotated tag `v0.1.0-rc.1` from the release branch and create a
   GitHub prerelease.
4. Run clean-install and live-runtime probes against the prerelease.
5. Resolve findings through focused stage or release-fix PRs.
6. Mark the umbrella PR ready and merge it to `main`.
7. Re-run final validation on the merged `main` commit.
8. Create annotated tag `v0.1.0` on that commit.
9. Publish the GitHub Release with evidence, limitations, fallbacks, upgrade
   notes, and links to the umbrella and stage PRs.
10. Run final release closeout and record durable release evidence.

## Immediate Transition From PR #23

After this written specification is approved:

1. Push `release/runtime-adaptive-harness-v0.1`.
2. Open the draft umbrella PR to `main`.
3. Verify that its base, head, and Stage 1 commit ancestry are correct.
4. Add a supersession link to PR #23.
5. Close PR #23 without merging it.
6. Begin the Stage 2 specification and implementation plan from the release
   branch head.

## Durable Evidence

- Stage 1 architecture: `docs/architecture/runtime-adaptive-harness-architecture.md`
- Stage 1 plan: `docs/implementation-plans/2026-07-17-runtime-adaptive-harness-stage-1.md`
- Stage 1 draft PR: https://github.com/pariyar07/kybernetes/pull/23
- Existing historical snapshot tag: `post-acceptance-substrate-v1`
- Target prerelease: `v0.1.0-rc.1`
- Target release: `v0.1.0`
