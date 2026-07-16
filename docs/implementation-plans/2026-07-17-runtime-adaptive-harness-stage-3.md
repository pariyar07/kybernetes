# Loop Architect Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add an independent architecture helper for consequential uncertainty without burdening routine work or creating a second governor.

**Architecture:** Pressure scenarios establish activation and authority boundaries. The helper generates task-specific independent lenses, synthesizes an execution contract, and returns proposals to the parent governor. A deterministic validator enforces naming, inputs, outputs, promotion gates, and non-authority.

**Tech Stack:** Markdown skills, pressure scenarios, Ruby validation.

## Global Constraints

- The loop governor remains the only canonical controller.
- Trigger on consequence and unresolved uncertainty, not task size alone.
- Generate lenses dynamically; never hardcode expert types.
- Advisory consensus is not verification.

---

### Task 1: Pressure The Boundary

- [ ] Add scenarios 037-040.
- [ ] Run the validator and observe the missing-skill failure.
- [ ] Commit rejecting evidence.

### Task 2: Implement The Helper

- [ ] Create `skills/kybernetes-loop-architect/SKILL.md` with standalone and governed return paths.
- [ ] Add dynamic lens, disagreement, and evidence-gated promotion contracts.
- [ ] Update skill inventory and lazy reference index.
- [ ] Run all validation and commit.
