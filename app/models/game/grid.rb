class Game
  class Grid
    MIN_SIZE = 3
    DEAD_CELL = '.'.ord
    LIVE_CELL = '*'.ord
    attr_reader :generation, :height, :width, :body

    def initialize(generation: 1, height:, width:, body:)
      raise ArgumentError, 'generation must be an Integer >= 1' if !generation.is_a?(Integer) || generation < 1

      raise ArgumentError, "height must be an Integer >= #{MIN_SIZE}" if !height.is_a?(Integer) || height < MIN_SIZE

      raise ArgumentError, "width must be an Integer >= #{MIN_SIZE}" if !width.is_a?(Integer) || width < MIN_SIZE

      @generation = generation
      @height = height
      @width = width

      case body
      when Array
        body.size == height && body.all? { |row| row.size == width }
        @body = body.freeze
        @body.each(&:freeze)
      when String
        body = body.is_a?(String) && body.gsub("\n", '')
        if body&.match?(/\A[#{DEAD_CELL.chr}#{LIVE_CELL.chr}]{#{height * width}}\z/)
          @body = body.bytes.map { |i| i == LIVE_CELL }.each_slice(@width).map(&:freeze).to_a.freeze
        end
      end

      raise ArgumentError, "body must be a String (\'#{DEAD_CELL.chr}\', \'#{LIVE_CELL.chr}\')" unless @body
    end

    def to_s
      @body.map do |row|
        row.map { |i| i ? LIVE_CELL : DEAD_CELL }.pack('C*')
      end.join("\n")
    end

    def next
      next_body = body.map.with_index do |row, y|
        row.map.with_index { |i, x| survive?(i, y, x) }
      end
      self.class.new(generation: generation + 1, height: height, width: width, body: next_body)
    end

    def goto(num)
      if !num.is_a?(Integer) || num <= generation
        raise ArgumentError, "generation number must be an Integer > #{generation}"
      end

      (generation...num).inject(self) { |cur, _| cur.next }
    end

    protected

    def live_neighbours(cell, cur_y, cur_x)
      count = cell ? -1 : 0 # remove self cell from count
      (([0, cur_y - 1].max)..([height - 1, cur_y + 1].min)).each do |y|
        (([0, cur_x - 1].max)..([width - 1, cur_x + 1].min)).each do |x|
          count += 1 if body[y][x]
        end
      end
      count
    end

    def survive?(cell, y, x)
      case [cell, live_neighbours(cell, y, x)]
      in [false, 3]
        true
      in [true, 2..3]
        true
      else
        false
      end
    end
  end
end
