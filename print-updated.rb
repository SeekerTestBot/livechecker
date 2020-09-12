original_lines = File.read(ARGV[0] || "homebrew-core.txt").lines
livecheck_command = ARGV[1] || "livecheck"

new_hash = {}

puts ["", HOMEBREW_BREW_FILE, livecheck_command, "--newer-only", "--quiet", "--json", ""] if ARGV.include?("--debug")

IO.popen([HOMEBREW_BREW_FILE, livecheck_command, "--newer-only", "--quiet", "--json"]) {|brew_io|
  json_string = brew_io.read.strip

  require 'json'
  livecheck_array = JSON.parse(json_string)

  livecheck_array.each do |fc_hash|
    if fc_hash["version"]["outdated"] || fc_hash["version"]["newer_than_upstream"]
      fc_name = fc_hash["formula"] || fc_hash["cask"]
      new_hash[fc_name] = "#{fc_name} : #{fc_hash["version"]["current"]} ==> #{fc_hash["version"]["latest"]}"
    end
  end

  puts original_lines.map { |line|
    m = line.match(/^(.+?) : (.+?) ==> (.+)$/)
    next line if m.nil?
    fc_name = m.captures.first
    new_hash[fc_name]
  }.compact
}
