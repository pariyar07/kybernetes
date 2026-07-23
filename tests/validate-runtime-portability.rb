#!/usr/bin/env ruby

REQUIRED_BINDING_HEADINGS = [
  "Activation Binding",
  "Trajectory Binding",
  "Capability Probe",
  "Portable Fallback",
  "Documentation Evidence",
].freeze

PORTABLE_CORE_HEADINGS = [
  "Activation Binding",
  "Trajectory Binding",
  "Capability Probe",
  "Portable Fallback",
  "Portable Core Baseline",
].freeze

RUNTIME_BINDINGS = {
  "chatgpt-work" => "chatgpt-work.md",
  "codex" => "codex.md",
  "claude-code" => "claude-code.md",
  "claude-cowork" => "claude-cowork.md",
}.freeze

HOSTED_BINDINGS = %w[chatgpt-work claude-cowork].freeze

PROGRAM_PROMPT_TERMS = [
  "Program kind: <finite | continuing>",
  "Done or health: <measurable finite DONE | continuing health invariant>",
  "Finite completion verifier: <verification | not_applicable>",
  "Continuing review horizon: <bounded review/renewal point | not_applicable>",
  "Continuing cycle verifier: <rejection-capable health check | not_applicable>",
  "Finite rule: stop only after the completion verifier accepts measurable done_or_health",
  "Continuing rule: verify each bounded cycle with cycle_verifier",
  "keep the program open through review_horizon",
  "never treat a healthy cycle as completion of the continuing program",
].freeze

DURABLE_PROGRAM_TERMS = [
  "`program_kind`",
  "`done_or_health`",
  "finite completion verifier",
  "continuing health invariant",
  "`review_horizon`",
  "`cycle_verifier`",
  "A healthy cycle never completes the continuing program",
].freeze

ACTIVATION_PROGRAM_TERMS = [
  "Program kind and `done_or_health`",
  "measurable DONE for finite work",
  "health invariant for continuing work",
  "finite completion verifier",
  "continuing `review_horizon` and `cycle_verifier`",
  "A healthy cycle never completes the continuing program",
].freeze

PORTABLE_BASELINE_PORTS = %w[
  durable_objective
  planning_surface
  progress_surface
  worker_spawn
  isolation
  inspect_status
  verification_sensor
  external_tool_provider
  elicitation
  permission_boundary
  lifecycle_recovery
  skill_package
].freeze

def require_file(path)
  abort("missing required file: #{path}") unless File.file?(path)
  File.read(path)
end

def require_terms(path, content, terms)
  normalized_content = content.gsub(/\s+/, " ")
  missing = terms.reject { |term| normalized_content.include?(term.gsub(/\s+/, " ")) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
end

def reject_terms(path, content, terms)
  normalized_content = content.gsub(/\s+/, " ")
  present = terms.select { |term| normalized_content.include?(term.gsub(/\s+/, " ")) }
  abort("#{path} must not contain: #{present.join(', ')}") unless present.empty?
end

def section(path, content, heading)
  heading_line = "## #{heading}"
  lines = content.lines(chomp: true)
  indexes = lines.each_index.select { |index| lines[index] == heading_line }
  unless indexes.length == 1
    abort("#{path} expected exactly one #{heading_line.inspect} heading, found #{indexes.length}")
  end

  start_index = indexes.first + 1
  end_index = (start_index...lines.length).find { |index| lines[index].start_with?("## ") } || lines.length
  body = lines[start_index...end_index].join("\n").strip
  abort("#{path} has an empty #{heading_line.inspect} section") if body.empty?
  body
end

def bullet(path, content, label)
  prefix = "- `#{label}`:"
  lines = content.lines(chomp: true)
  indexes = lines.each_index.select { |index| lines[index].start_with?(prefix) }
  unless indexes.length == 1
    abort("#{path} expected exactly one #{prefix.inspect} bullet, found #{indexes.length}")
  end

  start_index = indexes.first
  end_index = ((start_index + 1)...lines.length).find do |index|
    lines[index].start_with?("- `") || lines[index].empty?
  end || lines.length
  lines[start_index...end_index].join("\n").strip
end

def table_row(path, content, key)
  pattern = /^\| `#{Regexp.escape(key)}` \|/
  rows = content.lines(chomp: true).select { |line| line.match?(pattern) }
  unless rows.length == 1
    abort("#{path} expected exactly one #{key.inspect} table row, found #{rows.length}")
  end

  rows.first
end

def require_portable_baseline(path, content)
  rows = content.lines(chomp: true).map do |line|
    match = line.match(/^\| `([^`]+)` \| .+ \|$/)
    match && match[1]
  end.compact
  unless rows == PORTABLE_BASELINE_PORTS
    abort("#{path} portable baseline ports must be exactly #{PORTABLE_BASELINE_PORTS.join(', ')}; found #{rows.join(', ')}")
  end
end

def require_safe_activation_invariants(path, sections)
  probe = sections.fetch("Capability Probe")
  require_terms(
    path,
    probe,
    [
      "Every activation",
      "safely inspect or test its own agent-callable",
      "before depending on them",
      "pre-detachment probe",
      "not sufficient",
    ],
  )

  fallback = sections.fetch("Portable Fallback")
  require_terms(
    path,
    fallback,
    ["unavailable or unknown in that activation", "fail closed"],
  )
end

binding_contents = {}
binding_sections = {}

RUNTIME_BINDINGS.each do |name, filename|
  path = "skills/kybernetes-loop-governor/references/#{filename}"
  content = require_file(path)
  sections = REQUIRED_BINDING_HEADINGS.to_h do |heading|
    [heading, section(path, content, heading)]
  end

  require_terms(path, content, ["2026-07-23"])
  require_terms(
    path,
    sections.fetch("Documentation Evidence"),
    ["Documentation is not proof of agent-callable capability."],
  )
  require_safe_activation_invariants(path, sections)
  binding_contents[name] = content
  binding_sections[name] = sections
end

HOSTED_BINDINGS.each do |name|
  path = "skills/kybernetes-loop-governor/references/#{RUNTIME_BINDINGS.fetch(name)}"
  content = binding_contents.fetch(name)
  baseline = section(path, content, "Portable Core Baseline")
  require_terms(
    path,
    baseline,
    [
      "incorporated baseline",
      "sufficient as the sole L3 binding",
      "do not load `portable-core.md` as a second runtime binding",
    ],
  )
  require_portable_baseline(path, baseline)
end

chatgpt_path = "skills/kybernetes-loop-governor/references/chatgpt-work.md"
require_terms(
  chatgpt_path,
  binding_sections.fetch("chatgpt-work").fetch("Capability Probe"),
  ["unattended sandbox, permission, and approval behavior"],
)

unless binding_contents.values.uniq.length == RUNTIME_BINDINGS.length
  abort("named runtime binding contents must be distinct")
end

REQUIRED_BINDING_HEADINGS.each do |heading|
  normalized_bodies = binding_sections.transform_values do |sections|
    sections.fetch(heading).gsub(/\s+/, " ").strip
  end
  next if normalized_bodies.values.uniq.length == RUNTIME_BINDINGS.length

  abort("named runtime bindings must have distinct #{heading.inspect} contents")
end

%w[codex claude-code].each do |name|
  path = "skills/kybernetes-loop-governor/references/#{RUNTIME_BINDINGS.fetch(name)}"
  content = binding_contents.fetch(name)
  durable_row = table_row(path, content, "durable_objective")
  require_terms(path, durable_row, DURABLE_PROGRAM_TERMS)

  split = section(path, content, "Verification And Comparator Split")
  completion_sensor = bullet(path, split, "verification_sensor")
  require_terms(
    path,
    completion_sensor,
    ["finite output", "measurable DONE", "`verification.md`", "completion-only"],
  )
  reject_terms(
    path,
    completion_sensor,
    ["continuing cycle", "health invariant", "cycle_verifier"],
  )
  require_terms(
    path,
    split,
    [
      "Continuing `cycle_verifier` results are not `verification_sensor` output",
      "current cycle verdict in `control.md`",
      "durable multi-window history in `trajectory.md`",
      "a healthy cycle keeps the continuing program open",
    ],
  )
end

codex_path = "skills/kybernetes-loop-governor/references/codex.md"
codex_goal_prompt = section(codex_path, binding_contents.fetch("codex"), "Minimal `/goal` Prompt")
codex_launcher = section(codex_path, binding_contents.fetch("codex"), "Copy-Paste Launcher")
[codex_goal_prompt, codex_launcher].each do |prompt|
  require_terms(codex_path, prompt, PROGRAM_PROMPT_TERMS)
  reject_terms(codex_path, prompt, ["Done when:", "Verify with:"])
end
require_terms(
  codex_path,
  section(codex_path, binding_contents.fetch("codex"), "Automations"),
  ACTIVATION_PROGRAM_TERMS,
)

claude_path = "skills/kybernetes-loop-governor/references/claude-code.md"
claude_lead_prompt = section(claude_path, binding_contents.fetch("claude-code"), "Lead Prompt Shape")
require_terms(claude_path, claude_lead_prompt, PROGRAM_PROMPT_TERMS)
reject_terms(claude_path, claude_lead_prompt, ["Done when:", "Verify with:"])
require_terms(
  claude_path,
  section(claude_path, binding_contents.fetch("claude-code"), "Scheduled Or Detached Work"),
  ACTIVATION_PROGRAM_TERMS,
)

portable_path = "skills/kybernetes-loop-governor/references/portable-core.md"
portable_content = require_file(portable_path)
portable_sections = PORTABLE_CORE_HEADINGS.to_h do |heading|
  [heading, section(portable_path, portable_content, heading)]
end
require_safe_activation_invariants(portable_path, portable_sections)
require_portable_baseline(
  portable_path,
  portable_sections.fetch("Portable Core Baseline"),
)
require_terms(
  portable_path,
  portable_sections.fetch("Trajectory Binding"),
  [
    "only when high/extreme recurring or detached work has history that must be reconstructed",
    "all other current summaries stay in `control.md`",
  ],
)
portable_launcher = section(portable_path, portable_content, "Portable Launcher")
require_terms(
  portable_path,
  portable_launcher,
  [
    "Program kind: <finite | continuing>",
    "Done or health: <measurable finite DONE | continuing health invariant>",
    "Finite completion verifier: <verification | not_applicable>",
    "Continuing review horizon: <bounded review/renewal point | not_applicable>",
    "Continuing cycle verifier: <rejection-capable health check | not_applicable>",
    "For finite work, stop only on verified DONE",
    "For continuing work, verify each bounded cycle and keep the program open until its review-horizon decision",
  ],
)

index_path = "skills/kybernetes-loop-governor/references/reference-index.md"
index_content = require_file(index_path)
selection_rules = section(index_path, index_content, "Selection Rules")
exactly_one_rule = "Load exactly one runtime binding."
rule_count = selection_rules.scan(Regexp.new(Regexp.escape(exactly_one_rule))).length
unless rule_count == 1
  abort("#{index_path} expected exactly one runtime-binding selection rule, found #{rule_count}")
end
require_terms(
  index_path,
  selection_rules,
  [
    "Each selected binding resolves the required portable baseline itself",
    "`runtime:portable-core` is an alternative binding, not a mixin",
    "Do not combine bindings",
    "Documentation is not capability evidence.",
  ],
)

RUNTIME_BINDINGS.merge("portable-core" => "portable-core.md").each do |name, filename|
  routing_row_pattern = /^\| `runtime:#{Regexp.escape(name)}` \|/
  routing_row_count = index_content.lines(chomp: true).count { |line| line.match?(routing_row_pattern) }
  unless routing_row_count == 1
    abort("#{index_path} expected exactly one runtime:#{name} routing row, found #{routing_row_count}")
  end

  row_pattern = /^\| `runtime:#{Regexp.escape(name)}` \| `#{Regexp.escape(filename)}` \| .+ \|$/
  row_count = index_content.lines(chomp: true).count { |line| line.match?(row_pattern) }
  unless row_count == 1
    abort("#{index_path} expected exactly one runtime:#{name} routing row to #{filename}, found #{row_count}")
  end
end

capability_path = "skills/kybernetes-loop-governor/references/capability-negotiation.md"
capability_content = require_file(capability_path)
capability_snapshot = section(capability_path, capability_content, "Capability Snapshot")
require_terms(
  capability_path,
  capability_snapshot,
  ["activation identity and relevant execution context"],
)
negotiation = section(capability_path, capability_content, "Negotiation Procedure")
require_terms(
  capability_path,
  negotiation,
  [
    "Reuse a dated snapshot only within the same activation",
    "relevant surface, context, and assumptions remain unchanged",
    "Every detached, scheduled, or fresh activation probes its own required agent-callable operations before depending on them",
    "Another activation's probe is insufficient",
    "record the capability as unknown and use its fallback",
  ],
)

readme_path = "skills/kybernetes-loop-governor/README.md"
readme = require_file(readme_path)
resolver_paths = [
  "references/chatgpt-work.md",
  "references/codex.md",
  "references/claude-code.md",
  "references/claude-cowork.md",
  "references/portable-core.md",
]
resolver_paths.each do |resolver_path|
  count = readme.scan(Regexp.new(Regexp.escape("`#{resolver_path}`"))).length
  abort("#{readme_path} expected exactly one resolver entry for #{resolver_path}, found #{count}") unless count == 1
end

matrix_path = "docs/architecture/portable-runtime-matrix.md"
matrix_content = require_file(matrix_path)
require_terms(matrix_path, matrix_content, ["ChatGPT Work mode", "Codex", "Claude Code", "Claude Cowork"])

scenario_path = "tests/pressure-scenarios/080-runtime-binding-assumed-from-documentation.md"
scenario_content = require_file(scenario_path)
require_terms(
  scenario_path,
  scenario_content,
  [
    "every activation, including each fresh scheduled run",
    "safely probe",
    "without inventing parity",
    "Fail closed for a missing or unknown operation",
    "selected hosted binding by itself to resolve every required portable port",
    "unattended sandbox, permission, and approval behavior",
  ],
)

puts "runtime portability validation passed"
