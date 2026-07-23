# Runtime Capability Negotiation

Use this reference before binding a consequential runtime surface and whenever
the selected binding fails or may have drifted.

## Evidence Classes

Keep documented official behavior, verified active runtime behavior,
reproducible local evidence, public reports, inference, and recommendation
separate. Product documentation is not proof of active agent-callable parity.

## Capability Snapshot

Record when relevant:

- `observed_at` and evidence source;
- activation identity and relevant execution context;
- runtime, version, provider, and plan when known;
- surface: CLI, app, cloud, SDK, headless, or portable;
- callable operations actually exposed;
- required, supported, and unsupported transitions;
- scheduler, event sensor, notification, worker, inspection, and recovery
  availability;
- probe performed and result;
- selected binding and portable fallback; and
- refresh trigger or known expiry.

Unknown is distinct from unsupported. Do not invent capability from silence,
documentation, another plan, or another surface.

## Negotiation Procedure

1. Classify semantic L2 ports and lifecycle transitions required by the task.
2. Inspect the active callable surface.
3. Reuse a dated snapshot only within the same activation while the relevant
   surface, context, and assumptions remain unchanged.
4. Every detached, scheduled, or fresh activation probes its own required
   agent-callable operations before depending on them. Another activation's
   probe is insufficient.
5. Run a safe probe only when read-only or reversible and proportionate. If no
   safe probe exists, record the capability as unknown and use its fallback.
6. Select the smallest binding supporting the required transitions.
7. Record unsupported transitions and the portable fallback.
8. Refresh after binding failure, relevant context change, runtime or plan
   change, suspected drift, or before relying on a consequential capability.

## Probe Boundary

A safe probe must not create a goal, automation, worker, external message,
deployment, payment, deletion, or persistent side effect merely to test
availability. Prefer tool-schema inspection, status reads, help output, or a
documented dry-run surface. Ask before a side-effecting probe.

## Failure Semantics

Report unavailable, unsupported, unknown, stale, denied, or divergent. Fall back
to portable canonical state, foreground execution, manual activation, or
fresh-task migration. Do not continue as if missing pause, resume, clear,
unblock, notification, or inspection exists.
