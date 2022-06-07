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

    def move
        moveToNorth() if (facing == :north)
        moveToEast() if (facing == :east)
        moveToSouth() if (facing == :south)
        moveToWest() if (facing == :west)
        
        puts "Moved to [#{@currentPosition[0]},#{@currentPosition[1]}]"
    end

    def moveToNorth
        currentYPosition = @currentPosition[1]
        newYPosition = currentYPosition - 1

        if(newYPosition >= 0)
            @currentPosition[1] = newYPosition
        end
    end

    def moveToEast
        currentXPosition = @currentPosition[0]
        maxXMovimentation = @maxAreaToMove[0]
        newXPosition = currentXPosition + 1

        if (newXPosition <= maxXMovimentation)
            @currentPosition[0] = newXPosition
        end
    end
    
    def moveToSouth
        currentYPosition = @currentPosition[1]
        maxYMovimentation = @maxAreaToMove[1]
        newYPosition = currentYPosition + 1

        if(newYPosition <= maxYMovimentation)
            @currentPosition[1] = newYPosition
        end
    end
    
    def moveToWest
        currentXPosition = @currentPosition[0]
        maxXMovimentation = @maxAreaToMove[0]
        newXPosition = currentXPosition - 1

        if (newXPosition >= 0)
            @currentPosition[0] = newXPosition
        end
    end
    
    private :moveToNorth, :moveToEast, :moveToSouth, :moveToWest
end