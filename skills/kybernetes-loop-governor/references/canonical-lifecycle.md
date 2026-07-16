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
| `completed` | DONE is supported by evidence recorded in `verification.md`. | no |

## Transition Constraints

- Recoverable states may return to `active`, move to another recoverable state,
  enter `verifying` or `recovering`, or become `superseded`.
- `completed` and `superseded` are terminal.
- `blocked_terminal` may become `superseded`; it does not resume as the same
  objective.
- A transition to `completed` requires admissible evidence in `verification.md`.
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

A native complete write is allowed only when `canonical_state == completed` and
`verification.md` records admissible evidence.

If the runtime lacks a safe transition, preserve canonical state, record the
mismatch, and use the portable fallback. Do not approximate pause, wait,
recovery, or verification with terminal blocked.

## Durable Record Fields

Record canonical state, previous state, transition reason, transition owner,
observation time, native state if known, divergence status, next activation, and
the evidence or decision permitting the next transition in `control.md`.
