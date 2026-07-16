#!/usr/bin/env ruby
path = "skills/kybernetes-loop-governor/references/activation-bindings.md"
abort("missing required file: #{path}") unless File.file?(path)
c=File.read(path)
%w[immediate human time event activation_id canonical_revision effect_key].each{|x| abort("#{path} missing #{x}") unless c.include?(x)}
[
  "notification", "manual checkpoint", "no-change", "direct event",
  "scheduled polling", "retirement", "idempotent", "stale",
].each{|x| abort("#{path} missing #{x}") unless c.downcase.include?(x)}
%w[codex.md claude-code.md portable-core.md].each do |f|
  p="skills/kybernetes-loop-governor/references/#{f}"
  abort("#{p} missing activation binding") unless File.read(p).include?("Activation Binding")
end
puts "activation binding validation passed"
