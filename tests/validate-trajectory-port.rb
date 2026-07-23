#!/usr/bin/env ruby

def require_terms(path, terms)
  abort("missing required file: #{path}") unless File.file?(path)
  content = File.read(path)
  missing = terms.reject { |term| content.include?(term) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
end

def require_exact_line_count(path, line, expected_count)
  abort("missing required file: #{path}") unless File.file?(path)
  count = File.readlines(path, chomp: true).count { |candidate| candidate == line }
  abort("#{path} expected #{expected_count} exact occurrence(s) of #{line.inspect}, found #{count}") unless count == expected_count
end

def reject_line_matching(path, pattern, description)
  abort("missing required file: #{path}") unless File.file?(path)
  matches = File.readlines(path, chomp: true).grep(pattern)
  abort("#{path} must not contain #{description}: #{matches.join(', ')}") unless matches.empty?
end

l2_contracts = "docs/architecture/l2-port-contracts.md"
trajectory_summary_row = "| `trajectory_sensor` | Conditional | Use for high/extreme recurring or detached work, multi-window experiments, continuing programs, or repeated no-change that may require strategy rejection. |"

require_terms(
  l2_contracts,
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
require_exact_line_count(l2_contracts, "## `trajectory_sensor`", 1)
require_exact_line_count(l2_contracts, trajectory_summary_row, 1)
reject_line_matching(l2_contracts, /^## `progress_sensor`\s*$/, "a `progress_sensor` contract heading")
reject_line_matching(l2_contracts, /^\| `progress_sensor` \|/, "a `progress_sensor` summary-row port")
require_terms(
  "docs/architecture/runtime-adapter-model.md",
  ["Strategy / trajectory sensing", "`trajectory_sensor`"],
)
require_terms(
  "docs/architecture/portable-runtime-matrix.md",
  ["`trajectory_sensor`", "completion verification remains separate"],
)

puts "trajectory port validation passed"
