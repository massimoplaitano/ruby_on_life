class Game
  class Utils
    class << self
      def grid_from_file(file_or_path)
        file = case file_or_path
               when ::String, ::Pathname
                 file = File.open(file_or_path, 'r')
               when ::File, ::Tempfile
                 file = file_or_path
               else
                 raise ArgumentError, 'file must be a path or an opened file'
               end

        args = {}

        case file.readline
        when /^Generation\s+(\d+):$/
          args[:generation] = Regexp.last_match(1).to_i
        else
          raise ArgumentError, 'File format invalid'
        end

        case file.readline
        when /^(\d+)\s+(\d+)$/
          args[:height] = Regexp.last_match(1).to_i
          args[:width] = Regexp.last_match(2).to_i
        else
          raise ArgumentError, 'File format invalid'
        end

        args[:body] = file.read

        Grid.new(**args)
      ensure
        file&.close
      end

      def grid_to_string(grid)
        "Generation #{grid.generation}:\n#{grid.height} #{grid.width}\n#{grid}"
      end

      def game_from_grid(grid)
        Game.new(
          generation: grid.generation,
          height: grid.height,
          width: grid.width,
          grid_body: grid.body
        )
      end

      def grid_from_game(game)
        Grid.new(
          generation: game.generation,
          height: game.height,
          width: game.width,
          body: game.grid_body
        )
      end

      def grid_to_svg_path(grid)
        cells = []
        y = 0
        grid.body.map do |row|
          x = 0
          row.map do |cell|
            cells << "M#{x} #{y}h1v1h-1v-1" if cell
            x += 1
          end
          y += 1
        end
        cells.join(' ')
      end
    end
  end
end
