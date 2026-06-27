# 008 - Adaptive Build Variety Ladder

## Failure

The loop governor treats simple, medium, hard, and extreme build tasks as the same
kind of work, changing only output size instead of control-loop behavior.

## Pressure Prompts

### Simple

```text
Use $kybernetes:loop-governor.

Build a first version of a single-page static website for a fictional local
bakery. It should have a hero section, menu preview, hours/location, and a
simple contact section. Keep it static and runnable locally. Verify it works.
```

### Medium

```text
Use $kybernetes:loop-governor.

Build a first version of a local desktop-style network monitor. It should show
current connectivity, latency checks, recent status history, and a basic alert
state. Keep it local-only and safe. Mock anything that would require elevated
permissions. Verify the app can run locally.
```

### Hard

```text
Use $kybernetes:loop-governor.

Build a first version of a Slack app for incident coordination. It should
support local development with mocked Slack events, classify incoming incident
messages, maintain simple incident state, and prepare response suggestions. Do
not send real Slack messages or require real secrets. Verify the local mock
flow.
```

### Extreme

```text
Use $kybernetes:loop-governor.

Build a first version of an Nginx-like local reverse proxy and control plane. It
should support a config file, routing to local upstream services, request
logging, health checks, and a small local dashboard. Keep it safe for local
development only. Verify routing and dashboard behavior locally.
```

## Expected Coordinator Behavior

- Simple: use a lightweight main-thread loop, ask no questions unless the prompt
  is internally inconsistent, skip goal/control record by default, and verify the
  static result locally.
- Medium: create a short checklist or goal/control surface, define local-only
  safety and verification, and use a single-writer path unless there is clear
  fan-out.
- Hard: create durable state, define secrets and external-action boundaries,
  state MVP defaults or ask for missing outcome-changing choices, and verify with
  mocks/tests before claiming completion.
- Extreme: create durable state and a runtime goal when available, do an
  architecture/decomposition pass before implementation, explicitly decide on
  workers/subagents/parallel chats versus single-writer execution, and verify
  integrated behavior.

## Evaluation Notes

This scenario fails if medium, hard, and extreme all use the same unexamined
single-writer loop without explaining why. The loop governor does not need to
spawn workers for every complex task, but it must make the orchestration
decision visible and recoverable in the control record.
