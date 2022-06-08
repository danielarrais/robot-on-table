require_relative "robot"
require_relative "input_commands_processor"

class TableGame
  def initialize(table_size = [5, 5])
    @table_size = table_size

    map_robot_controls
  end

  def execute(commands)
    return if commands.nil? || commands.empty?

    runnable_commands = InputCommandsProcessor.new(commands).process
    place_command = runnable_commands.shift

    return unless valid_place_command?(place_command)

    place_robot(place_command[:params])

    runnable_commands.each do |command|
      command_name = command[:name]
      @robot_controls[command_name].call
    end
  end

  private

  def valid_place_command?(command)
    params = command[:params]

    if params[:x] <= @table_size[0] && params[:y] <= @table_size[1]
      return true
    end

    false
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
