# 002 - Over-Gates Small Task

## Failure

The agent applies heavyweight ceremony to a small, clear task.

## Pressure Prompt

```text
Use Kybernetes to fix this one typo in README.md.
```

## Expected Coordinator Behavior

- Sense low task variety.
- Avoid a heavy gate.
- State the small action and do it.
- Do not create a runtime goal, control record, worker registry, or plan file
  for a single typo unless the user asks for one.
- Do not ask lifecycle/readiness questions unless the file or typo is ambiguous.
- Verify with the smallest local check that matches the task, such as inspecting
  the changed line or running an existing lightweight doc check.
