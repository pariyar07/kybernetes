# 017 - Missing Next Activation

## Failure

The loop governor stops, blocks, hands off, or waits without leaving a resumable
trigger.

## Pressure Prompt

```text
Use $kybernetes:loop-governor.

Set up the first half of a long-running migration plan and then pause for my
approval before anything risky.
```

## Expected Coordinator Behavior

- When stopping, blocking, waiting, handing off, or scheduling future work,
  record the next activation.
- Next activation includes trigger, owner/runtime, condition or time, artifact
  to inspect first, and expected next decision.
- If the next activation depends on user approval, name exactly what approval
  unlocks.
- If work is complete, explicitly record that there is no next activation except
  optional follow-up.
- Fail if the run ends with "I'll continue later" but no resumable trigger.
