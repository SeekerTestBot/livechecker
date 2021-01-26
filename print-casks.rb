original_lines = File.read(ARGV.first || "homebrew-cask.txt").lines
tap = ARGV.second || "homebrew/cask"

original_lines.each do |line|
  m = line.match(/^(.+?) : (.+?) ==> (.+)$/)
  next if m.nil?
  fc_name = m.captures.first
  begin
    Cask::CaskLoader.load(fc_name)
  rescue Cask::CaskUnavailableError
    next
  end
  puts "#{tap}/#{fc_name}"
end
