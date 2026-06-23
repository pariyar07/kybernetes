# The Inspiration

Kybernetes is named from Greek `kybernetes`: steersman, pilot, or governor. The same root leads to cybernetics: control and communication through feedback.

This project is not a checklist with extra steps. It is a small cybernetic control system for agentic work: hold a goal, sense the gap, act to close it, measure again, and correct, while regulating how much process the task actually needs.

## Where It Comes From

The lineage is short and load-bearing. Each idea maps to a concrete mechanism in Kybernetes.

- **Norbert Wiener — feedback.** A system steers toward a goal by feeding output back as input and acting on the error. In Kybernetes, DONE is the goal, VERIFY WITH is the measurement, and every checkpoint acts on the gap.
- **W. Ross Ashby — requisite variety.** Only variety absorbs variety. Kybernetes sizes its machinery and questions to the task: small task, little machinery; ambiguous or risky task, more control surface.
- **Stafford Beer — viable systems.** A viable coordinator needs operations, anti-collision coordination, resource control, environment sensing, and policy. Missing one predicts the failure.
- **Heinz von Foerster — second-order cybernetics.** The observer is part of the system. Kybernetes tracks whether its own model of the task still matches reality.
- **Argyris and Schon — learning loops.** Correct the action, then the plan, then the controller itself.

## Governor Loop

The human sets the reference; the coordinator closes the gap.

![Governor loop](docs/assets/diagrams/1-governor-loop.svg)

## Requisite Variety

The same principle sizes the machinery and the questions. The controller's variety must meet the task's; no more, no less.

![Requisite variety](docs/assets/diagrams/2-requisite-variety.svg)

## Three Loops

When the error stops shrinking, Kybernetes climbs a ladder instead of grinding:

- **Loop 1: regulate** — adjust the action toward the same goal.
- **Loop 2: reframe** — question the plan, decomposition, scope, execution profile, or goal.
- **Loop 3: learn** — persist the lesson so the next run starts smarter.

![Three loops](docs/assets/diagrams/3-three-loops.svg)

## Product Translation

The product thesis is:

```text
Agent work needs a steersman, not just a checklist.
```

Kybernetes should help an agent ask adaptive questions, hold durable state outside the chat, select the right execution mode, coordinate workers safely, surface human intervention points, verify completion, and retain useful learning.
