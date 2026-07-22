#!/usr/bin/env ruby

def require_file(path)
  abort("missing required file: #{path}") unless File.file?(path)
  File.read(path)
end

def require_terms(path, content, terms)
  missing = terms.reject { |term| content.include?(term) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
end

scenario_path = "tests/pressure-scenarios/075-detached-run-remains-safe-but-stalled.md"
reference_path = "skills/kybernetes-loop-governor/references/trajectory-control.md"
governor_path = "skills/kybernetes-loop-governor/SKILL.md"
index_path = "skills/kybernetes-loop-governor/references/reference-index.md"

scenario = require_file(scenario_path)
reference = require_file(reference_path)
governor = require_file(governor_path)
index = require_file(index_path)

require_terms(
  scenario_path,
  scenario,
  [
    "zero admissible domain delta",
    "Actionable capacity is exhausted",
    "cumulative no-progress cap",
    "unchanged strategy",
    "negative domain verdict",
  ],
)

require_terms(
  reference_path,
  reference,
  [
    "program_kind",
    "progress_model",
    "minimum_delta",
    "no_progress_cap",
    "actionable_capacity",
    "trajectory.md",
    "attempted",
    "delivered",
    "reached",
    "engaged",
    "evidence_acquired",
    "Owner Approval Required",
  ],
)

require_terms(
  governor_path,
  governor,
  ["trajectory", "cumulative no-progress", "unchanged strategy"],
)
require_terms(index_path, index, ["`trajectory`", "trajectory-control.md"])

puts "trajectory kernel validation passed"
