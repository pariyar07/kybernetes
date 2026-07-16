#!/usr/bin/env ruby

def require_file(path)
  abort("missing required file: #{path}") unless File.file?(path)
  File.read(path)
end

kernel_path = "skills/kybernetes-loop-governor/SKILL.md"
manifest_path = "skills/kybernetes-loop-governor/manifest.md"
index_path = "skills/kybernetes-loop-governor/references/reference-index.md"

kernel = require_file(kernel_path)
manifest = require_file(manifest_path)
index = require_file(index_path)

%w[schema_revision selected_modules runtime_binding canonical_revision].each do |term|
  abort("#{manifest_path} missing #{term}") unless manifest.include?(term)
end

%w[lifecycle capability topology recovery verification learning runtime].each do |term|
  abort("#{index_path} missing #{term}") unless index.downcase.include?(term)
end

[
  "smallest reliable harness",
  "reference-index.md",
  "unsupported schema_revision",
  "Freeze new side effects",
  "recoverable wait",
  "runtime state is advisory",
].each do |term|
  abort("#{kernel_path} missing #{term}") unless kernel.include?(term)
end

kernel_lines = kernel.lines.count
abort("kernel is not lean: #{kernel_lines} lines") unless kernel_lines <= 220
abort("kernel reduction is not meaningful") unless kernel_lines <= (366 * 0.65).floor

puts "lazy governor validation passed (#{kernel_lines} kernel lines; baseline 366)"
