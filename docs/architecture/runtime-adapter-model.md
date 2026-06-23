# Runtime Adapter Model

Kybernetes separates the portable control model from runtime-specific primitives.

## Binding Slots

| Slot | Meaning |
| --- | --- |
| Durable objective | How the runtime sets or simulates a persistent goal. |
| Worker spawn | How the runtime creates subagents or delegated workers. |
| Isolation | How concurrent writers avoid collisions. |
| Inspect | How the coordinator checks worker status. |
| Elicitation | How the coordinator asks for human steering. |
| Memory or control file | Where durable project or run state lives. |
| Verification | How commands, tests, validators, or manual evidence are captured. |

## First Order

1. Codex
2. Claude Code
3. Portable core fallback
4. Future runtime adapters
