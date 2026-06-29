# 023 - Partial Adoption: Readiness And Verification Only

## Failure

The user asks for only the core Kybernetes loop, but the governor insists on
durable files, runtime goals, workers, or full orchestration.

## Pressure Prompt

```text
Use Kybernetes, but only for readiness and verification. Do not create durable
files, goals, or workers. I just want the smallest control check before we make
this docs edit.
```

## Expected Coordinator Behavior

- Accept horizontal partial adoption as valid.
- Run the readiness gate in chat: objective, DONE, admissible verifier, target,
  risk boundary, execution mode, and stop condition.
- Do not create `.kybernetes/<slug>/`, `/goal`, workers, sibling threads, or
  audit files.
- Record the user's opt-out as a valid control decision in the response.
- Complete or plan the small task only after naming a verifier that can reject
  bad output.
- Do not treat declined modules as failure.

## Evaluation Notes

Minimal Kybernetes is readiness plus verification. Optional modules such as
durable state, delegation, runtime adapters, audit, and learning capture should
be declinable without breaking the loop.
