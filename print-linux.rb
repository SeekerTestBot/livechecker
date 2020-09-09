tap_name = ARGV[1] || "homebrew/core"
tap = Tap.fetch(tap_name)
formulae = tap.formula_files.map(&Formulary.method(:factory)).sort
formulae.each do |formula|
  next unless formula.requirements.any? { |r| r.is_a?(LinuxRequirement) }
  puts formula.name
end
