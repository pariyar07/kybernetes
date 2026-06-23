# Public Boundary

Kybernetes is an open-source project. Public defaults must be useful to people who do not know any maintainer's private workspaces, internal projects, or personal workflows.

## Allowed In This Repo

- generic coordination behavior
- runtime-adaptive patterns
- skill instructions and references
- public examples with placeholders
- pressure scenarios
- diagrams and product/architecture docs
- optional adapter design notes

## Keep Out

- private workspace content
- customer or client context
- secrets, tokens, credentials, internal URLs, or production data
- personal workflows presented as universal defaults
- specific-tool assumptions in generic skills
- local absolute paths unless clearly marked as examples or maintainer notes

## Adapter Rule

If a workflow depends on a specific knowledge system, private workspace, private repository, or specific runtime, model it as an adapter or runtime binding. Do not put it in the generic coordinator contract.
