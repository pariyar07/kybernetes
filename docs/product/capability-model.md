# Capability Model

## North Star

Kybernetes can help an agent run a long or complex task as a feedback-controlled system: measurable, recoverable, explainable, and correctly sized to the work.

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
| Escalation | Move from action correction to plan reframing to durable learning. |
| Portability | Work without a specific knowledge system, while supporting optional adapters. |
| Loop readiness | Confirm setpoint, sensor/evidence, actuators, state, stop condition, and boundary before scaling. |
| Loop altitude | Choose whether to stay, go down, go up, stack bounded child loops, or stop. |
| Durability tier | Distinguish local skill runs, durable run memory, orchestrated workflows, and production loops. |
| Artifact recovery | Ensure resumes can find control records, evidence, worker state, decisions, and next activation. |

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
