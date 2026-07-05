# Runtime Adapter Model

Kybernetes separates the portable control model from runtime-specific primitives.
The loop governor skill should keep its loop semantics stable while each runtime
binds those semantics to the tools it actually has.

Required L2 port contracts live in
[`l2-port-contracts.md`](l2-port-contracts.md). The repo-side runtime matrix
lives in [`portable-runtime-matrix.md`](portable-runtime-matrix.md). This file
is the adapter index: it maps older binding slots to L0/L1/L2/L3 placement so
runtime docs can bind native surfaces without changing core semantics. The full
layer legend lives in
[`layered-runtime-substrate.md`](layered-runtime-substrate.md).

## Slot To Port Mapping

| Legacy slot or concern | Placement | Port or substrate |
| --- | --- | --- |
| Skill namespace resolution | L2/L3 | `skill_package`; packaging details stay in distribution docs and binding references. |
| Durable objective | L2 | `durable_objective` |
| Planning surface | L2 | `planning_surface` |
| Checklist / progress | L2/L1 | `progress_surface`; durable progress mirrors to the L1 trust pair when needed. |
| Parallel thread / sibling chat | L2 conditional | `peer_workstream` when exercised; otherwise treat as a runtime realization of a bounded workstream pattern. |
| Worker spawn | L2 | `worker_spawn` |
| Isolation | L2/L1 | `isolation`, including the state-propagation choice for `.kybernetes/` records across isolated surfaces. |
| Inspect | L2 | `inspect_status` |
| Elicitation | L2 | `elicitation` |
| Memory or control file | L1 | `control.md` and `verification.md` remain canonical; runtime memory is advisory. |
| Verification | L2/L1 | `verification_sensor`; evidence is recorded in `verification.md`. |
| Loop altitude | L0/readiness | `stay`, `down`, `up`, `stack`, and `stop` are control-kernel decisions, not adapter features. |
| Durability tier | L0/readiness and L1 | Chosen by task variety and recovery need; implemented through the L1 state surface. |
| Hook / audit | L2 deferred | `audit_hook`; no always-on audit substrate until pressure evidence promotes it. |
| Comparator/advisor | L2 conditional | `comparator_augmentation`; advisory only, never a substitute for `verification_sensor`. |
| Schedule / recurrence | L2 conditional | `scheduler`; only when a concrete scheduled activation is requested and the notification/manual-checkpoint gate is satisfied. |
| Event trigger | L2 conditional | `event_sensor`; only when a concrete event source is named and admissible. |
| Notification | L2 conditional | `notification`; required before detached, scheduled, recurring, or background work can block away from the parent surface, unless manual checkpoints are explicitly accepted. |
| External tools | L2 | `external_tool_provider` |
| Permission model | L2 | `permission_boundary` |
| Resume/recovery | L2/L1 | `lifecycle_recovery`, anchored back to `control.md` and `verification.md`. |

## Local Run Memory

When a runtime needs durable run state but the user has not named an external
workstream system, Kybernetes-created artifacts belong under:

```text
.kybernetes/<slug>/
```

This local run root is ignored by git and is not a production scheduler,
database, or orchestration service. It is a project-local control surface for
the current agent run: control records, checklists, worker reports, decision
notes, and verification reports.

Durable runs use a trust pair:

```text
control.md       current truth
verification.md  evidence truth
```

`events.jsonl` is deferred for v1. If it is added later, it is audit-only,
single-writer, ordered by append position, and never the source of current truth.

## Loop Contract

Every adapter should preserve the same loop-governor contract:

1. Establish the objective, DONE condition, current state, sensor/evidence, and
   stop condition before choosing a heavy process.
2. Select a loop altitude:
   - `stay` for direct local execution.
   - `down` for focused investigation or implementation inside a subsystem.
   - `up` for reframing scope, constraints, or architecture.
   - `stack` for bounded child loops, workers, peer workstreams, or isolated
     workspaces with return contracts.
   - `stop` when evidence says the loop should pause or hand back.
3. Record the active altitude and next activation point in the control record
   whenever the task is durable.
4. Treat verification as the sensor layer. If the sensor is missing or failing
   repeatedly, change altitude instead of continuing the same motion.

## Runtime Binding Matrix

Adapter work should be checked against:

```text
L2 Port | Runtime Binding | Portable Fallback | Evidence / State Obligation
```

The L2 port owns the product meaning. Runtime commands and app surfaces are
bindings, not architecture law. Availability, version, app/cloud caveats, and
chosen native fallback belong in L3 binding references.

## First Order

1. Required L2 contracts.
2. Core-neutrality enforcement.
3. Runtime binding references.
4. Portable runtime matrix.
5. Future runtime adapters.
