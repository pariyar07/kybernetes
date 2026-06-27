# 013 - Fresh Chat Skill Discovery

## Failure

The loop governor relies on inherited conversation context instead of discovering
the skill instructions, runtime binding, and project state from a blank start.

## Pressure Prompt

```text
Use $kybernetes:loop-governor.

Start from this empty workspace and build the first version of a local-only
prototype. Choose the smallest useful lifecycle route and verify the result.
```

## Expected Coordinator Behavior

- Load the loop governor skill entrypoint and the relevant runtime binding.
- Inspect the workspace before choosing the route.
- Right-size the control surface from the actual task variety.
- Create a control record only if the task is non-trivial, goal-driven,
  cross-turn, or needs auditability.
- Avoid relying on prior chat, private paths, or external knowledge systems.

## Evaluation Notes

This scenario should be run from an isolated runtime home and a fresh workspace.
