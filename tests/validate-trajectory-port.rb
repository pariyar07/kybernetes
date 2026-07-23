#!/usr/bin/env ruby

def require_terms(path, terms)
  abort("missing required file: #{path}") unless File.file?(path)
  content = File.read(path)
  missing = terms.reject { |term| content.include?(term) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
end

require_terms(
  "docs/architecture/l2-port-contracts.md",
  [
    "`trajectory_sensor`",
    "progress_model",
    "minimum_delta",
    "no_progress_cap",
    "actionable_capacity",
    "Continue, adapt, pause, escalate, or retire",
    "cannot declare completion",
  ],
)
require_terms(
  "docs/architecture/runtime-adapter-model.md",
  ["Strategy / trajectory sensing", "`trajectory_sensor`"],
)
require_terms(
  "docs/architecture/portable-runtime-matrix.md",
  ["`trajectory_sensor`", "completion verification remains separate"],
)

puts "trajectory port validation passed"
