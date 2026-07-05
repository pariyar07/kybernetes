# Layered Runtime Substrate

This is the repo-side legend for Kybernetes runtime-layer terms. It explains the
accepted layer stack so architecture docs can say `L0`, `L1`, or `L2` without
making readers hunt through external notes.

This page is explanatory only. It does not create new architecture; it names the
layers already assumed by the loop-governor skill, runtime adapter model, and L2
port contracts.

## Layer Summary

| Layer | Name | Owns | Does not own |
| --- | --- | --- | --- |
| L0 | Control Kernel | Objective, DONE condition, sensor choice, comparator, actuator choice, loop readiness, altitude, HITL, stop condition, and learning gate. | Runtime commands, provider-specific features, plugin paths, app version caveats, or packaging details. |
| L1 | State And Evidence Substrate | `control.md`, `verification.md`, checklists, decisions, worker briefs or reports, next activation, and recovery order. | Runtime memory, transcripts, UI task state, audit logs, or goals as source of truth unless mirrored. |
| L2 | Capability Ports | Runtime-neutral semantic capabilities such as durable objective, planning surface, worker spawn, isolation, verification sensor, elicitation, permission boundary, lifecycle recovery, and skill package. | Native command names or runtime availability claims. |
| L3 | Runtime Bindings | Mapping L2 ports to concrete runtime surfaces, caveats, availability, app/cloud behavior, and native fallbacks. | Core semantics, cross-runtime laws, or canonical state. |
| L4 | Execution Patterns | Compositions of ports such as single-writer loops, bounded workers, peer workstreams, scheduled activation, event-triggered activation, and recovery workflows. | New product primitives unless pressure evidence proves they generalize. |
| L5 | Distribution And Packaging | Public skill packaging, plugin wrappers, SDK or CLI helpers, examples, and install docs. | Mandatory private workflow assumptions or unproven heavy machinery. |
| L6 | Product Workflows | Pressure scenarios, launch docs, recipes, domain adapters, and optional private project adapters. | Generic core rules or runtime-specific implementation details. |

## How To Read The Layers

L0 decides what control move is appropriate. If the setpoint or verifier is
unclear, L0 chooses to ask, inspect, plan, descend, stop, or use a smaller loop
before adding machinery.

L1 preserves what future humans and agents can trust. Runtime state can be
useful, but durable recovery re-anchors on the trust pair:

```text
control.md       current truth
verification.md  evidence truth
```

L2 names the capability the control kernel needs without naming a runtime. For
example, the core asks for `planning_surface` or `verification_sensor`; it does
not ask for a specific command.

L3 decides how a concrete runtime satisfies an L2 port. Native command names,
availability, caveats, and runtime-specific fallback choices belong here.

L4 combines ports into patterns. A scheduled loop, worker fan-out, or recovery
workflow is not a new core law by default; it is a pattern that composes lower
layers.

L5 packages the behavior for installation and reuse. L6 documents product-facing
workflows and pressure evidence.

## Repo Map

- L0/L1 behavior lives primarily in
  [`skills/kybernetes-loop-governor/SKILL.md`](../../skills/kybernetes-loop-governor/SKILL.md)
  and
  [`skills/kybernetes-loop-governor/references/goal-checklist.md`](../../skills/kybernetes-loop-governor/references/goal-checklist.md).
- L2 required port contracts live in
  [`l2-port-contracts.md`](l2-port-contracts.md).
- L2-to-L3 adapter placement lives in
  [`runtime-adapter-model.md`](runtime-adapter-model.md).
- Runtime crosswalks live in
  [`portable-runtime-matrix.md`](portable-runtime-matrix.md) and the runtime
  binding references under
  [`skills/kybernetes-loop-governor/references/`](../../skills/kybernetes-loop-governor/references/).

## Boundary Rule

When adding or changing behavior, place it at the lowest layer that owns the
meaning:

- If it changes readiness, altitude, verifier admissibility, HITL, or stop
  behavior, it is L0.
- If it changes durable recovery or evidence truth, it is L1.
- If it names a portable capability, fallback, failure semantic, or state
  obligation, it is L2.
- If it names a runtime feature, version caveat, command, app/cloud behavior, or
  native fallback, it is L3.
- If it composes several capabilities into a reusable motion, it is L4.
- If it changes install, packaging, examples, or release shape, it is L5.
- If it is a product-facing recipe, pressure scenario, launch note, or domain
  adapter, it is L6.
