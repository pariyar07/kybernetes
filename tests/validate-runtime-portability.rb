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

bindings = %w[chatgpt-work codex claude-code claude-cowork]
bindings.each do |name|
  require_terms(
    "skills/kybernetes-loop-governor/references/#{name}.md",
    [
      "Activation Binding",
      "Trajectory Binding",
      "Capability Probe",
      "Portable Fallback",
      "Documentation Evidence",
      "2026-07-23",
    ],
  )
end
require_terms(
  "skills/kybernetes-loop-governor/references/portable-core.md",
  ["Activation Binding", "Trajectory Binding", "Capability Probe", "Portable Fallback"],
)

require_terms(
  "skills/kybernetes-loop-governor/references/reference-index.md",
  ["runtime:chatgpt-work", "runtime:codex", "runtime:claude-code", "runtime:claude-cowork"],
)
require_terms(
  "docs/architecture/portable-runtime-matrix.md",
  ["ChatGPT Work mode", "Codex", "Claude Code", "Claude Cowork"],
)
require_terms(
  "tests/pressure-scenarios/080-runtime-binding-assumed-from-documentation.md",
  ["Probe the active agent-callable operations", "without inventing parity"],
)

puts "runtime portability validation passed"
