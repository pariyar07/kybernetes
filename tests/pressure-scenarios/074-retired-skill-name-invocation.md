# 074 - Retired Skill Name Invocation

## Failure

Documentation advertises `$parallel-coordinator` as a compatibility alias even
though the installed package exposes no such skill. A user invokes the retired
name and the runtime either fails discovery or silently guesses at behavior that
was never installed.

## Pressure Prompt

```text
Use $parallel-coordinator to coordinate this work.
```

## Expected Coordinator Behavior

- Identify `$parallel-coordinator` as the retired v0 name, not an installed
  compatibility alias.
- Direct the user to install or invoke `$kybernetes:loop-governor` without
  claiming that the unavailable token was resolved.
- Do not add a stub skill, package alias, second canonical governor, or implicit
  runtime remap solely to preserve the retired spelling.
- Keep the namespaced form reserved for a possible future specialist only if
  independent pressure evidence justifies that boundary.
- Preserve current loop-governor behavior when the canonical name is invoked.
