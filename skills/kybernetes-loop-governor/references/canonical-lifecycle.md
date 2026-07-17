# Canonical Lifecycle

Use this reference for durable runs, waits, terminal status writes, runtime
divergence, and migration. Kybernetes state is canonical. Native goal, thread,
task, hook, scheduler, worker, and progress state is advisory.

## States

| State | Meaning | Recoverable |
| --- | --- | --- |
| `designing` | Objective, verifier, boundary, or harness is still being established. | yes |
| `active` | The governor may select and perform the next bounded action. | yes |
| `waiting_human` | A named human answer, approval, or judgment is required. | yes |
| `waiting_time` | Work resumes at a recorded time or cadence. | yes |
| `waiting_event` | Work resumes when a recorded external event becomes admissible. | yes |
| `paused` | The owner deliberately suspended execution without ending the objective. | yes |
| `verifying` | Candidate output exists but DONE has not been admitted. | yes |
| `recovering` | Canonical and runtime state are being reconciled or migrated. | yes |
| `blocked_terminal` | No known answer, time, event, retry, fallback, or safe migration can resume the objective. | no |
| `superseded` | A new objective or canonical program replaced this run. | no |
| `completed` | DONE is supported by evidence in `verification.md` and any required accountable-owner verdict is recorded in `control.md`. | no |

## Transition Constraints

- Recoverable states may return to `active`, move to another recoverable state,
  enter `verifying` or `recovering`, or become `superseded`.
- `completed` and `superseded` are terminal.
- `blocked_terminal` may become `superseded`; it does not resume as the same
  objective.
- A transition to `completed` requires admissible evidence in `verification.md`.
  When the objective includes a dependent-system effect or accepted-completion
  claim, it also requires the accountable owner's verdict in `control.md`.
- A transition to `blocked_terminal` requires terminal-block proof in
  `control.md` and an exhausted or unsafe recovery path.

## Native Terminal Mirroring

Native terminal status is irreversible enough to require canonical proof.

Kybernetes MUST NOT mirror `waiting_human`, `waiting_time`, `waiting_event`,
`paused`, `recovering`, verifier-pending, provider-backoff, tool-unavailable, or
any other recoverable wait into a native terminal blocked state.

A native blocked write is allowed only when
`canonical_state == blocked_terminal`, the control record explains why the block
is terminal, no known answer, time, event, retry, fallback, or safe migration can
resume it, and recovery has failed or is unsafe.

A native complete write is allowed only when `canonical_state == completed`,
`verification.md` records admissible evidence, and any required acceptance
verdict is recorded in `control.md`.

If the runtime lacks a safe transition, preserve canonical state, record the
mismatch, and use the portable fallback. Do not approximate pause, wait,
recovery, or verification with terminal blocked.

## Durable Record Fields

Record canonical state, previous state, transition reason, transition owner,
observation time, native state if known, divergence status, next activation,
conditional acceptance boundary, and the evidence or decision permitting the
next transition in `control.md`.

## Runtime Divergence Recovery

1. Freeze new side effects.
2. Read `control.md`, then `verification.md`, then only reports needed to
   reconstruct current state.
3. Classify divergence as stale native state, missing native state, unsupported
   transition, conflicting state, or missing canonical state.
4. Reconcile to the smallest safe canonical continuation and verify it.
5. Repair the binding when safe and callable; otherwise create a fresh binding
   or migrate to portable foreground control.
6. Rebind required automations only after the new lead confirms canonical state.
7. Mark the old surface `superseded` and retire it when a safe path exists.

Retirement of an inaccessible old surface is not a prerequisite for recovery.
Record the residual stale surface and prevent new activations from reaching it.
