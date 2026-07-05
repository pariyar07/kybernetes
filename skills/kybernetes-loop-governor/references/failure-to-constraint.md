# Failure-To-Constraint Workflow

Use this workflow when the same failure repeats, a verifier catches the same
class of mistake more than once, or review feedback says an agent should
"remember" a rule. The goal is not to add more reminders. The goal is to make the
desired behavior easier than the failure.

## Trigger

Run this workflow when any of these are true:

- The same verifier, review finding, user correction, or behavioral test scenario
  fails repeatedly.
- The loop governor is about to write the same instruction again.
- A lesson is supported by evidence and would apply to future runs.
- A missing boundary allowed the agent to touch the wrong file, path, API,
  authority level, user scope, or runtime surface.

Do not use this workflow for one-off preferences, speculative hunches, or
constraints that would be heavier than the observed risk.

## Constraint Ladder

Prefer the first proportionate enforceable option that can catch or prevent
recurrence:

1. **Executable verifier**: test, fixture, snapshot, validator, reproduction, or
   CI check.
2. **Structural boundary**: schema, type, parser, wrapper, helper, narrowed API,
   package boundary, or ownership boundary.
3. **Runtime guard**: assertion, permission check, feature flag, rate limit,
   sandbox, dry-run mode, or explicit approval gate.
4. **Process gate**: checklist item, control-record field, review gate,
   handoff-template field, or required decision surface.
5. **Documentation or memory**: repo instruction, skill rule, README note, or
   local memory. Use this only when enforceable constraints are unavailable,
   disproportionate, or outside current authority.

Prefer constraints that live closest to the failing system. A code failure should
usually become a test, type, boundary, or guard before it becomes a prose rule. A
coordination failure should usually become a control-record field, worker
contract field, activation template, or behavioral test scenario before it
becomes a global instruction.

## Procedure

1. Name the repeated failure and cite the evidence that made it real.
2. Identify the smallest future decision point where the failure could be caught.
3. Choose the first proportionate enforceable constraint from the ladder that
   fits that decision point.
4. Check authority and blast radius. Escalate to HITL before public APIs,
   production behavior, permissions, data retention, billing,
   customer-visible workflows, privacy/security posture, or team policy changes.
5. Implement or record the constraint candidate in the right surface.
6. Verify that the constraint would catch or prevent the repeated failure.
7. Record the outcome in the control record, `verification.md`, or an external
   workstream system if the user explicitly targeted one.

## Constraint Record Shape

When a durable record is useful, capture:

- Failure pattern.
- Evidence.
- Constraint chosen.
- Constraint owner and target surface.
- Why it is proportionate.
- Verification.
- HITL decision, if needed.
- Follow-up if the best constraint is outside current authority.

## Stop Conditions

Stop and ask the user when:

- Multiple constraints are plausible and the choice changes product or team
  behavior.
- The best constraint is irreversible, externally visible, security-sensitive, or
  production-affecting.
- Implementing the constraint would exceed the current objective.
- The failure evidence is too thin and the proposed constraint would create
  lasting process drag.
