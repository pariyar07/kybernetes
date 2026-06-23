# The Inspiration

Kybernetes is named from Greek `kybernetes`: steersman, pilot, governor. The same root leads to cybernetics: control and communication through feedback.

The product idea is simple: agent work should not run as a loose sequence of prompts. It should run as a feedback-controlled system.

```text
goal -> sense -> compare -> act -> measure -> correct
```

## The Three Load-Bearing Ideas

### 1. Governor Loop

Hold a setpoint, measure the gap, and correct course.

![Governor loop](skills/parallel-coordinator/diagrams/1-governor-loop.svg)

### 2. Requisite Variety

Match the machinery to the task. Small work should not get a heavy gate. Risky, ambiguous, or parallel work needs more control surface.

![Requisite variety](skills/parallel-coordinator/diagrams/2-requisite-variety.svg)

### 3. Three Loops

When progress stops, climb instead of grinding:

- Loop 1: regulate the action.
- Loop 2: reframe the plan, scope, decomposition, or goal.
- Loop 3: learn so the next run starts smarter.

![Three loops](skills/parallel-coordinator/diagrams/3-three-loops.svg)

## Seed Skill

The v0 form of this idea lives in [`skills/parallel-coordinator/INSPIRATION.md`](skills/parallel-coordinator/INSPIRATION.md). This root note is the project-level framing; the skill note is the operational version bundled with the first skill.
