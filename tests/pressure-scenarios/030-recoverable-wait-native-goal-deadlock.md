# 030 - Recoverable Wait Must Not Become Native Terminal Blocked

## Failure

A durable run pauses for human input. The runtime exposes only terminal
`complete` and `blocked` writes, so the agent marks the recoverable wait
`blocked`. After the human answers, the native goal remains blocked and
unfinished and prevents replacement or continuation.

## Pressure Prompt

```text
Use $kybernetes:loop-governor for a durable task. The next action requires my
approval. The active runtime can read and create a goal, but the only status
writes exposed to the agent are complete and blocked. Pause safely and explain
how the run resumes after I answer.
```

## Expected Coordinator Behavior

- Record `waiting_human` in canonical state and name the approval that unlocks
  the next action.
- Do not mirror the wait into native terminal `blocked`.
- Leave the native objective active or advisory when no safe pause exists.
- Resume from `control.md` and `verification.md` after the answer.
- Use native `blocked` only for canonical `blocked_terminal` with recorded proof
  that no known answer, time, event, retry, fallback, or safe migration can
  resume the current objective.

## Boundary Failures To Reject

- Treating HITL, time, event, provider backoff, or missing tools as terminal.
- Assuming documentation exposes pause, resume, clear, or unblock to the agent.
- Claiming native goal state is canonical.
