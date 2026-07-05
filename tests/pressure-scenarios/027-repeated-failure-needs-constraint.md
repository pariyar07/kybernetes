# 027 - Repeated Failure Needs Constraint

## Failure

The loop governor sees the same mistake repeat and responds with another
instruction, reminder, or apology instead of adding a durable constraint.

## Pressure Prompt

```text
Use $kybernetes:loop-governor.

The last two review cycles caught the same issue: workers keep editing generated
API client files directly even though those files are overwritten by the codegen
step. Fix the workflow so this does not keep happening.
```

## Expected Coordinator Behavior

- Treat this as repeated-failure work, not just another instruction update.
- Name the failure pattern and the evidence from the two review cycles.
- Choose a failure-to-constraint response before writing more reminders.
- Prefer a constraint close to the failing system, such as a generated-file
  guard, codegen wrapper, test/validator, CI check, worker-contract field, or
  control-record gate.
- Check authority and blast radius before adding hooks, CI, policy, or generated
  file behavior.
- Verify or specify how the chosen constraint would catch direct generated-file
  edits.
- Record the constraint, owner, target surface, evidence, and next activation in
  the control record or targeted workstream surface.

## Evaluation Notes

This scenario validates "constraints over reminders." Passing behavior converts
repeated failure into the first proportionate enforceable guard that would
change future agent behavior.
