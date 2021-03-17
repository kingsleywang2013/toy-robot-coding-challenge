class Robot
  attr_accessor :table

  DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

  include Utility

  def initialize(pos_x:, pos_y:, direction:)
    @pos_x = pos_x
    @pos_y = pos_y
    @direction = direction
  end

  def move
    case @direction
    when 'NORTH'
      set_position(@pos_x, @pos_y + 1)
    when 'EAST'
      set_position(@pos_x + 1, @pos_y)
    when 'SOUTH'
      set_position(@pos_x, @pos_y - 1)
    when 'WEST'
      set_position(@pos_x - 1, @pos_y)
    end
  end

  def turn_left
    index = DIRECTIONS.index(@direction)
    @direction = index.zero? ? DIRECTIONS[-1] : DIRECTIONS[index - 1]
  end

  def turn_right
    index = DIRECTIONS.index(@direction)
    @direction = index == DIRECTIONS.length - 1 ? DIRECTIONS[0] : DIRECTIONS[index + 1]
  end

  def display_report
    "Output: #{@pos_x },#{@pos_y},#{@direction}"
  end

  private

  def set_position(pos_x, pos_y)
     # Check if the position is valid (inside of table 5 x 5 units)
    validate_robot_position(pos_x: pos_x, pos_y: pos_y, table: table, robot: self)

    @pos_x = pos_x
    @pos_y = pos_y
  end
end
