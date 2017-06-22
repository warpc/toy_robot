module ToyRobot
  class SquareTabletop
    attr_reader :current_position, :length

    def initialize(args)
      @length = args[:length]
    end

    def placing!(x, y)
      @current_position = {x: x, y: y} if valid_place?(x, y)
    end

    def placing_relatively!(x, y)
      placing!(current_position[:x] + x, current_position[:y] + y) if placed?
    end

    def placed?
      !current_position.nil?
    end

    def to_s
      placed? ? "#{current_position[:x]},#{current_position[:y]}" : ''
    end

    private

    def valid_place?(x, y)
      x >= 0 && x <= length - 1 &&
        y >= 0 && y <= length - 1
    end
  end
end
