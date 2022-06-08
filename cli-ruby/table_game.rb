require_relative "robot"

class TableGame
  def initialize(table_size = [5, 5])
    @table_size = table_size

    map_robot_controls
  end

  def execute(commands = [])
    return if commands.empty?

    place_command = commands.shift
    place_robot(place_command[:params])

    commands.each do |command|
      command_name = command[:name]
      @robot_controls[command_name].call
    end
  end

  private

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
