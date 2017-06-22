module ToyRobot
  class Robot
    attr_reader :direction, :table
    DIRECTIONS = {
      'NORTH' => [0, 1],
      'EAST' => [1, 0],
      'SOUTH' => [0, -1],
      'WEST' => [-1, 0]
    }.freeze

    def initialize(args)
      @table = args[:table]
    end

    def move
      table.placing_relatively!(*DIRECTIONS[direction])
    end

    def place(args)
      x = args.fetch(:x)
      y = args.fetch(:y)
      new_direction = args.fetch(:direction)
      return unless valid_direction?(new_direction)

      table.placing!(x, y).tap do |t|
        @direction = new_direction if t
      end
    end

    def report
      not_placed? ? '' : "#{table},#{direction}"
    end

    def left
      return if not_placed?
      @direction = direction_offset(-1)
    end

    def right
      return if not_placed?
      @direction = direction_offset(1)
    end

    private

    def not_placed?
      !table.placed?
    end

    def valid_direction?(new_direction)
      DIRECTIONS.keys.include?(new_direction)
    end

    def direction_offset(offset)
      index = (DIRECTIONS.keys.index(direction) + offset) % DIRECTIONS.size
      DIRECTIONS.keys[index]
    end
  end
end
