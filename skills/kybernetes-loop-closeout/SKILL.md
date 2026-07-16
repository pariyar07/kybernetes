---
name: 'kybernetes:loop-closeout'
description: 'Checkpoint, hand off, or retire bounded loop machinery while preserving canonical state, evidence, and governor authority.'
---

# Kybernetes Loop Closeout

This helper reconciles a completed or transferring unit and returns retirement
evidence. It cannot mutate parent canonical lifecycle state or accept DONE; the
governor admits its result and performs the canonical transition.

## Modes

- `checkpoint`: close a completed unit inside an active parent; preserve the
  remaining checklist and next activation.
- `handoff`: prove a new lead can reconstruct state before superseding the old.
- `workstream`: reconcile one child and retire its lease, activation, and
  temporary permissions without completing the parent.
- `program`: verify DONE coverage and retire all bounded machinery.

Default to the narrowest mode. Checkpoint and workstream modes never imply
program completion.

## Required Inputs

- Mode, parent control and verification pointers, canonical revision.
- Scope being closed and measurable completion claim.
- Runtime capability snapshot and permission boundary.
- Worker, goal, thread, scheduler, event, hook, automation, lease, and temporary
  access inventory.
- Retention policy, explicitly disposable material, and next activation.

## evidence reconciliation

1. Read canonical state and verification evidence.
2. Compare the scoped completion claim with its rejection-capable verifier.
3. Identify missing, conflicting, stale, or non-reproducible evidence.
4. Preserve admitted and unresolved evidence; archive canonical records by
   default.
5. Delete only material explicitly marked disposable and reproducible, within
   current permission.

If verification is incomplete, return `not_ready` and the gaps. Do not disguise
cleanup as completion.

## retirement inventory

For each bounded object record identity, owner, purpose, inspect operation,
intended stop/delete/revoke transition, capability observed, attempt, result,
and residual risk. Cover active workers, peer tasks, native goals, schedules,
events, hooks, automations, leases, credentials, temporary access, and files.

Retirement is idempotent: already-retired is a successful no-op. A missing stop
or delete capability is recorded for intervention; it does not justify mutating
canonical state to match stale runtime state.

## Handoff Protocol

The incoming lead must read `control.md`, `verification.md`, and a valid
manifest; confirm canonical revision, permissions, capability, current
checklist, and next activation; and pass a reconstruction check. Only then may
the governor mark the old lead or binding superseded and rebind activations.

## Output

```yaml
closeout_status: ready | not_ready | partial
mode: checkpoint | handoff | workstream | program
canonical_revision: <observed>
verification: <coverage and gaps>
retirement_inventory: <per-object results>
retained: <canonical and evidence artifacts>
deleted: <explicitly disposable artifacts and reasons>
handoff_reconstruction: <pass, fail, or not_applicable>
proposed_transition: <none, superseded, or completed>
next_activation: <trigger or none>
intervention: <unretired objects or none>
```

## Return To Governor

Return the packet and evidence pointers. The governor checks revision and scope,
admits or rejects the proposal, owns any lifecycle transition, and records
failures to retire. Repeated invocation against unchanged state must return the
same effective result.
