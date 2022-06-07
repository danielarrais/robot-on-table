NEXT_FACING = {
    north: :east,
    east: :south,
    south: :west,
    west: :north
}

PREVIOUS_FACING = {
    north: :west,
    east: :north,
    south: :east,
    west: :south
}

class Robot {
    attr_reader :currentPosition;
    attr_reader :maxAreaToMove;
    attr_reader :facing;
    
    def initialize(attributes)
        @currentPosition = attributes.initialPosition
        @facing = attributes.facing.to_sym
        @maxAreaToMove = attributes.maxAreaToMove
    end

    def left() {
        @facing = NEXT_FACING[@facing]
        puts "Rotated to #{@facing}"
    }

    def rigth() {
        @facing = PREVIOUS_FACING[@facing]
        puts "Rotated to #{@facing}"
    }

    def move() {
        
    }
}