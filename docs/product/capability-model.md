# Capability Model

## North Star

Kybernetes can help an agent run a long or complex task as a feedback-controlled system: measurable, recoverable, explainable, and correctly sized to the work.

These are target product properties. In v0.1, “shipped” means an instruction
contract, portable convention, example, pressure scenario, or deterministic
structural validator exists. It does not by itself prove comparative real-world
improvement.

## Capability Families

| Family | Product ability |
| --- | --- |
| Runtime sensing | Detect where the agent is running and choose the right runtime binding. |
| Adaptive intake | Ask only the questions needed to understand the task and its risk. |
| Execution profile | Shape an agent stance for the task without hardcoded personalities. |
| Durable control | Externalize active state into files that survive context loss. |
| Coordination | Decide between same chat, subagents, parallel chats / sibling threads, cloud tasks, or isolated workspaces. |
| Human steering | Surface intervention points with options and a recommendation. |
| Measurement | Define DONE and an admissible verifier before significant work. |
| Escalation | Move from action correction to plan reframing to durable constraints and learning. |
| Constraint promotion | Convert repeated failures into tests, boundaries, guards, gates, or other durable constraints before adding reminders. |
| Portability | Work without a specific knowledge system, while supporting optional adapters. |
| Loop readiness | Confirm setpoint, sensor/evidence, actuators, state, stop condition, and boundary before scaling. |
| Loop altitude | Choose whether to stay, go down, go up, stack bounded child loops, or stop. |
| Durability tier | Distinguish local skill runs, durable run memory, orchestrated workflows, and production loops. |
| Artifact recovery | Ensure resumes can find control records, evidence, worker state, decisions, and next activation. |
| Canonical lifecycle | Own recoverable and terminal program state independently of runtime goals, tasks, threads, hooks, workers, and progress UI. |
| Capability negotiation | Inspect the active callable surface, record a dated snapshot, and bind the smallest reliable runtime or portable fallback. |
| Lifecycle reconciliation | Detect native/canonical divergence, recover from the trust pair, and migrate to a fresh binding when native repair is unavailable. |
| Information-release boundary | Separate permission to invoke a tool from permission to release context through it; require bounded destination, purpose, payload, exclusions, handling, and fallback. |
| Accountable acceptance | Keep rejection-capable evidence separate from an owner-held verdict when work crosses a dependent-system, policy, publication, or external-effect boundary. |

The v0.1 contract covers every family above. Comparative quality, overhead,
external adoption, and cross-runtime behavioral parity remain unvalidated.

## Loop Altitude

- `stay`: current loop is shrinking the gap.
- `down`: gather evidence, reproduce, test, or narrow scope.
- `up`: plan, decompose, reframe, or ask for judgment.
- `stack`: create bounded child loops with owners, sensors, boundaries, and
  return paths.
- `stop`: finish, block, or escalate to human decision.

## Durability Tier

- Local skill run: no durable state unless useful.
- Durable run memory: `.kybernetes/<slug>/` files preserve state.
- Orchestrated workflow: runtime or external system provides checkpointing,
  retries, concurrency control, and inspection.
- Production loop: adds failure hooks, auditability, permissions, and
  observability.
