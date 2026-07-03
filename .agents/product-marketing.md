# Product Marketing Context

*Last updated: 2026-07-02*

## Product Overview
**One-liner:** Kybernetes is a runtime-adaptive control plane for agentic work.
**What it does:** Kybernetes helps coding agents and skill-compatible runtimes coordinate work through feedback loops: define a goal, check readiness, choose loop altitude, preserve durable control records, coordinate bounded workers when useful, surface impediments, and verify completion. Its first public artifact is the `kybernetes:loop-governor` skill.
**Product category:** Agentic engineering, coding-agent workflow, loop engineering, agent orchestration, open-source developer tooling.
**Product type:** Open-source developer tool and skill package.
**Business model:** OSS seed project. No pricing defined yet.

## Target Audience
**Target companies:** Early AI engineering teams, agentic-product builders, developer-tool teams, AI-native startups, and advanced solo builders using coding agents.
**Decision-makers:** Founders, staff/principal engineers, AI engineers, developer-experience leads, and technical OSS adopters.
**Primary use case:** Keep multi-step, ambiguous, risky, or long-running agent work on course.
**Jobs to be done:**
- Turn vague agent work into a governed loop with objective, done condition, verifier, boundary, and stop condition.
- Preserve state and evidence when chat context, workers, or runtime surfaces fragment.
- Coordinate workers or subagents only when bounded child loops create real leverage.
**Use cases:**
- Codex runs that need readiness, durable state, verification, and recovery.
- Multi-agent coding workflows where delegation needs contracts and return paths.
- Long-running implementation, research, refactor, or rollout work that should not depend only on chat memory.

## Personas
| Persona | Cares about | Challenge | Value we promise |
|---------|-------------|-----------|------------------|
| AI engineer | Reliable agent execution | Agents drift, over-plan, under-verify, and lose state | A portable control model for measurable, recoverable agent work |
| Founder/builder | Moving fast without chaos | AI tools increase speed but also coordination risk | A lightweight governor that scales process to task risk |
| OSS maintainer | Clear public defaults | Project workflows can leak private assumptions or runtime-specific behavior | Generic, open-source loop governance with adapter boundaries |
| Advanced coding-agent user | Better outcomes from Codex/Claude Code | Prompt-by-prompt steering does not survive long work | A skill that keeps goals, verification, state, and human gates explicit |

## Problems & Pain Points
**Core problem:** Coding agents are powerful, but their work often lacks a governed control loop.
**Why alternatives fall short:**
- Prompt craft depends on the user's memory and constant steering.
- Ad hoc checklists do not adapt to task risk or runtime capability.
- Generic orchestration can add process and workers before the task has a verifier or boundary.
- Chat-only state breaks when context compacts, work splits, or the user resumes later.
**What it costs them:** Rework, false completion, lost context, unsafe delegation, brittle handoffs, and low trust in agent summaries.
**Emotional tension:** Builders want speed from agents without feeling like the work is quietly drifting out of control.

## Competitive Landscape
**Direct:** Agent orchestration frameworks and coding-agent workflow tools that manage execution but may not provide a portable control contract.
**Secondary:** Prompt libraries, checklists, and runbooks that improve repeatability but are static and user-driven.
**Indirect:** Manual human steering, notes, TODOs, and chat history reconstruction.

## Differentiation
**Key differentiators:**
- Loop altitude vocabulary: `stay`, `down`, `up`, `stack`, `stop`.
- Readiness before machinery: objective, DONE, verifier, actuators, state, stop condition, and boundary.
- Durable trust pair: `control.md` as current truth and `verification.md` as evidence truth.
- Runtime-adaptive posture: Codex first, but designed for Claude Code and future skill-compatible runtimes.
- Public OSS boundary: private workflows and vault-specific assumptions stay behind optional adapters.
**How we do it differently:** Kybernetes treats agent work as a cybernetic control loop, not as a fixed checklist or blind worker fan-out.
**Why that's better:** It keeps small tasks small, makes serious tasks measurable, and stops when human judgment is the real bottleneck.
**Why customers choose us:** They want better agent judgment, durable state, and verification discipline without committing to one runtime or private knowledge system.

## Objections
| Objection | Response |
|-----------|----------|
| This sounds like extra process. | Kybernetes is explicitly designed to avoid over-processing small tasks. The core promise is the smallest sufficient control surface. |
| Is this just another checklist? | No. The checklist is only one possible surface. The product is the loop-governance contract: readiness, altitude, state, verification, and stop conditions. |
| Why not use a full orchestration framework? | Kybernetes starts as a portable control layer for agent work and can bind to runtime-specific or orchestration primitives later. |

**Anti-persona:** Users who want fully autonomous agents with no explicit boundaries, verification, or human approval for risky actions.

## Switching Dynamics
**Push:** Prompt-by-prompt agent management breaks during long, ambiguous, parallel, or resumable work.
**Pull:** A lightweight loop governor makes agent work feel measured, recoverable, and correctly sized.
**Habit:** Users keep relying on chat memory, manual checklists, and trust in final summaries.
**Anxiety:** Users may worry Kybernetes adds ceremony, slows them down, or only works in one runtime.

## Customer Language
**How they describe the problem:**
- "The agent says it's done, but I don't know what it actually verified."
- "I lost the thread after context got long."
- "Subagents help, but integrating their work is messy."
- "I want agents to keep moving without going off the rails."
**How they describe us:**
- "A loop governor for coding agents."
- "A control plane for agentic work."
- "A way to make agent work measurable and recoverable."
**Words to use:** loop engineering, control plane, loop governor, durable state, verification, bounded delegation, runtime-adaptive, agentic work, Codex, Claude Code.
**Words to avoid:** autonomous daemon, fully hands-off, magic agent, private-vault workflow, more process.
**Glossary:**
| Term | Meaning |
|------|---------|
| Loop altitude | The posture choice for the current work: stay, down, up, stack, or stop. |
| Durable control record | Project-local files that preserve objective, state, evidence, decisions, and next activation. |
| Verifier | The sensor that decides whether done is actually done. |
| Bounded child loop | A delegated work slice with owner, boundary, verifier, and return path. |

## Brand Voice
**Tone:** Clear, technical, thoughtful, restrained.
**Style:** Conversational but precise; product-led rather than hype-led.
**Personality:** Calm, serious, adaptive, open-source, human-in-the-loop.

## Proof Points
**Metrics:** None yet.
**Customers:** None yet.
**Testimonials:** None yet.
**Value themes:**
| Theme | Proof |
|-------|-------|
| OSS-ready seed | Public repo includes README, docs, install instructions, guardrails, examples, and pressure scenarios. |
| Current market timing | Loop engineering is being actively discussed in June and July 2026. |
| Clear first artifact | `kybernetes:loop-governor` is the first installable skill. |

## Goals
**Business goal:** Launch Kybernetes V1 as a credible open-source project in the loop-engineering conversation.
**Conversion action:** Read the origin essay, visit the GitHub repo, try/install the seed skill, star the repo, and give technical feedback.
**Current metrics:** Unknown.
