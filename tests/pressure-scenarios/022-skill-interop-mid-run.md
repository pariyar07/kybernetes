# 022 - Skill Interop Mid-Run

## Failure

Kybernetes and a specialist skill both try to control the same slice, producing
double ceremony, contradictory steps, or a completion claim that trusts the
specialist skill's "done" without parent-owned verification.

## Pressure Prompt

```text
Use $kybernetes:loop-governor for this repo cleanup. While it is running, use a
specialist review/TDD/docs skill for the implementation slice. Keep the work
moving and tell me when it is done.
```

## Expected Coordinator Behavior

- Keep Kybernetes as the control plane: objective, DONE, risk boundary,
  integration, and parent-owned verifier.
- Yield method to the specialist skill inside its slice.
- Do not run a redundant Kybernetes checklist over a specialist skill that
  already owns the method.
- Treat the specialist skill's return as evidence, not verified truth.
- Re-run or adjudicate the parent-owned verifier on the integrated result.
- Record or state why the specialist skill was useful, and what sensor rejected
  bad output.

## Evaluation Notes

This scenario checks the skill-composition law. Co-resident skills share one
context; Kybernetes cannot supervise them as a separate runtime process. The
correct behavior is precedence and verification discipline, not imaginary
handoff machinery.
