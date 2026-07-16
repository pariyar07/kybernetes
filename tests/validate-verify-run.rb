#!/usr/bin/env ruby
p="skills/kybernetes-verify-run/SKILL.md"; abort("missing required file: #{p}") unless File.file?(p); c=File.read(p)
[
  "name: 'kybernetes:verify-run'", "pass", "fail", "inconclusive",
  "blocked", "not_run", "maker/checker", "coverage", "provenance",
  "rejection authority", "cannot mutate", "Return To Governor",
].each{|x| abort("#{p} missing #{x}") unless c.include?(x)}
puts "verify run validation passed"
