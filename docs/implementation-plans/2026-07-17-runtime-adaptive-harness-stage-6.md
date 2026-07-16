# Loop Closeout Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a bounded helper for checkpoint, handoff, workstream, and program retirement with evidence-preserving idempotency.

**Architecture:** The helper inventories machinery and evidence, reconciles verification, proposes transitions, and executes only authorized retirement actions. Pressure tests prevent destructive cleanup, false completion, unsafe handoff, and repeat-run drift.

**Tech Stack:** Markdown skill and Ruby validation.

## Global Constraints

- Archive canonical state and evidence by default.
- The governor retains lifecycle authority.
- Handoff requires successful reconstruction.
- Repeated closeout is idempotent.

---

### Task 1: Commit scenarios 051-054 and validator.
### Task 2: Implement `kybernetes:loop-closeout`, update inventory/index/CI, validate, and commit.
