original_lines = File.read(ARGV[0] || "homebrew-core.txt").lines
no_formulae = true

original_lines.each do |line|
  m = line.match(/^(.+?) : (.+?) ==> (.+)$/)
  next if m.nil?
  no_formulae = false
  fc_name = m.captures.first
  puts fc_name
end

exit 1 if no_formulae
