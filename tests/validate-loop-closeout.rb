#!/usr/bin/env ruby
p="skills/kybernetes-loop-closeout/SKILL.md"; abort("missing required file: #{p}") unless File.file?(p); c=File.read(p)
[
  "name: 'kybernetes:loop-closeout'", "checkpoint", "handoff", "workstream",
  "program", "evidence reconciliation", "retirement inventory", "archive",
  "idempotent", "cannot mutate", "Return To Governor",
].each{|x| abort("#{p} missing #{x}") unless c.include?(x)}
puts "loop closeout validation passed"
