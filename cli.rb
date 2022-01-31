#!/usr/bin/env ruby

# Importing Utils and Grid the cli command remain clean and small
require_relative 'app/models/game/utils'
require_relative 'app/models/game/grid'

file_path = ARGV[0]
unless file_path
  warn "File path missing!\n\nUsage: ./cli.rb file_path\n\n"
  exit(-1)
end

trap('SIGINT') do
  puts "\nStopping simulation..."
  exit
end

grid = Game::Utils.grid_from_file(file_path)

puts 'Stop simulation with CTRL+C, press enter for next'
loop do
  $stdin.gets
  puts Game::Utils.grid_to_string(grid)
  grid = grid.next
end
