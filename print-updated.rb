original_lines = File.read(ARGV[0] || "homebrew-core.txt").lines

original_list = []

original_lines.each do |line|
  m = line.match(/^(.+?) : (.+?) ==> (.+)$/)
  next if m.nil?
  formula_name = m.captures.first
  original_list << formula_name
end

new_hash = {}

IO.popen([HOMEBREW_BREW_FILE, "livecheck", "--json", *original_list]) {|brew_io|
  json_string = brew_io.read.strip

  require 'json'
  livecheck_array = JSON.parse(json_string)

  livecheck_array.each do |formula_hash|
    if formula_hash["version"]["outdated"] || formula_hash["version"]["newer_than_upstream"]
      formula_name = formula_hash["formula"]
      new_hash[formula_name] = "#{formula_name} : #{formula_hash["version"]["current"]} ==> #{formula_hash["version"]["latest"]}"
    end
  end
}

puts original_lines.map { |line|
  m = line.match(/^(.+?) : (.+?) ==> (.+)$/)
  next line if m.nil?
  formula_name = m.captures.first
  new_hash[formula_name]
}.compact
