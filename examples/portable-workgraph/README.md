# Portable Workgraph Example

This example illustrates the contract in
`skills/kybernetes-loop-governor/references/workgraph.md` without committing a
live `.kybernetes/` run. A parent at canonical revision 12 activates one
read-only evidence workstream. The child returns an inbox report; only the
parent validates and admits it.

```text
parent control revision 12
  -> workstream contract + activation act-044 + lease-018
  -> child-owned evidence
  -> inbox report-003
  -> parent dedupe, revision, lease, provenance, and verifier checks
  -> admit or quarantine
```

Duplicate delivery is a no-op. Revision drift, lease expiry, conflicting
content, or ownership overlap freezes new effects and routes to reconciliation.
