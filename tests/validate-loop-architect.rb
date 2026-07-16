#!/usr/bin/env ruby

path = "skills/kybernetes-loop-architect/SKILL.md"
abort("missing required file: #{path}") unless File.file?(path)
content = File.read(path)

[
  "name: 'kybernetes:loop-architect'",
  "decision consequence",
  "unresolved uncertainty",
  "Do not invoke",
  "Generate lenses",
  "preserve disagreement",
  "comparator augmentation",
  "evidence-gated promotion",
  "cannot mutate",
  "standalone",
  "Return To Governor",
].each { |term| abort("#{path} missing #{term}") unless content.include?(term) }

%w[salesperson marketer engineer researcher].each do |role|
  abort("#{path} hardcodes expert role #{role}") if content.downcase.include?(role)
end

puts "loop architect validation passed"
