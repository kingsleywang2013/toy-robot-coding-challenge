require_relative './errors'
require_relative './utility'
require_relative './table'
require_relative './robot'
require 'pry'

class Simulator
  include Utility

  COMMANDS = %w[PLACE MOVE LEFT RIGHT REPORT].freeze

  def initialize
    @table = Table.new
    @robot = nil
  end

  def run(command)
    # Split user input command to two parts
    # func is a command action such as 'PLACE', 'MOVE', 'LEFT', 'RIGHT', 'REPORT'
    # args is a set of position and direction such as '1,2,NORTH'

    # Get func and args if command is not single word
    action, args = extract_action_args_from_command(command)

    validate_action_args(action, args)

    run_actions(action, args) unless action.nil?
  end

  private

  def run_actions(action, args)
    if action == 'PLACE'
      pos_x, pos_y, direction = args.split(',')
      @robot = @table.place_robot(pos_x: pos_x.to_i, pos_y: pos_y.to_i, direction: direction.strip)
      return
    else
      run_robot_actions(action)
    end
  end

  def run_robot_actions(action)
    if @robot.nil?
      raise Errors::RobotNotPlace, "Robot is still not placed on the table, pleae run 'PLACE' first"
    end

    case action
    when 'MOVE'
      @robot.move
      return
    when 'LEFT'
      @robot.turn_left
      return
    when 'RIGHT'
      @robot.turn_right
      return
    when 'REPORT'
      @robot.display_report
    end
  end
end
