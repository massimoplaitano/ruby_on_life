#!/usr/bin/env ruby

require './app/models/game/grid'

file_path = ARGV[0]
unless file_path
  $stderr.puts "File path missing"
  exit(-1)
end

File.open(file_path, 'r') do |f|
  case f.readline
  when /^Generation\s+(\d+):$/
    @generation = $1.to_i
  else
    raise ArgumentError, 'File format invalid'
  end

  case f.readline
  when /^(\d+)\s+(\d+)$/
    @height = $1.to_i
    @width = $2.to_i
  else
    raise ArgumentError, 'File format invalid'
  end

  @body = f.read
end

def pretty_print(grid)
  "Generation #{grid.generation}:\n#{grid.height} #{grid.width}\n#{grid}"
end

trap('SIGINT') do
  puts "\nStopping simulation..."
  exit
end

puts 'Stop simulation with CTRL+C, press enter for next'
grid = Game::Grid.new(generation: @generation, height: @height, width: @width, body: @body)
loop do
  $stdin.gets
  puts pretty_print(grid)
  grid = grid.next
end
