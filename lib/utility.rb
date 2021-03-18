require_relative './errors'

module Utility
  def extract_action_args_from_command(command)
    command.split(' ', 2).compact
  end

  def validate_action_args(action, args)
    unless Simulator::COMMANDS.include?(action)
      raise Errors::InvalidAction, "#{action} is not a valid commmand"
    end

    if action == 'PLACE'
      validate_place_action_args(args)
    else
      validate_robot_actions_args(action, args)
    end
  end

  def validate_robot_position(pos_x:, pos_y:, table:, robot: nil)
    if pos_x < 0 || pos_y < 0 || pos_x > table.width || pos_y > table.height
      if robot
        raise Errors::MoveOutBoundary, "The next move position(x: #{pos_x}, y: #{pos_y}) will be out of table boundary (#{table.width} x #{table.height})"
      else
        raise Errors::PlaceOutBoundary, "Place position(x: #{pos_x}, y: #{pos_y}) is out of table boundary (#{table.width} x #{table.height})"
      end
    end
  end

  private

  def is_integer?(n)
    !!(n.match /^-|(\d)+$/)
  end

  def validate_place_action_args(args)
    validate_place_args(args)

    x, y, direction = args.split(',')

    validate_place_positions(x, y)

    validate_place_direction(direction.strip)
  end

  def validate_robot_actions_args(action, args)
    unless args.nil?
      raise Errors::WrongNumberArgs, "#{action} should not accept any other arguments"
    end
  end

  def validate_place_args(args)
    if args.nil? || args.split(',').size != 3
      raise Errors::WrongNumberArgs, "PLACE command should accept args follow the format like '1,1,NORTH'"
    end
  end

  def validate_place_positions(x, y)
    if !is_integer?(x.strip) || !is_integer?(y.strip)
      raise Errors::WrongPostionType, "Position must be Integer"
    end
  end

  def validate_place_direction(direction)
    if !Robot::DIRECTIONS.include?(direction)
      raise Errors::InvalidDirection, "#{direction} does not includes in #{Robot::DIRECTIONS}"
    end
  end
end
