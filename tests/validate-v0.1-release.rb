#!/usr/bin/env ruby
require "yaml"

skills = Dir["skills/*/SKILL.md"].sort
expected = %w[
  kybernetes:capture-learning
  kybernetes:loop-architect
  kybernetes:loop-closeout
  kybernetes:loop-governor
  kybernetes:verify-run
]
names = skills.map do |path|
  front = File.read(path)[/\A---\n(.*?)\n---\n/m, 1] or abort("missing frontmatter: #{path}")
  YAML.safe_load(front).fetch("name")
end.sort
abort("skill inventory mismatch: #{names.inspect}") unless names == expected

required = %w[
  README.md CHANGELOG.md docs/releases/v0.1.0-rc.1.md docs/releases/v0.1.0.md
  docs/releases/v0.1.1.md docs/releases/v0.1.1-verification.md
  docs/releases/v0.1.2.md docs/releases/v0.1.2-verification.md
  docs/architecture/runtime-adaptive-harness-architecture.md
  docs/assets/diagrams/4-runtime-adaptive-harness.svg
  examples/runtime-adaptive-program/README.md
]
required.each { |path| abort("missing release artifact: #{path}") unless File.file?(path) }

readme = File.read("README.md")
expected.each { |name| abort("README missing #{name}") unless readme.include?(name) }
abort("README retains one-skill claim") if readme.match?(/one (public )?installable skill|V1 ships as one/)

agents = File.read("AGENTS.md")
skill_dirs = skills.map { |path| File.basename(File.dirname(path)) }
skill_dirs.each { |dir| abort("AGENTS missing #{dir}") unless agents.include?(dir) }
abort("AGENTS retains one-skill claim") if agents.match?(/one (public )?installable skill|V1 ships as one/)
abort("AGENTS missing sole-governor invariant") unless agents.include?("sole canonical lifecycle controller")

changelog = File.read("CHANGELOG.md")
abort("CHANGELOG missing v0.1.1") unless changelog.include?("## [0.1.1] - 2026-07-17")
release = File.read("docs/releases/v0.1.1.md")
abort("v0.1.1 release missing verification link") unless release.include?("v0.1.1-verification.md")
abort("CHANGELOG missing v0.1.2") unless changelog.include?("## [0.1.2] - 2026-07-17")
release_012 = File.read("docs/releases/v0.1.2.md")
abort("v0.1.2 release missing verification link") unless release_012.include?("v0.1.2-verification.md")

tracked = `git ls-files '.superpowers/*' 'docs/superpowers/*' '.kybernetes/*'`.lines
abort("forbidden tracked artifacts: #{tracked.join}") unless tracked.empty?

puts "v0.1 release validation passed (#{skills.length} skills)"
