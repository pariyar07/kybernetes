#!/usr/bin/env ruby

def require_file(path)
  abort("missing required file: #{path}") unless File.file?(path)
  File.read(path)
end

def require_terms(path, terms)
  content = require_file(path)
  missing = terms.reject { |term| content.include?(term) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
end

require_terms(
  "skills/kybernetes-loop-governor/references/goal-checklist.md",
  ["Actionable capacity", "Fallback coverage", "Progress model", "trajectory.md"],
)
require_terms(
  "skills/kybernetes-loop-governor/references/activation-bindings.md",
  ["strategy_id", "progress_window", "no_progress_cap", "does not reset"],
)
require_terms(
  "skills/kybernetes-loop-architect/SKILL.md",
  ["extreme detached", "minimum delta", "actionable capacity", "strategy envelope"],
)

{
  "tests/pressure-scenarios/076-proxy-activity-misclassified-as-progress.md" =>
    ["artifact type", "delivered invitations", "evidence_acquired"],
  "tests/pressure-scenarios/077-actuator-exists-without-actionable-capacity.md" =>
    ["actionable capacity", "minimum delta", "fallback coverage"],
  "tests/pressure-scenarios/078-strategy-change-expands-authority.md" =>
    ["strategy envelope", "Ask the owner", "information release"],
  "tests/pressure-scenarios/079-healthy-maintenance-misclassified-as-stall.md" =>
    ["maintenance", "continuing program", "event_wait"],
}.each { |path, terms| require_terms(path, terms) }

puts "trajectory readiness validation passed"
