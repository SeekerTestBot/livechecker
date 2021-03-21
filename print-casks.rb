require "cask"

original_lines = File.read(ARGV.first || "homebrew-cask.txt").lines
tap = ARGV.second || ENV["LIVECHECKER_TAP"] || "homebrew/cask"

original_lines.each do |line|
  m = line.match(/^(.+?) : (.+?) ==> (.+)$/)
  next if m.nil?
  fc_name = m[1]
  begin
    Cask::CaskLoader.load(fc_name)
  rescue Cask::CaskUnavailableError
    next
  end
  puts "#{tap}/#{fc_name}"
end
