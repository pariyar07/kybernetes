#!/usr/bin/env ruby

def require_file(path)
  abort("missing required file: #{path}") unless File.file?(path)
  File.read(path)
end

def require_terms(path, content, terms)
  missing = terms.reject { |term| content.include?(term) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
end

governor_path = "skills/kybernetes-loop-governor/SKILL.md"
governor = require_file(governor_path)
checklist_path =
  "skills/kybernetes-loop-governor/references/goal-checklist.md"
checklist = require_file(checklist_path)
workgraph_path =
  "skills/kybernetes-loop-governor/references/workgraph.md"
workgraph = require_file(workgraph_path)
verify_path = "skills/kybernetes-verify-run/SKILL.md"
verify = require_file(verify_path)
learning_path = "skills/kybernetes-capture-learning/SKILL.md"
learning = require_file(learning_path)
lifecycle_path =
  "skills/kybernetes-loop-governor/references/canonical-lifecycle.md"
lifecycle = require_file(lifecycle_path)
closeout_path = "skills/kybernetes-loop-closeout/SKILL.md"
closeout = require_file(closeout_path)
simple_path =
  "tests/pressure-scenarios/024-over-gating-authorized-simple-task.md"
simple = require_file(simple_path)

require_terms(
  governor_path,
  governor,
  ["evidence is not an acceptance verdict", "accountable owner", "brownfield implicit constraints"],
)
require_terms(
  checklist_path,
  checklist,
  [
    "Acceptance boundary",
    "Wrongness response",
    "dependent system",
    "missing historical or operational constraints lower",
  ],
)
require_terms(
  workgraph_path,
  workgraph,
  ["implementation owner", "accountable acceptance owner", "dependent system"],
)
require_terms(
  verify_path,
  verify,
  ["does not issue the acceptance verdict", "acceptance_status", "brownfield constraints"],
)
require_terms(
  learning_path,
  learning,
  ["owner_approval", "must remain a proposal"],
)
require_terms(
  lifecycle_path,
  lifecycle,
  ["accountable owner's verdict", "any required acceptance", "verdict is recorded"],
)
require_terms(
  closeout_path,
  closeout,
  ["required acceptance", "owner verdict", "waiting_human"],
)
require_terms(simple_path, simple, ["does not affect a dependent system"])

scenario_terms = {
  70 => ["acceptance verdict", "accountable owner", "wrongness response"],
  71 => ["implementation owner", "accountable acceptance owner", "waiting_human"],
  72 => ["implicit constraints", "harnessability", "operational evidence"],
  73 => ["owner_approval", "accountable owner", "normal tested change process"],
}
scenario_terms.each do |number, terms|
  path = Dir[format("tests/pressure-scenarios/%03d-*.md", number)].first
  abort("missing pressure scenario #{number}") unless path

  scenario = require_file(path)
  require_terms(
    path,
    scenario,
    ["## Failure", "## Expected Coordinator Behavior", *terms],
  )
end

puts "acceptance boundary validation passed"
