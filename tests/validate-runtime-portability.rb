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
].freeze

RUNTIME_BINDINGS = {
  "chatgpt-work" => "chatgpt-work.md",
  "codex" => "codex.md",
  "claude-code" => "claude-code.md",
  "claude-cowork" => "claude-cowork.md",
}.freeze

def require_file(path)
  abort("missing required file: #{path}") unless File.file?(path)
  File.read(path)
end

def require_terms(path, content, terms)
  normalized_content = content.gsub(/\s+/, " ")
  missing = terms.reject { |term| normalized_content.include?(term.gsub(/\s+/, " ")) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
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

portable_path = "skills/kybernetes-loop-governor/references/portable-core.md"
portable_content = require_file(portable_path)
portable_sections = PORTABLE_CORE_HEADINGS.to_h do |heading|
  [heading, section(portable_path, portable_content, heading)]
end
require_safe_activation_invariants(portable_path, portable_sections)
require_terms(
  portable_path,
  portable_sections.fetch("Trajectory Binding"),
  [
    "only when high/extreme recurring or detached work has history that must be reconstructed",
    "all other current summaries stay in `control.md`",
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
  ["Do not combine bindings", "Documentation is not capability evidence."],
)

RUNTIME_BINDINGS.each do |name, filename|
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
  ],
)

puts "runtime portability validation passed"
