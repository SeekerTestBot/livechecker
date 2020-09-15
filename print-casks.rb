original_lines = File.read(ARGV.first || "homebrew-cask.txt").lines

original_lines.each do |line|
  m = line.match(/^(.+?) : (.+?) ==> (.+)$/)
  next if m.nil?
  fc_name = m.captures.first
  begin
    Cask::CaskLoader.load(fc_name)
  rescue Cask::CaskUnavailableError
    next
  end
  puts fc_name
end
