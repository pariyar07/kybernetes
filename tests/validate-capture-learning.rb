#!/usr/bin/env ruby
p="skills/kybernetes-capture-learning/SKILL.md";abort("missing required file: #{p}")unless File.file?(p);c=File.read(p)
[
  "name: 'kybernetes:capture-learning'", "observation", "candidate",
  "promote", "reject", "defer", "enforceable constraint", "rollback",
  "revalidation", "cannot mutate", "Return To Governor",
].each{|x|abort("#{p} missing #{x}")unless c.include?(x)}
puts "capture learning validation passed"
