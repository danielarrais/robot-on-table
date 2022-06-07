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
    attr_reader :currentPosition;
    attr_reader :maxAreaToMove;
    attr_reader :facing;
    
    def initialize(attributes)
        @currentPosition = attributes[:initialPosition]
        @facing = attributes[:facing]
        @maxAreaToMove = attributes[:maxAreaToMove]
    end

    def left()
        @facing = CLOCKWISE_FLOW[@facing]
        puts "Rotated to #{@facing}"
    end

    def rigth()
        @facing = ANTICLOCKWISE_FLOW[@facing]
        puts "Rotated to #{@facing}"
    end
end