#!/usr/bin/env ruby

require "json"

log = ARGF.read

clang_commands = log.scan(/^.*clang\s.*?\s-c\s.*$/)
db_entries = clang_commands.collect do |command|
    path = command.match(/(?<=\s-c\s).*?(?=\s)/)[0]
    path = File.expand_path(path)
    { directory: File.dirname(path), command: command.strip, file: path }
end

db_file = File.new("compile_commands.json", "w+")
db_file.puts(JSON.pretty_generate(db_entries))
db_file.close
