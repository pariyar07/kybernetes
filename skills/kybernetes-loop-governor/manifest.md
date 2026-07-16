# Run Manifest

The manifest is a portable reconstruction hint, not canonical state. Canonical
truth remains in `control.md`; evidence truth remains in `verification.md`.

Use this file shape at `.kybernetes/<slug>/manifest.md` for durable runs that
need optional modules, runtime binding, migration, or scheduled re-entry.

## Schema Revision 1

```yaml
schema_revision: 1
governor: kybernetes:loop-governor
canonical_record: .kybernetes/<slug>/control.md
verification_record: .kybernetes/<slug>/verification.md
canonical_revision: 7
selected_modules:
  - lifecycle
  - capability
  - activation
  - verification
runtime_binding: portable-core
observed_capabilities_at: 2026-07-17T12:00:00Z
```

Required fields:

- `schema_revision`: manifest schema understood by the installed governor.
- `governor`: the one canonical controller skill.
- `canonical_record`: current-state pointer.
- `verification_record`: evidence-state pointer.
- `canonical_revision`: revision modules and activations must match.
- `selected_modules`: reference-index module identifiers needed by this run.
- `runtime_binding`: one observed active binding or `portable-core`.
- `observed_capabilities_at`: timestamp of the callable-surface snapshot.

## Reconstruction

1. Read `control.md` and `verification.md`; they outrank the manifest.
2. Require `schema_revision: 1`. An unsupported or missing revision is stale.
3. Resolve every selected module through `references/reference-index.md`.
4. Load exactly one runtime binding and safely probe its callable surface.
5. Confirm `canonical_revision` before any new side effect.
6. Rewrite the manifest only through the active parent governor.

If the manifest is stale, incomplete, or names an unavailable required module,
freeze new side effects and reconcile from canonical state. Do not guess.

## Ephemeral Runs

Low-variety foreground work does not need a manifest. Medium work may use only
a checklist. Create this artifact when reconstruction across turns, runtimes,
activations, or child workstreams is a real requirement.
