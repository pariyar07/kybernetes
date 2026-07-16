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

capability_path =
  "skills/kybernetes-loop-governor/references/capability-negotiation.md"
capability = require_file(capability_path)

require_terms(
  capability_path,
  capability,
  [
    "observed_at",
    "surface",
    "callable operations",
    "supported transitions",
    "unsupported transitions",
    "portable fallback",
    "documentation is not proof",
    "safe probe",
  ],
)

require_terms(
  lifecycle_path,
  lifecycle,
  [
    "Freeze new side effects",
    "Classify divergence",
    "fresh binding",
    "superseded",
    "Rebind",
  ],
)

puts "runtime governance validation passed"
