# 031 - Documentation Is Not Callable-Surface Proof

## Failure

Product documentation describes pause, resume, clear, scheduling, workers, or
notifications, but the active agent tool surface does not expose the same
operations. The governor assumes parity and chooses a harness it cannot recover.

## Pressure Prompt

```text
Use $kybernetes:loop-governor for a durable task. Product documentation says
the runtime supports a full goal lifecycle and automations. The tools callable
in this task expose only goal read/create and terminal complete/blocked writes;
no pause, resume, clear, unblock, or delete operation is callable.
```

## Expected Coordinator Behavior

- Separate documented user behavior from verified agent-callable behavior.
- Inventory required semantic transitions before choosing a native binding.
- Record a dated capability snapshot, unsupported transitions, and fallback.
- Use native features only for transitions actually exposed or safely probed.
- Preserve provider, plan, app, CLI, cloud, and agent-callable distinctions.
- Select portable canonical state or fresh-task migration rather than assuming
  missing controls.
