# Verify Run Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add independent, rejection-capable verification with explicit coverage, provenance, gaps, and result semantics.

**Architecture:** A helper consumes DONE and immutable evidence pointers, classifies verifier type, enforces maker/checker separation, and returns a non-mutating result packet. Pressure scenarios and Ruby validation guard authority and coverage.

**Tech Stack:** Markdown skill and Ruby validation.

## Global Constraints

- Producer self-approval is insufficient above simple work.
- Advisory comparison is not verification.
- Incomplete coverage cannot complete canonical state.
- The governor owns lifecycle transitions.

---

### Task 1: Commit scenarios 055-059 and validator.
### Task 2: Implement `kybernetes:verify-run`, update inventory/index/CI, validate, and commit.
