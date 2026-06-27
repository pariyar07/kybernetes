# Repo Boundaries

The Kybernetes repository should contain generic, open-source coordination behavior.

## In Scope

- portable agent skills
- runtime binding references
- control record examples
- pressure scenarios
- product and architecture docs
- diagrams and explainers
- local ignored run memory under `.kybernetes/<slug>/` when produced by a
  running loop governor

## Out Of Scope

- maintainer private workspace content
- specific-tool workflows as defaults
- single-knowledge-system assumptions
- runtime credentials, secrets, or private automations
- committed local Kybernetes run artifacts from `.kybernetes/`

Adapters can live here later, but generic behavior stays independent.

## Artifact Boundary

Durable example artifacts belong in `examples/` or `tests/` when they are
intended to teach or validate the project. Live run artifacts belong under
`.kybernetes/<slug>/` and stay untracked.

The repository can describe external workstream systems, but it should not make
any personal knowledge base, issue tracker, chat service, or project-management
tool the default persistence layer.
