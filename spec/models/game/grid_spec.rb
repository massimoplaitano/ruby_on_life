require 'rails_helper'

RSpec.describe Game::Grid do
  describe('new') do
    it 'creates a game grid without generation' do
      grid = Game::Grid.new(height: 3, width: 3, body: '.*.' * 3)
      expect(grid).to be_a Game::Grid
      expect(grid.height).to eq 3
      expect(grid.width).to eq 3
      expect(grid.generation).to eq 1
    end

    it 'creates a game grid with generation' do
      grid = Game::Grid.new(generation: 123, height: 3, width: 3, body: '.*.' * 3)
      expect(grid).to be_a Game::Grid
      expect(grid.height).to eq 3
      expect(grid.width).to eq 3
      expect(grid.generation).to eq 123
    end

    it 'creates a game grid with array body' do
      body_array = [
        [false, true, false],
        [false, true, true],
        [false, false, false]
      ]
      body_string = <<~GRID.chomp
        .*.
        .**
        ...
      GRID
      grid = Game::Grid.new(generation: 123, height: 3, width: 3, body: body_array)
      expect(grid).to be_a Game::Grid
      expect(grid.to_s).to eq body_string
    end

    it 'raises error with missin arguments' do
      expect do
        Game::Grid.new(width: 3, body: '.' * 9)
      end.to raise_error(ArgumentError)
      expect do
        Game::Grid.new(height: 3, body: '.' * 9)
      end.to raise_error(ArgumentError)
      expect do
        Game::Grid.new(height: 3, width: 3)
      end.to raise_error(ArgumentError)
    end

    it 'raises error on incorrect sizes' do
      expect do
        Game::Grid.new(height: 2, width: 3, body: '.' * 6)
      end.to raise_error(ArgumentError)
      expect do
        Game::Grid.new(height: 3, width: 2, body: '.' * 6)
      end.to raise_error(ArgumentError)
      expect do
        Game::Grid.new(height: 3, width: 3, body: '.' * 8)
      end.to raise_error(ArgumentError)
      expect do
        Game::Grid.new(height: 3, width: 3, body: '.' * 10)
      end.to raise_error(ArgumentError)
    end

    it 'raises error on incorrect generation' do
      expect do
        Game::Grid.new(generation: 0, height: 3, width: 3, body: '.' * 9)
      end.to raise_error(ArgumentError)
      expect do
        Game::Grid.new(generation: -1, height: 3, width: 3, body: '.' * 9)
      end.to raise_error(ArgumentError)
      expect do
        Game::Grid.new(generation: '1', height: 3, width: 3, body: '.' * 9)
      end.to raise_error(ArgumentError)
      expect do
        Game::Grid.new(generation: nil, height: 3, width: 3, body: '.' * 9)
      end.to raise_error(ArgumentError)
    end
  end

  describe('to_s') do
    it 'print the grid' do
      grid_string = ".*.\n..*\n*..".freeze
      grid = Game::Grid.new(height: 3, width: 3, body: grid_string)
      expect(grid.to_s).to eq grid_string
    end
  end

  describe('next') do
    it 'return next generation grid' do
      gen1 = <<~GRID.chomp
        .*.
        .**
        ...
      GRID
      gen2 = <<~GRID.chomp
        .**
        .**
        ...
      GRID

      grid1 = Game::Grid.new(height: 3, width: 3, body: gen1)
      grid2 = grid1.next
      expect(grid2).to be_a Game::Grid
      expect(grid2.to_s).to eq gen2
    end
  end

  describe('goto') do
    it 'return nth generation grid' do
      gen1 = <<~GRID.chomp
        .*..
        ..*.
        ***.
        ....
      GRID
      gen4 = <<~GRID.chomp
        ....
        ..*.
        ...*
        .***
      GRID

      first_generation = 11
      grid1 = Game::Grid.new(generation: first_generation, height: 4, width: 4, body: gen1)
      grid4 = grid1.goto(first_generation + 3)
      expect(grid4).to be_a Game::Grid
      expect(grid4.to_s).to eq gen4
      expect do
        grid1.goto(first_generation)
      end.to raise_error(ArgumentError)
    end
  end
end
