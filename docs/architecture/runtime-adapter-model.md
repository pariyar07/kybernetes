# Runtime Adapter Model

Kybernetes separates the portable control model from runtime-specific primitives.
The loop governor skill should keep its loop semantics stable while each runtime
binds those semantics to the tools it actually has.

## Binding Slots

| Slot | Meaning |
| --- | --- |
| Skill namespace resolution | How the runtime invokes `kybernetes:loop-governor` and any future `kybernetes:*` skills. |
| Durable objective | How the runtime sets or simulates a persistent goal. |
| Worker spawn | How the runtime creates subagents or delegated workers. |
| Isolation | How concurrent writers avoid collisions. |
| Inspect | How the loop governor checks worker status. |
| Elicitation | How the loop governor asks for human steering. |
| Memory or control file | Where durable project or run state lives. |
| Verification | How commands, tests, validators, or manual evidence are captured. |
| Loop altitude | How the runtime records `stay`, `down`, `up`, `stack`, or `stop` decisions. |
| Durability tier | Whether the run uses chat memory only, `.kybernetes/<slug>/`, or an explicit external workstream surface. |

## Local Run Memory

When a runtime needs durable run state but the user has not named an external
workstream system, Kybernetes-created artifacts belong under:

```text
.kybernetes/<slug>/
```

This local run root is ignored by git and is not a production scheduler,
database, or orchestration service. It is a project-local control surface for
the current agent run: control records, checklists, worker reports, evidence,
decision notes, and verification reports.

## Loop Contract

Every adapter should preserve the same loop-governor contract:

1. Establish the objective, DONE condition, current state, sensor/evidence, and
   stop condition before choosing a heavy process.
2. Select a loop altitude:
   - `stay` for direct local execution.
   - `down` for focused investigation or implementation inside a subsystem.
   - `up` for reframing scope, constraints, or architecture.
   - `stack` for bounded child loops, workers, or parallel chats.
   - `stop` when evidence says the loop should pause or hand back.
3. Record the active altitude and next activation point in the control record
   whenever the task is durable.
4. Treat verification as the sensor layer. If the sensor is missing or failing
   repeatedly, change altitude instead of continuing the same motion.

## First Order

1. Codex
2. Claude Code
3. Portable core fallback
4. Future runtime adapters
