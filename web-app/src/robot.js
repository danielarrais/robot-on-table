const clockwiseFlow = {
    'NORTH': 'EAST',
    'EAST': 'SOUTH',
    'SOUTH': 'WEST',
    'WEST': 'NORTH'
}

const anticlockwiseFlow = {
    'NORTH': 'WEST',
    'EAST': 'NORTH',
    'SOUTH': 'EAST',
    'WEST': 'SOUTH'
}

class _Robot {
    constructor(currentPosition, maxAreaToMove, facing) {
        this.currentPosition = currentPosition
        this.maxAreaToMove = maxAreaToMove
        this.facing = facing
    }

    left() {
        this.facing = anticlockwiseFlow[this.facing];
    }

    right() {
        this.facing = clockwiseFlow[this.facing];
    }

    move() {
        const mapControls = {
            'NORTH': () => this.moveToNorth(),
            'EAST': () => this.moveToEast(),
            'SOUTH': () => this.moveToSouth(),
            'WEST': () => this.moveToWest(),
        };
        debugger;
        mapControls[this.facing]();
    }

    moveToNorth() {
        const currentYPosition = this.currentPosition[1];
        const newYPosition = currentYPosition - 1;

        if (newYPosition >= 0) {
            this.currentPosition[1] = newYPosition;
        }
    }

    moveToEast() {
        const currentXPosition = this.currentPosition[0];
        const maxXMoviment = this.maxAreaToMove[0] - 1;
        const newXPosition = currentXPosition + 1;

        if (newXPosition <= maxXMoviment) {
            this.currentPosition[0] = newXPosition;
        }
    }

    moveToSouth() {
        const currentYPosition = this.currentPosition[1];
        const maxYMoviment = this.maxAreaToMove[1] - 1;
        const newYPosition = currentYPosition + 1;

        if (newYPosition <= maxYMoviment) {
            this.currentPosition[1] = newYPosition;
        }
    }

    moveToWest() {
        const currentXPosition = this.currentPosition[0];
        const newXPosition = currentXPosition - 1;
        debugger
        if (newXPosition >= 0) {
            this.currentPosition[0] = newXPosition;
        }
    }

    getCurrentPosition() {
        return {
            x: this.currentPosition[0],
            y: this.currentPosition[1],
            facing: this.facing,
        }
    }

    currentPositionReport() {
        console.log(`${this.currentPosition[0]},${this.currentPosition[1]},${this.facing}`)
    }
}

const Robot = (currentPosition, maxAreaToMove, facing) => {
    const robot = new _Robot(currentPosition, maxAreaToMove, facing);

    return {
        left: () => robot.left(),
        right: () => robot.right(),
        move: () => robot.move(),
        currentPositionReport: () => robot.currentPositionReport(),
        getCurrentPosition: () => robot.getCurrentPosition(),
    }
}

export default Robot;
