# ChatGPT Work Mode Binding

## Activation Binding

Web schedules may start a fresh chat or return to an existing chat. Web runs may
use uploaded context, connected tools, skills, and plugins available to that chat,
but do not retain a local folder or worktree. Treat tool availability per scheduled
run as a capability observation, not a product-wide guarantee.

## Trajectory Binding

Evaluate trajectory from admitted observations and portable state. Same-chat
context may aid reconstruction but is not canonical. A standalone scheduled run
must receive the control pointer, strategy identity, expected revision, progress
window, and report path in its durable prompt or accessible project material.

## Capability Probe

Every activation, including each fresh or scheduled run, must safely inspect or
test its own agent-callable schedule create/update/pause/delete, connected tools,
skills/plugins, notification destination, browser access, worker creation, and
source-material access before depending on them. A pre-detachment probe or an
observation from another activation is not sufficient.

## Schedule Mutation

Create or update cadence only when the schedule tool is exposed and the mutation
falls inside the approved strategy envelope. Otherwise write a strategy directive
and ask the owner to update the schedule.

## Portable Fallback

If a required capability is unavailable or unknown in that activation, fail
closed for the dependent operation and use a foreground chat, explicit manual
checkpoint, connected durable source, or external trigger. Do not claim access
to local files, another chat's native state, or unavailable connectors.

## Documentation Evidence

Checked 2026-07-23: OpenAI [Scheduled tasks](https://learn.chatgpt.com/docs/automations),
[Subagents](https://learn.chatgpt.com/docs/agent-configuration/subagents),
[Browser](https://learn.chatgpt.com/docs/browser),
[Chrome extension](https://learn.chatgpt.com/docs/chrome-extension),
[Computer Use](https://learn.chatgpt.com/docs/computer-use), and
[Git worktrees](https://learn.chatgpt.com/docs/environments/git-worktrees).
These pages describe supported user surfaces; they do not prove that an operation
is callable in the active run. Documentation is not proof of agent-callable
capability.
