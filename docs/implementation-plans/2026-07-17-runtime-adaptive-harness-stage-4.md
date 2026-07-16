# Parent And Child Workgraph Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Define a recoverable portable workgraph with one parent writer, bounded children, idempotent inbox reports, and cooperative leases.

**Architecture:** A normative reference defines activation, workstream, report, lease, admission, and reconciliation contracts. A public example demonstrates the file layout. Pressure scenarios and Ruby validation enforce stale/duplicate/conflict behavior.

**Tech Stack:** Markdown contracts, YAML examples, Ruby validation.

## Global Constraints

- Parent `control.md` has one writer.
- Children cannot self-accept or change parent lifecycle.
- Stale revisions and expired leases stop before new effects.
- Flat workgraphs are the default.

---

### Task 1: Add rejecting scenarios 041-045 and validator.
- [ ] Commit pressure evidence before normative behavior.

### Task 2: Add workgraph reference and example.
- [ ] Define identities, revisions, reports, leases, and reconciliation.
- [ ] Wire the reference index and CI.
- [ ] Run full validation and commit.
