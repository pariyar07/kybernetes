---
name: 'kybernetes:verify-run'
description: 'Independently test a completion claim against DONE with explicit coverage, provenance, gaps, rerun instructions, and rejection authority.'
---

# Kybernetes Verify Run

This helper is an independent sensor with rejection authority over a completion
claim. It cannot mutate canonical lifecycle state, repair work silently, or
convert advisory consensus into proof. The governor admits the evidence and
owns completion.

## Required Inputs

- Objective and enumerated DONE criteria.
- Canonical revision and artifacts under test.
- Proposed verifier, environment, commands/rubric, and expected outcomes.
- Evidence pointers with provenance and timestamps.
- Producer identity and available checker independence.
- Permission boundary for read-only checks or explicitly authorized probes.
- Accountable owner and acceptance boundary when the tested work affects a
  dependent system or owner-held external decision.
- Known brownfield constraints, operational evidence, dependent systems, and
  unobservable gaps when visible code and tests may not cover the real contract.

## Verifier Types

- `deterministic`: tests, schemas, static checks, reproducible calculations.
- `external`: observed runtime, deployment, API, source, or third-party state.
- `subjective`: explicit rubric, evaluator, examples, threshold, and residual
  judgment.
- `human_acceptance`: named decision boundary and exact accepted scope.

Human acceptance may serve as the verifier only when the human is explicitly
named for that criterion. A technical or reviewer pass does not issue the
acceptance verdict for a dependent system.

Advisory reviews, generated lenses, popularity, and “looks good” are comparator
augmentation, not verification.

## Maker/Checker Separation

Record the maker/checker relationship. Prefer a separate context, worker,
method, source, or human for consequential work. Producer self-approval is not
sufficient above simple work. When true independence is unavailable, disclose
the limitation and strengthen deterministic or external evidence; otherwise
return `inconclusive`.

## Procedure

1. Map each DONE criterion to one or more checks.
2. Confirm artifact revision, environment, capability, and evidence freshness.
3. Run checks without modifying the artifact under evaluation.
4. Record exact outcome, coverage, provenance, gaps, and rerun instructions.
5. Reject completion on any failed criterion, stale material evidence,
   incomplete required coverage, or hidden subjective judgment.

## Result Model

- `pass`: all required criteria have admitted, current evidence.
- `fail`: at least one criterion is contradicted.
- `inconclusive`: method or evidence cannot discriminate sufficiently.
- `blocked`: verification cannot proceed because a required external boundary
  is unavailable; this is not canonical terminal blocked.
- `not_run`: a required check was not attempted.

Only `pass` may support completion, and the governor may still reject it for
revision, scope, provenance, or integration gaps.

## Output

```yaml
verification_result: pass | fail | inconclusive | blocked | not_run
canonical_revision: <tested revision>
maker_checker: <relationship and independence>
acceptance_status: not_required | pending | recorded
acceptance_owner: <accountable owner or none>
criteria:
  - id: <done criterion>
    result: <result>
    coverage: <what was and was not checked>
    evidence: <pointer and what it proves>
    provenance: <source, environment, time, revision>
gaps: []
rerun: [<exact instructions>]
residual_judgment: <none or explicit>
```

## Return To Governor

Return the immutable result packet. It does not issue the acceptance verdict.
The governor checks revision and scope, records the evidence in
`verification.md`, routes failures to correction, and requests or records the
owner verdict in `control.md` when required. The governor alone decides whether
canonical state may become `completed`.
