#!/usr/bin/env ruby

def require_file(path)
  abort("missing required file: #{path}") unless File.file?(path)
  File.read(path)
end

def normalize(content)
  content.gsub(/\s+/, " ").strip
end

def require_terms(path, content, terms)
  normalized = normalize(content)
  missing = terms.reject { |term| normalized.include?(normalize(term)) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
end

def section(path, content, heading_line)
  lines = content.lines(chomp: true)
  indexes = lines.each_index.select { |index| lines[index] == heading_line }
  unless indexes.length == 1
    abort("#{path} expected exactly one #{heading_line.inspect} heading, found #{indexes.length}")
  end

  level = heading_line[/\A#+/].length
  start_index = indexes.first + 1
  end_index = (start_index...lines.length).find do |index|
    heading = lines[index].match(/\A(#+)\s/)
    heading && heading[1].length <= level
  end || lines.length
  body = lines[start_index...end_index].join("\n").strip
  abort("#{path} has an empty #{heading_line.inspect} section") if body.empty?
  body
end

def require_exact_line_count(path, content, line, expected_count)
  count = content.lines(chomp: true).count { |candidate| candidate == line }
  abort("#{path} expected #{expected_count} exact occurrence(s) of #{line.inspect}, found #{count}") unless count == expected_count
end

def reject_line_matching(path, content, pattern, description)
  matches = content.lines(chomp: true).grep(pattern)
  abort("#{path} must not contain #{description}: #{matches.join(', ')}") unless matches.empty?
end

l2_path = "docs/architecture/l2-port-contracts.md"
l2 = require_file(l2_path)
trajectory_summary_row = "| `trajectory_sensor` | Conditional | Use for high/extreme recurring or detached work, multi-window experiments, continuing programs, or repeated no-change that may require strategy rejection. |"

require_exact_line_count(l2_path, l2, "## `trajectory_sensor`", 1)
require_exact_line_count(l2_path, l2, trajectory_summary_row, 1)
reject_line_matching(l2_path, l2, /^## `progress_sensor`\s*$/, "a `progress_sensor` contract heading")
reject_line_matching(l2_path, l2, /^\| `progress_sensor` \|/, "a `progress_sensor` summary-row port")

durable_objective = section(l2_path, l2, "## `durable_objective`")
require_terms(
  l2_path,
  durable_objective,
  [
    "Program kind",
    "measurable finite DONE plus completion verifier",
    "continuing health invariant plus review horizon and cycle verifier",
  ],
)

trajectory = section(l2_path, l2, "## `trajectory_sensor`")
require_terms(
  l2_path,
  trajectory,
  [
    "Portable name | `trajectory_sensor`",
    "`strategy_id`, program kind",
    "continuing review horizon and cycle verifier",
    "cumulative deficient windows for that strategy",
    "actionable capacity through approved sensors and actuators",
    "Continue, adapt, pause, escalate, or retire",
    "cannot declare completion",
    "Report `unknown` only for missing or stale sensing",
    "report `unhealthy`",
    "records `strategy_id`",
    "Preserve the count for the same strategy across activations and reconstruction",
    "reset only for a materially different causal strategy with a new ID",
    "retaining prior history",
  ],
)

require_terms(
  l2_path,
  l2,
  [
    "The trajectory program supplies the canonical fields `strategy_id`",
    "`review_horizon`, and `cycle_verifier`",
  ],
)
require_terms(
  "docs/architecture/runtime-adapter-model.md",
  require_file("docs/architecture/runtime-adapter-model.md"),
  ["Strategy / trajectory sensing", "`trajectory_sensor`"],
)
require_terms(
  "docs/architecture/portable-runtime-matrix.md",
  require_file("docs/architecture/portable-runtime-matrix.md"),
  ["`trajectory_sensor`", "completion verification remains separate"],
)

puts "trajectory port validation passed"
