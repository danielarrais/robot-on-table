require_relative "robot"
require_relative "input_commands_processor"

class TableGame
  def initialize(table_size = [5, 5])
    @table_size = table_size

    map_robot_controls
  end

  def execute(commands)
    processed_commands = InputCommandsProcessor.new(commands).process
    valids_commands = filter_valid_commands(processed_commands)
    return if valids_commands.nil? || valids_commands.empty?

    valids_commands.each do |command|
      command_name = command[:name].upcase
      if command_name == :PLACE
        place_robot(command[:params])
      else
        @robot_controls[command_name].call
      end
    end
  end

  private

  def filter_valid_commands(commands)
    valid_commands = []

    commands.each do |command|
      is_place_command = command[:name] == :PLACE
      is_valid_place_command = is_place_command && valid_place_command?(command)
      is_valid_moviment_command = !is_place_command && valid_moviment_command?(command)

      if is_valid_place_command || (!valid_commands.empty? && is_valid_moviment_command)
        valid_commands.push(command)
      end
    end

    valid_commands
  end

  def valid_place_command?(command)
    params = command[:params]

    if params[:x] < @table_size[0] && params[:y] < @table_size[1]
      return true
    end

    false
  end

  def valid_moviment_command?(command)
    command_name = command[:name]

    if @robot_controls[command_name].nil?
      return false
    end

    true
  end

  def place_robot(params)
    @robot = Robot.new(
      initial_position: [params[:x], params[:y]],
      max_area_to_move: @table_size,
      facing: params[:facing]
    )
  end

  def map_robot_controls
    @robot_controls = {
      MOVE: -> { @robot.move },
      LEFT: -> { @robot.left },
      RIGHT: -> { @robot.right },
      REPORT: -> { @robot.current_position_report },
    }
  end
end
