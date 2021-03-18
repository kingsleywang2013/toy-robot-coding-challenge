require_relative './utility'

class Table
  attr_reader :width, :height

  include Utility

  def initialize(width: 5, height: 5)
    @width = width
    @height = height
  end

  def place_robot(pos_x:, pos_y:, direction:)
    # Check if the place position is valid (inside of table 5 x 5 units)
    validate_robot_position(pos_x: pos_x, pos_y: pos_y, table: self)

    robot = Robot.new(pos_x: pos_x, pos_y: pos_y, direction: direction)
    robot.table = self
    robot
  end
end
