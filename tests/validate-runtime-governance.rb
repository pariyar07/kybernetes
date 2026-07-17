#!/usr/bin/env ruby

def require_file(path)
  abort("missing required file: #{path}") unless File.file?(path)
  File.read(path)
end

def require_terms(path, content, terms)
  missing = terms.reject { |term| content.include?(term) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
end

lifecycle_path =
  "skills/kybernetes-loop-governor/references/canonical-lifecycle.md"
lifecycle = require_file(lifecycle_path)

states = %w[
  designing active waiting_human waiting_time waiting_event paused verifying
  recovering blocked_terminal superseded completed
]

require_terms(lifecycle_path, lifecycle, states)
require_terms(
  lifecycle_path,
  lifecycle,
  [
    "MUST NOT mirror",
    "canonical_state == blocked_terminal",
    "canonical_state == completed",
    "control.md",
    "verification.md",
  ],
)

capability_path =
  "skills/kybernetes-loop-governor/references/capability-negotiation.md"
capability = require_file(capability_path)

require_terms(
  capability_path,
  capability,
  [
    "observed_at",
    "surface",
    "callable operations",
    "supported transitions",
    "unsupported transitions",
    "portable fallback",
    "documentation is not proof",
    "safe probe",
  ],
)

require_terms(
  lifecycle_path,
  lifecycle,
  [
    "Freeze new side effects",
    "Classify divergence",
    "fresh binding",
    "superseded",
    "Rebind",
  ],
)

governor_path = "skills/kybernetes-loop-governor/SKILL.md"
governor = require_file(governor_path)
ports_path = "docs/architecture/l2-port-contracts.md"
ports = require_file(ports_path)
rubric_path =
  "skills/kybernetes-loop-governor/references/runtime-use-rubric.md"
rubric = require_file(rubric_path)
checklist_path =
  "skills/kybernetes-loop-governor/references/goal-checklist.md"
checklist = require_file(checklist_path)
scenario_path =
  "tests/pressure-scenarios/069-unbounded-information-release.md"
scenario = require_file(scenario_path)
simple_path =
  "tests/pressure-scenarios/024-over-gating-authorized-simple-task.md"
simple = require_file(simple_path)
matrix_path = "docs/architecture/portable-runtime-matrix.md"
matrix = require_file(matrix_path)
codex_path = "skills/kybernetes-loop-governor/references/codex.md"
codex = require_file(codex_path)
claude_path = "skills/kybernetes-loop-governor/references/claude-code.md"
claude = require_file(claude_path)

require_terms(governor_path, governor, ["information release"])
require_terms(
  ports_path,
  ports,
  [
    "minimum necessary payload",
    "Permission to invoke a tool",
    "local or no-send fallback",
  ],
)
require_terms(
  rubric_path,
  rubric,
  ["destination", "payload scope", "local-only work"],
)
require_terms(checklist_path, checklist, ["information release"])
require_terms(
  scenario_path,
  scenario,
  [
    "minimum necessary payload",
    "specific release decision",
    "Fail closed before release",
    "Local-only, reversible work",
  ],
)
require_terms(simple_path, simple, ["does not release information"])
require_terms(
  matrix_path,
  matrix,
  ["Tool permission does not authorize unbounded information release", "payload scope"],
)
[codex_path, claude_path].zip([codex, claude]).each do |path, content|
  require_terms(path, content, ["unbounded information-release actions", "payload scope"])
end

puts "runtime governance validation passed"
