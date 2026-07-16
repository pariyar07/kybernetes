# Runtime-Adaptive Program Example

This portable example shows how one parent program can coordinate foreground
work, human approval, scheduled polling, event activation, peer workstreams, and
fresh-task migration without making any runtime primitive canonical.

```text
control.md + verification.md + manifest.md
  -> loop-architect proposes topology when uncertainty is consequential
  -> loop-governor admits the contract and owns canonical revision
  -> immediate work or bounded child activations write inbox reports
  -> waiting_human / waiting_time / waiting_event remain recoverable
  -> verify-run independently accepts or rejects DONE evidence
  -> capture-learning proposes constraints from repeated evidence
  -> loop-closeout checkpoints, migrates, or retires the program
```

Use continuous execution only while useful finite work is ready. When progress
depends on a person, time, or external event, checkpoint and activate from that
source. Ongoing programs consist of bounded cycles with explicit review and
retirement horizons; they are not one immortal native goal.

Each automation, schedule, event sensor, or task receives an activation ID,
expected canonical revision, effect key, budget, verifier, notification path,
and retirement condition. It reads parent state and reports evidence; only the
parent governor updates canonical truth.
