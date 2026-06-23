# parallel-coordinator

A portable Agent Skill that turns any SKILL.md-compatible agent into a disciplined
coordinator for parallel / subagent work: one durable objective, a pre-flight plan
gate, the right execution substrate per slice, least-privilege workers, and a clean
stop condition. The full operating contract lives in
`references/goal-checklist.md` and is referenced (not pasted) wherever it's needed. The behavior is a feedback loop (a governor): it senses task size, right-sizes its own questions, steers via choices, and corrects toward the goal — see `references/operating-model.md`.

## Install

Copy the whole `parallel-coordinator/` folder into the tool's skills directory:

- **Codex** — `~/.codex/skills/` (personal), `.codex/skills/` (project), or
  `.agents/skills/` (scanned from cwd up to repo root). Invoke with
  `$parallel-coordinator` or `/skills`; restart Codex if it doesn't appear.
- **Claude Code** — `~/.claude/skills/` (personal) or `.claude/skills/` (project).
  Invoke by mentioning it, or let it match on description.
- **Other tools** (opencode, Cursor, etc.) — drop it in that tool's skills directory.
  SKILL.md is a cross-tool open standard, so the folder works unchanged; only the
  placeholder bindings differ (see `references/portable-core.md`).

## Use

1. Invoke the skill (or paste a launcher from the per-tool reference file).
2. It loads `references/goal-checklist.md` and binds to your tool via
   `references/codex.md`, `references/claude-code.md`, or `references/portable-core.md`.
3. It runs the pre-flight (decomposition, models, substrate, permissions, budget) and
   waits for your confirmation before spawning.

The Codex `/goal` (or the lead prompt in other tools) only needs the short launcher —
OBJECTIVE / DONE / VERIFY / DO-NOT-TOUCH — plus a pointer to the checklist file. That
keeps the contract in one place and stays under Codex's 4,000-char goal limit.

## Files
```
parallel-coordinator/
├── SKILL.md                       # entry point: the governor loop + triggers
├── INSPIRATION.md                 # what it is, how it works, how it self-improves (+ mermaid)
├── diagrams/                      # 1-governor-loop · 2-requisite-variety · 3-three-loops (.svg)
├── agents/openai.yaml             # Codex-only UI metadata + explicit-invocation policy
├── references/
│   ├── operating-model.md         # the cybernetic control model (read first)
│   ├── goal-checklist.md          # the operating contract / reference of record
│   ├── adaptive-elicitation.md    # right-size questions; steer with choices+recommendation
│   ├── portable-core.md           # placeholder→tool key + tool-agnostic launcher
│   ├── codex.md                   # Codex bindings, /goal file-reference, caveats
│   └── claude-code.md             # Claude Code bindings (Task tool, worktrees, no /goal)
└── README.md
```

## Not yet bound
`opencode` and `pi` aren't filled into the binding table yet — `portable-core.md` has the
blanks to complete. Tell me which "pi" you mean and I'll add verified columns.
