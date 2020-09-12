original_lines = File.read(ARGV[0] || "homebrew-core.txt").lines
livecheck_command = ARGV[1] || "livecheck"

IO.popen([HOMEBREW_BREW_FILE, livecheck_command, "--newer-only", "--quiet"]) { |brew_io|
  livecheck_output = brew_io.read.strip
  puts livecheck_output

  # new_hash = {}

  # livecheck_output.lines.each do |line|
  #   m = line.match(/^(.+?) : (.+?) ==> (.+)$/)
  #   next if m.nil?
  #   fc_name = m.captures.first
  #   new_hash[fc_name] = line.strip
  # end

  # original_lines.each do |old_line|
  #   m = old_line.match(/^(.+?) : (.+?) ==> (.+)$/)
  #   if m.nil?
  #     puts old_line
  #     next
  #   end
  #   fc_name = m.captures.first
  #   new_line = new_hash[fc_name]
  #   puts new_line if new_line
  # end
}
