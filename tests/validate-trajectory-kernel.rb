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

def require_pattern(path, content, pattern, description)
  abort("#{path} missing #{description}") unless normalize(content).match?(pattern)
end

def reject_pattern(path, content, pattern, description)
  abort("#{path} must not contain #{description}") if normalize(content).match?(pattern)
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

scenario_path = "tests/pressure-scenarios/075-detached-run-remains-safe-but-stalled.md"
reference_path = "skills/kybernetes-loop-governor/references/trajectory-control.md"
governor_path = "skills/kybernetes-loop-governor/SKILL.md"
index_path = "skills/kybernetes-loop-governor/references/reference-index.md"

scenario = require_file(scenario_path)
scenario_failure = section(scenario_path, scenario, "## Failure")
scenario_expected = section(scenario_path, scenario, "## Expected Coordinator Behavior")
require_terms(
  scenario_path,
  scenario_failure,
  [
    "two complete progress windows produce zero admissible domain delta",
    "Actionable capacity is exhausted",
    "repeat the same status check and actuator path",
  ],
)
require_terms(
  scenario_path,
  scenario_expected,
  [
    "Reject `stay` with the unchanged strategy at the cumulative no-progress cap",
    "fully measured zero-delta trajectory `unhealthy`",
    "reserve `unknown` for missing or stale sensing",
    "same `strategy_id` and cumulative deficient-window count across reconstruction",
    "negative domain verdict",
  ],
)
reject_pattern(
  scenario_path,
  scenario_expected,
  /`unhealthy`\s+or\s+`unknown`/i,
  "an unknown verdict for the fully measured zero-delta fixture",
)

reference = require_file(reference_path)
program_contract = section(reference_path, reference, "## Program Contract")
require_terms(
  reference_path,
  program_contract,
  [
    "strategy_id",
    "done_or_health: measurable finite DONE or continuing health invariant",
    "review_horizon",
    "cycle_verifier",
    "progress_model",
    "minimum_delta",
    "no_progress_cap",
    "actionable_capacity: observations and actions reachable through approved sensors and actuators",
    "healthy cycle does not complete the continuing policy objective",
  ],
)

outcome_funnel = section(reference_path, reference, "## Typed Outcome Funnel")
require_terms(
  reference_path,
  outcome_funnel,
  ["attempted", "delivered", "reached", "engaged", "evidence_acquired"],
)

durable_state = section(reference_path, reference, "## Durable State")
require_terms(
  reference_path,
  durable_state,
  [
    "current trajectory summary in `control.md`: `strategy_id`",
    "Record one compact block per window: `strategy_id`",
    "preserves the cumulative deficient-window count for the same `strategy_id`",
    "materially different causal approach receives a new `strategy_id` and starts its count at zero",
    "retain the rejected strategy and its final count in history",
    "trajectory.md",
  ],
)

control_law = section(reference_path, reference, "## Control Law")
require_terms(
  reference_path,
  control_law,
  [
    "reject missing or implausible approved capacity",
    "without a pre-authorized fallback or an explicit single-path experiment with a tight stop rule",
    "At the cap, reject `stay` with the unchanged strategy",
    "classify the unchanged strategy as `unhealthy`",
    "Reserve `unknown` for missing or stale sensing",
  ],
)
reject_pattern(
  reference_path,
  control_law,
  /(?:allow|permit|continue|repeat|may|can)\b[^.]{0,180}`stay`[^.]{0,180}unchanged strategy|`stay`[^.]{0,180}(?:allow|permit|continue|repeat|may|can)\b[^.]{0,180}unchanged strategy/i,
  "a rule allowing `stay` with the unchanged strategy",
)

governor = require_file(governor_path)
require_terms(
  governor_path,
  governor,
  [
    "trajectory",
    "cumulative no-progress",
    "reject `stay` with the unchanged strategy",
    "program kind",
    "continuing health invariant",
  ],
)

index = require_file(index_path)
selection_rules = section(index_path, index, "## Selection Rules")
require_terms(
  index_path,
  selection_rules,
  [
    "Every detached activation requires `lifecycle` and `capability`",
    "High/extreme detached activation additionally requires `trajectory`",
    "Finite detached work loads `verification` and uses completion verification before a completion claim",
    "Continuing detached work uses its recorded `cycle_verifier` instead of completion verification",
    "Ordinary foreground finite work does not require the optional `verification` module",
  ],
)
require_pattern(
  index_path,
  selection_rules,
  /Every detached activation requires `lifecycle` and `capability`\./,
  "a lifecycle-and-capability baseline for every detached activation",
)
require_pattern(
  index_path,
  selection_rules,
  /High\/extreme detached activation additionally requires `trajectory`\./,
  "a trajectory dependency scoped to high/extreme detached activation",
)
require_pattern(
  index_path,
  selection_rules,
  /Finite detached work loads `verification` and uses completion verification before a completion claim\./,
  "completion verification scoped to finite detached work",
)
require_pattern(
  index_path,
  selection_rules,
  /Continuing detached work uses its recorded `cycle_verifier` instead of completion verification\./,
  "cycle verification scoped to continuing detached work",
)
require_pattern(
  index_path,
  selection_rules,
  /Ordinary foreground finite work does not require the optional `verification` module/,
  "an explicit foreground finite exclusion from the verification-module dependency",
)
reject_pattern(
  index_path,
  selection_rules,
  /Every detached activation requires[^.]*`trajectory`/i,
  "a trajectory dependency for every detached activation",
)
reject_pattern(
  index_path,
  selection_rules,
  /\bFinite work (?:also )?requires `verification`/i,
  "a verification-module dependency for all finite work",
)
reject_pattern(
  index_path,
  selection_rules,
  /Continuing detached work[^.]{0,180}(?:loads|requires) `verification`/i,
  "a verification-module dependency for continuing detached work",
)
routing_rows = index.lines.count { |line| line.start_with?("| `trajectory` | `trajectory-control.md` |") }
abort("#{index_path} expected exactly one trajectory routing row, found #{routing_rows}") unless routing_rows == 1

puts "trajectory kernel validation passed"
