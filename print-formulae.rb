original_lines = File.read(ARGV.first || "homebrew-core.txt").lines

original_lines.each do |line|
  m = line.match(/^(.+?) : (.+?) ==> (.+)$/)
  next if m.nil?
  fc_name = m.captures.first
  begin
    if ARGV.include?("--casks") || ARGV.include?("--cask")
      Cask::CaskLoader.load(fc_name)
    else
      Formulary.factory(fc_name)
    end
  rescue Cask::CaskUnavailableError, FormulaUnavailableError
    next
  end
  puts fc_name
end
