#!/usr/bin/env ruby

def require_file(path)
  abort("missing required file: #{path}") unless File.file?(path)
  File.read(path)
end

def require_terms(path, content, terms)
  missing = terms.reject { |term| content.include?(term) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
end

readme_path = "skills/kybernetes-loop-governor/README.md"
readme = require_file(readme_path)
boundaries_path = "docs/architecture/skill-boundaries.md"
boundaries = require_file(boundaries_path)
planned_path = "docs/architecture/planned-skills.md"
planned = require_file(planned_path)
scenario_path =
  "tests/pressure-scenarios/074-retired-skill-name-invocation.md"
scenario = require_file(scenario_path)

require_terms(
  readme_path,
  readme,
  ["retired v0 name", "not an installed alias", "$kybernetes:loop-governor"],
)
abort("#{readme_path} still promises a compatibility alias") if
  readme.include?("compatibility alias")

require_terms(
  boundaries_path,
  boundaries,
  ["retired v0 name", "not an installed alias", "kybernetes:parallel-coordinator"],
)
require_terms(
  planned_path,
  planned,
  ["kybernetes:parallel-coordinator", "Create after pressure scenarios"],
)
require_terms(
  scenario_path,
  scenario,
  [
    "## Failure",
    "## Expected Coordinator Behavior",
    "retired v0 name",
    "not an installed",
    "possible future specialist",
  ],
)

installed_names = Dir["skills/*/SKILL.md"].map do |path|
  File.read(path)[/^name:\s*['\"]?([^'\"\n]+)['\"]?$/, 1]
end
abort("retired parallel-coordinator unexpectedly became installable") if
  installed_names.compact.any? { |name| name.include?("parallel-coordinator") }

puts "skill naming validation passed"
