#!/usr/bin/env ruby
path = "skills/kybernetes-loop-governor/references/workgraph.md"
abort("missing required file: #{path}") unless File.file?(path)
c = File.read(path)
%w[workstream_id activation_id report_id canonical_revision lease_id expires_at].each { |x| abort("#{path} missing #{x}") unless c.include?(x) }
[
  "single writer", "idempotent", "quarantine", "stale revision",
  "expired lease", "cannot self-accept", "flat workgraph", "ignored",
].each { |x| abort("#{path} missing #{x}") unless c.downcase.include?(x) }
abort("missing workgraph example") unless File.file?("examples/portable-workgraph/README.md")
puts "workgraph validation passed"
