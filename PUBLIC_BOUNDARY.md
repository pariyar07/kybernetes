# Public Boundary

Kybernetes is an open-source project. Public defaults must be useful to people who do not know Satyam's vault, Ariadne, or private dogfooding workflows.

## Allowed In This Repo

- generic coordination behavior
- runtime-adaptive patterns
- skill instructions and references
- public examples with placeholders
- pressure scenarios
- diagrams and product/architecture docs
- optional adapter design notes

## Keep Out

- private vault content
- customer or client context
- secrets, tokens, credentials, internal URLs, or production data
- personal workflows presented as universal defaults
- Ariadne or Obsidian assumptions in generic skills
- local absolute paths unless clearly marked as examples or maintainer notes

## Adapter Rule

If a workflow depends on Ariadne, Obsidian, Satyam's Vault, a private repo, or a specific runtime, model it as an adapter or runtime binding. Do not put it in the generic coordinator contract.
