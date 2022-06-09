CLOCKWISE_FLOW = {
  north: :east,
  east: :south,
  south: :west,
  west: :north
}

ANTICLOCKWISE_FLOW = {
  north: :west,
  east: :north,
  south: :east,
  west: :south
}

class Robot
  attr_reader :current_position
  attr_reader :max_area_to_move
  attr_reader :facing

  def initialize(attributes)
    @current_position = attributes[:initial_position]
    @facing = attributes[:facing]
    @max_area_to_move = attributes[:max_area_to_move]
  end

  def left
    @facing = ANTICLOCKWISE_FLOW[@facing]
  end

  def right
    @facing = CLOCKWISE_FLOW[@facing]
  end

  def move
    move_to_north if (@facing == :north)
    move_to_east if (@facing == :east)
    move_to_south if (@facing == :south)
    move_to_west if (@facing == :west)
  end

  def move_to_north
    current_y_position = @current_position[1]
    new_y_position = current_y_position - 1

    if new_y_position >= 0
      @current_position[1] = new_y_position
    end
  end

  def move_to_east
    current_x_position = @current_position[0]
    max_x_moviment = @max_area_to_move[0] - 1
    new_x_position = current_x_position + 1

    if new_x_position <= max_x_moviment
      @current_position[0] = new_x_position
    end
  end

  def move_to_south
    current_y_position = @current_position[1]
    max_y_moviment = @max_area_to_move[1] - 1
    new_y_position = current_y_position + 1

    if new_y_position <= max_y_moviment
      @current_position[1] = new_y_position
    end
  end

  def move_to_west
    current_x_position = @current_position[0]
    new_x_position = current_x_position - 1

    if new_x_position >= 0
      @current_position[0] = new_x_position
    end
  end

  def current_position_report
    print "#{@current_position[0]},#{@current_position[1]},#{@facing.upcase}"
  end

  private :move_to_north, :move_to_east, :move_to_south, :move_to_west
end