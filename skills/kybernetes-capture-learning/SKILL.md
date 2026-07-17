---
name: 'kybernetes:capture-learning'
description: 'Convert repeated or high-confidence failure evidence into reviewable, scoped, enforceable learning proposals without silently rewriting governance.'
---

# Kybernetes Capture Learning

This helper proposes controller improvements. It cannot mutate canonical state,
edit governance, activate hooks, or promote its own recommendation. The governor
or authorized human reviews and applies accepted changes.

## Required Inputs

- Observation, affected objective, and exact failure or success signal.
- Evidence pointers, recurrence count, severity, and causal confidence.
- Existing rule or constraint and why it did not prevent the outcome.
- Candidate scope, owners, affected users/systems, and policy boundary.
- Available test, schema, guard, hook, permission, or interface mechanisms.

## Classify

- `observation`: one local event with no reusable claim yet.
- `candidate`: evidence suggests recurrence or a strong causal mechanism.
- `promote`: the accountable owner accepts a scoped constraint and its
  validation/rollback.
- `reject`: evidence, proportionality, or causality is insufficient.
- `defer`: more observations or authority are required.

A one-off event is normally an observation. Severe security, privacy, data-loss,
or irreversible risk may justify immediate candidate review, but not silent
global policy.

## Double-Loop Test

Ask whether to:

1. regulate the next action under the current setpoint;
2. reframe the plan, decomposition, verifier, or setpoint; or
3. change the controller with a reusable constraint.

Promote only when controller change is supported by evidence and recurrence or
clear causal severity.

## Constraint Selection

Prefer the first proportionate enforceable constraint: test, fixture, schema,
type, parser, API boundary, wrapper, lint, hook, CI guard, permission boundary,
or checklist gate. Use prose only when enforcement is unavailable or
disproportionate, and record why.

Escalate before proposals affecting public APIs, production behavior,
permissions, privacy, security, retention, billing, external communication, or
team policy.

## Promotion Packet

```yaml
learning_status: observation | candidate | promote | reject | defer
claim: <reusable learning>
evidence: <pointers and what each proves>
recurrence: <count and contexts>
causal_confidence: low | medium | high
scope: <local, repository, runtime binding, or product>
enforceable_constraint: <specific mechanism>
validation: <test that can reject the constraint>
rollback: <how to remove or reverse safely>
owner: <responsible boundary>
owner_approval: pending | accepted | narrowed | rejected
revalidation: <time, version, failure, or capability-drift trigger>
supersedes: <prior rule or none>
risks: <false positives, cost, rigidity, policy effects>
```

Constraints require a rejection-capable validation and a rollback. Promoted
learning remains revisable: current contradictory evidence triggers
revalidation, revision, or explicit supersession with provenance preserved.
Until the accountable owner records approval for the proposed scope, the
learning must remain a proposal and cannot mutate governance or shared policy.

## Return To Governor

Return the packet and do not edit target files. The governor checks scope,
authority, owner approval, evidence, proportionality, and verification; requests
HITL where required; then accepts, rejects, defers, or routes implementation
through the normal tested change process.
