# Activation And Notification Bindings Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Govern immediate, human, time, and event re-entry with idempotency, notification, budget, and retirement guarantees.

**Architecture:** A portable activation contract chooses direct event or bounded polling from observed guarantees. Runtime binding sections map capabilities without assuming documentation parity. Pressure scenarios and validation enforce notification, revision, duplicate, no-change, and retirement gates.

**Tech Stack:** Markdown contracts and runtime bindings, Ruby validation.

## Global Constraints

- Detached blocking requires notification or accepted manual checkpoint cadence.
- Canonical revision is checked before effects.
- Duplicate delivery is idempotent.
- Retirement conditions exist before activation.

---

### Task 1: Commit pressure scenarios 046-050 and validator.
### Task 2: Add portable activation contract and runtime mappings, wire CI, validate, and commit.
