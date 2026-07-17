# Parent And Child Workgraph

Use a workgraph only when bounded independent work reduces the gap to DONE more
than its coordination cost. The parent governor is the single writer of root
`control.md`; children write only their owned outputs and inbox reports.

## Portable Layout

```text
.kybernetes/<slug>/
  control.md
  verification.md
  manifest.md
  workstreams/<workstream_id>/contract.md
  leases/<lease_id>.yaml
  inbox/<activation_id>-<report_id>.yaml
  quarantine/
```

The run root is normally ignored by version control. Recovery depends on an
explicit shared path, copied brief, or self-contained report; never assume an
isolated checkout can see ignored parent state.

## Child Contract

Every workstream contract contains:

```yaml
workstream_id: evidence-source-a
objective: <one bounded objective>
owner: <runtime identity>
owned_scope: [<paths or sources>]
permissions: read_only
canonical_revision: 12
done: <measurable condition>
verifier: <rejection-capable check>
budget: {attempts: 2}
return_path: .kybernetes/<slug>/inbox/
delegation: forbidden
```

Children cannot self-accept, edit root truth, change parent lifecycle, expand
permissions, or create descendants unless the parent contract explicitly grants
bounded delegation.

## Activation Identity

Each invocation receives a unique `activation_id`, current
`canonical_revision`, and optional lease. A retry reuses the activation identity
only when it is the same idempotent attempt. A new objective, revision, lease, or
side-effect allowance requires a new activation.

Before any effect, the child confirms that its canonical revision is current and
its lease is valid. A stale revision or expired lease stops new work and returns
partial evidence for reconciliation.

## Cooperative Lease

```yaml
lease_id: lease-018
workstream_id: evidence-source-a
activation_id: act-044
owned_scope: [sources/a]
issued_at: 2026-07-17T12:00:00Z
expires_at: 2026-07-17T12:30:00Z
canonical_revision: 12
```

A lease is a collision-avoidance contract, not a distributed lock. At expiry,
supersession, revision drift, or lost parent visibility, stop writes and effects.
Renewal is a new parent decision recorded before continuation.

## Inbox Report

```yaml
report_id: report-003
workstream_id: evidence-source-a
activation_id: act-044
canonical_revision: 12
lease_id: lease-018
status: completed
effects: []
evidence: [<pointer plus what it proves>]
verification: {result: pass, coverage: <scope>}
conflicts: []
recommendation: admit
```

The tuple `workstream_id + activation_id + report_id` is idempotent. An exact
duplicate is a no-op. Different content under the same tuple is quarantined.

## Parent Admission

The parent single writer:

1. validates identity, schema, canonical revision, scope, permission, and lease;
2. deduplicates exact repeats;
3. quarantines identity reuse, ownership overlap, conflicting reports, and
   unverifiable effects;
4. independently checks evidence against the parent verifier;
5. distinguishes the implementation owner from the accountable acceptance owner
   when work affects a dependent system;
6. records admitted evidence and advances canonical revision once, but does not
   cross the dependent-system boundary until the authorized verdict is recorded.

Evidence from a stale revision may be reusable, but it cannot authorize new
effects and is never automatically admitted. Conflicts remain visible until the
parent records provenance, comparison, decision, and residual risk.

## Topology

Prefer a flat workgraph. Recursive child creation requires explicit parent
authority, genuine independence, bounded depth and budget, collision-safe scope,
and an aggregation contract. When integration is the bottleneck, stay serial.
