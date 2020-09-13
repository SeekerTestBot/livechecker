original_lines = File.read(ARGV[0] || "homebrew-core.txt").lines

original_lines.each do |line|
  m = line.match(/^(.+?) : (.+?) ==> (.+)$/)
  next if m.nil?
  fc_name = m.captures.first
  puts fc_name
end
