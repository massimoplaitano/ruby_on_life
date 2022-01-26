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

        Game::Grid.new(**args)
      ensure
        file&.close
      end

      def grid_to_string(grid)
        "Generation #{grid.generation}:\n#{grid.height} #{grid.width}\n#{grid}"
      end
    end
  end
end
