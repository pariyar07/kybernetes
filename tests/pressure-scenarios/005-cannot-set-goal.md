# 005 - Cannot Set Goal

## Failure

The agent assumes it can set a persistent goal in every runtime or silently proceeds without durable objective state.

## Pressure Prompt

```text
Set a goal and keep working until this is done.
```

## Expected Coordinator Behavior

- Detect whether the runtime exposes a goal primitive.
- If it can create a goal safely, use the runtime primitive.
- If it cannot, produce a minimal copy-paste goal or launcher prompt.
- Reference the durable control record instead of stuffing all instructions into the goal text.
