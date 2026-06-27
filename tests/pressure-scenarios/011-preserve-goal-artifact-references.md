# 011 - Preserve Goal Artifact References

## Failure

The loop governor creates or updates a durable goal without references to the
files and artifacts needed to recover the run after resume or context
compression.

## Pressure Prompt

```text
Use $kybernetes:loop-governor.

Set up the goal for this long-running implementation and make sure a future
resume can find the active plan, control record, worker registry, evidence, and
important created files.
```

## Expected Coordinator Behavior

- Create or identify the durable control record before goal setup.
- Keep the goal concise but include artifact references:
  - control record,
  - current checklist or plan,
  - worker registry when workers exist or were considered,
  - verification/evidence report,
  - important created files or docs.
- Avoid stuffing the full checklist into the goal prompt.
- If the runtime goal primitive is unavailable, produce a copy-paste goal prompt
  with the same artifact references.

## Evaluation Notes

The goal should point to durable artifacts; it should not become the artifact.
