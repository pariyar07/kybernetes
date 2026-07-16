# Runtime-Adaptive Harness Release Integration Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Integrate, document, install-test, probe, and release the complete v0.1 runtime-adaptive harness.

**Architecture:** A release validator enforces skill discovery, docs, examples, namespaces, forbidden paths, and release metadata. Public docs describe semantic selection while runtime bindings retain capability-specific details. RC and final tags are created only after clean checkout and available live probes.

**Tech Stack:** Markdown, SVG, Ruby, shell, GitHub releases.

## Global Constraints

- Final tag points to merged `main`; RC tag points to verified release branch.
- No live run or Superpowers artifacts are tracked.
- All public capability claims are dated or explicitly runtime-dependent.
- Transactional orchestration remains deferred.

---

### Task 1: Commit integrated scenarios 064-068 and release validator.
### Task 2: Reconcile READMEs, changelog, architecture, examples, diagrams, and release notes.
### Task 3: Run clean-checkout validation and available runtime probes.
### Task 4: Merge Stage 9, tag and publish RC, open umbrella PR, close PR #23.
### Task 5: Merge umbrella PR, validate main, tag and publish v0.1.0.
