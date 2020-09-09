path = ARGV[0] || "linuxbrew-core.txt"
File.read(path).lines.each do |line|
  m = line.match(/^([^ ]+) : [^ ]+ ==> [^ ]+$/)
  next if m.nil?
  name = m.captures.first
  formula = Formulary.factory(name)
  next unless formula.requirements.any? { |r| r.is_a?(LinuxRequirement) }
  puts line
end
