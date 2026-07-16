# Capture Learning Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add an evidence-gated helper that proposes durable constraints and reusable learning without silently rewriting governance.

**Architecture:** The helper classifies observations, checks recurrence and causal strength, chooses proportionate enforceability, and returns a reviewable promotion packet with scope, validation, rollback, owner, and revalidation. Pressure scenarios enforce non-authority and staleness handling.

**Tech Stack:** Markdown skill and Ruby validation.

## Global Constraints

- One-off observations are not automatically product law.
- Prefer enforceable constraints to prose reminders.
- Public/policy changes require explicit review.
- The helper never silently edits governance.

---

### Task 1: Commit scenarios 060-063 and validator.
### Task 2: Implement `kybernetes:capture-learning`, update inventory/index/CI, validate, and commit.
