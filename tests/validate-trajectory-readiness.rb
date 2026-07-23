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

trajectory_path = "skills/kybernetes-loop-governor/references/trajectory-control.md"
trajectory = require_file(trajectory_path)
program_contract = section(trajectory_path, trajectory, "## Program Contract")
require_terms(
  trajectory_path,
  program_contract,
  [
    "program_kind: finite | continuing",
    "done_or_health: measurable finite DONE or continuing health invariant",
    "review_horizon",
    "cycle_verifier",
    "actionable_capacity: observations and actions reachable through approved sensors and actuators",
    "Finite work keeps evidence-backed measurable DONE and completion verification",
    "healthy cycle does not complete the continuing policy objective",
  ],
)

progress_models = section(trajectory_path, trajectory, "## Progress Models")
require_terms(
  trajectory_path,
  progress_models,
  [
    "`maintenance` | Fresh evidence covers the invariant and remains inside bounds",
    "Coverage is stale, missing, or outside bounds",
    "`event_wait` | The event sensor remains fresh inside a bounded wait",
    "The sensor is stale, the wait exceeds its bound, or polling cannot affect the next decision",
    "Zero numeric change can be healthy for `maintenance`",
  ],
)

control_law = section(trajectory_path, trajectory, "## Control Law")
require_terms(
  trajectory_path,
  control_law,
  [
    "reject missing or implausible approved capacity",
    "known actuator gating without a pre-authorized fallback",
    "explicit single-path experiment with a tight stop rule",
  ],
)

autonomous = section(trajectory_path, trajectory, "## Autonomous Changes Inside The Envelope")
require_terms(
  trajectory_path,
  autonomous,
  [
    "use an approved fallback",
    "same audience/destination/data/claims/risk boundary",
  ],
)
owner_approval = section(trajectory_path, trajectory, "## Owner Approval Required")
require_terms(
  trajectory_path,
  owner_approval,
  [
    "external channel",
    "audience",
    "connector grants",
    "information release",
    "Ask before changing",
  ],
)

checklist_path = "skills/kybernetes-loop-governor/references/goal-checklist.md"
checklist = require_file(checklist_path)
inputs = section(checklist_path, checklist, "## 2. Inputs")
require_terms(
  checklist_path,
  inputs,
  [
    "`program_kind`: explicitly `finite` or `continuing`",
    "`done_or_health`",
    "proves finite DONE",
    "`review_horizon` and `cycle_verifier`: required for continuing programs",
    "Do not force a continuing program through finite DONE",
  ],
)
trajectory_readiness = section(checklist_path, checklist, "### Trajectory Readiness")
require_terms(
  checklist_path,
  trajectory_readiness,
  [
    "`strategy_id`",
    "through approved sensors and actuators for the first window",
    "Fallback coverage",
    "Strategy envelope",
    "`review_horizon` and `cycle_verifier`",
    "Reject detached activation when approved actionable capacity cannot plausibly satisfy the first window",
  ],
)
stop_conditions = section(checklist_path, checklist, "## 13. Stop Conditions")
require_terms(
  checklist_path,
  stop_conditions,
  [
    "Continuing cycle checkpoint",
    "keep the program open",
    "renew, adapt, pause, or retire it at the review horizon",
    "A healthy cycle is not finite success",
  ],
)

activation_path = "skills/kybernetes-loop-governor/references/activation-bindings.md"
activation = require_file(activation_path)
activation_contract = section(activation_path, activation, "## Activation Contract")
require_terms(
  activation_path,
  activation_contract,
  [
    "allowed_effects",
    "strategy_id",
    "program_kind",
    "cumulative_deficient_windows",
    "fallback_order",
    "review_horizon",
    "cycle_verifier",
    "validate capability and permission",
  ],
)
detached_gate = section(activation_path, activation, "## Detached Gate")
require_terms(
  activation_path,
  detached_gate,
  [
    "Read `cumulative_deficient_windows` from canonical state before evaluation",
    "never initialize it from activation-local state",
    "For `maintenance`, fresh evidence with required invariant coverage may keep the count unchanged",
    "stale or missing coverage is deficient",
    "For `event_wait`, only a fresh wait inside its declared bound may keep the count unchanged",
    "stale sensor, exceeded bound, or decision-inert polling is deficient",
    "new strategy starts its own count at zero",
    "rejected strategy's final count remains reconstructable in history",
  ],
)

architect_path = "skills/kybernetes-loop-architect/SKILL.md"
architect = require_file(architect_path)
required_inputs = section(architect_path, architect, "## Required Inputs")
require_terms(
  architect_path,
  required_inputs,
  [
    "explicit program kind",
    "For finite work, measurable DONE and its completion verifier",
    "for continuing work, the health invariant, review horizon, and cycle verifier",
  ],
)
execution_contract = section(architect_path, architect, "## Design The Execution Contract")
require_terms(
  architect_path,
  execution_contract,
  [
    "program kind",
    "`strategy_id`",
    "actionable capacity",
    "strategy envelope",
    "either finite DONE verification or the continuing review horizon and cycle verifier",
  ],
)

{
  "tests/pressure-scenarios/076-proxy-activity-misclassified-as-progress.md" =>
    ["artifact type", "delivered invitations", "evidence_acquired"],
  "tests/pressure-scenarios/077-actuator-exists-without-actionable-capacity.md" =>
    ["actionable capacity", "approved sensors and actuators", "minimum delta", "fallback coverage"],
  "tests/pressure-scenarios/078-strategy-change-expands-authority.md" =>
    ["strategy envelope", "Ask the owner", "information release"],
  "tests/pressure-scenarios/079-healthy-maintenance-misclassified-as-stall.md" =>
    ["maintenance", "cycle_verifier", "review_horizon", "event_wait"],
}.each do |path, terms|
  require_terms(path, require_file(path), terms)
end

puts "trajectory readiness validation passed"
