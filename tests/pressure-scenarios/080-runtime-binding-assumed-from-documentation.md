# 080 - Runtime Binding Assumed From Documentation

## Failure

A detached plan assumes that documented scheduling, local files, connectors,
workers, schedule mutation, and notification are callable inside the active
unattended run. The selected account and surface expose only a subset.

## Expected Coordinator Behavior

- Distinguish ChatGPT Work mode, Codex, Claude Code, and Claude Cowork surfaces.
- Require every activation, including each fresh scheduled run, to safely probe
  its own agent-callable operations before depending on them.
- Record unavailable and unknown capabilities without inventing parity.
- Fail closed for a missing or unknown operation and rebind to foreground, manual
  checkpoint, portable files, or an external trigger.
- Preserve canonical state and authority while changing runtime machinery.
