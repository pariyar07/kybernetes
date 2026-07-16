# Lean Governor Kernel Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Reduce always-loaded governor context while preserving fail-closed reconstruction of every required control module.

**Architecture:** `SKILL.md` becomes the stable kernel. `manifest.md` defines persisted module selection, while `reference-index.md` maps sensed triggers to focused references. A Ruby validator enforces schema, trigger coverage, compatibility invariants, and a measurable line-count reduction.

**Tech Stack:** Markdown skill artifacts, Ruby deterministic validation, shell CI.

## Global Constraints

- Never track `.superpowers/`, `docs/superpowers/`, or live `.kybernetes/` files.
- Keep runtime-specific semantics in L3 runtime references.
- Preserve Kybernetes canonical authority and the recoverable-wait mirroring law.
- Use pressure scenarios before changing skill behavior.

---

### Task 1: Define Rejecting Pressure And Validation

**Files:**
- Create: `tests/pressure-scenarios/033-small-task-lazy-loading.md`
- Create: `tests/pressure-scenarios/034-manifest-reconstructs-reference-set.md`
- Create: `tests/pressure-scenarios/035-stale-manifest-fails-closed.md`
- Create: `tests/pressure-scenarios/036-no-dynamic-loader-fallback.md`
- Create: `tests/validate-lazy-governor.rb`

**Interfaces:**
- Consumes: Stage 2 promotion gates.
- Produces: deterministic checks for the manifest, index, kernel, and context budget.

- [ ] Write the four pressure scenarios and validator requirements.
- [ ] Run `ruby tests/validate-lazy-governor.rb` and confirm it fails because Stage 2 artifacts are absent.
- [ ] Commit the rejecting evidence.

### Task 2: Add Manifest And Reference Index

**Files:**
- Create: `skills/kybernetes-loop-governor/manifest.md`
- Create: `skills/kybernetes-loop-governor/references/reference-index.md`

**Interfaces:**
- Consumes: sensed task dimensions and active callable runtime surface.
- Produces: schema revision, selected modules, load triggers, and fail-closed reconstruction rules.

- [ ] Define the portable manifest schema and complete example.
- [ ] Map each optional module to a one-line purpose and explicit load condition.
- [ ] Run the validator and retain the expected kernel-size failure.
- [ ] Commit the manifest boundary.

### Task 3: Slim The Kernel And Wire CI

**Files:**
- Modify: `skills/kybernetes-loop-governor/SKILL.md`
- Modify: `skills/kybernetes-loop-governor/README.md`
- Modify: `.github/workflows/validate-skills.yml`

**Interfaces:**
- Consumes: `manifest.md` and `references/reference-index.md`.
- Produces: an always-loaded controller that selects the smallest reliable harness.

- [ ] Replace detailed modules with invariant-preserving lazy-load instructions.
- [ ] Add portable no-loader fallback and stale-manifest fail-closed behavior.
- [ ] Run Stage 2 and full repository validation.
- [ ] Record before/after line counts and commit the implementation.
