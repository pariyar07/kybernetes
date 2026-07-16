#!/usr/bin/env ruby

def require_file(path)
  abort("missing required file: #{path}") unless File.file?(path)
  File.read(path)
end

def require_terms(path, content, terms)
  missing = terms.reject { |term| content.include?(term) }
  abort("#{path} missing: #{missing.join(', ')}") unless missing.empty?
end

lifecycle_path =
  "skills/kybernetes-loop-governor/references/canonical-lifecycle.md"
lifecycle = require_file(lifecycle_path)

states = %w[
  designing active waiting_human waiting_time waiting_event paused verifying
  recovering blocked_terminal superseded completed
]

require_terms(lifecycle_path, lifecycle, states)
require_terms(
  lifecycle_path,
  lifecycle,
  [
    "MUST NOT mirror",
    "canonical_state == blocked_terminal",
    "canonical_state == completed",
    "control.md",
    "verification.md",
  ],
)

puts "runtime governance validation passed"
