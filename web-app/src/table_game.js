import InputCommandsProcessor from "./input_commands_processor.js";
import Robot from "./robot.js";

class _TableGame {
    constructor(tableSize = [5, 5], onChangeTable) {
        this.tableSize = tableSize;
        this.robot = {}
        this.onChangeTable = onChangeTable;

        this.mapRobotControls();
    }

    execute(commands) {
        const processedCommands = InputCommandsProcessor(commands).process();
        const validsCommands = this.filterValidCommands(processedCommands);

        validsCommands.forEach(command => {
            if (command.name === 'PLACE') {
                this.placeRobot(command.params)
            } else {
                this.robotControls[command.name]();
            }
        })
    }

    filterValidCommands(commands) {
        const validCommands = []

        commands.forEach(command => {
            const isPlaceCommand = command.name === 'PLACE';
            const isValidPlaceCommand = isPlaceCommand && this.validPlaceCommand(command);

            const isValidMovimentCommand = !isPlaceCommand && this.validMovimentCommand(command);
            const canInsertMovimentCommand = !(validCommands.length === 0) && isValidMovimentCommand

            if (isValidPlaceCommand || canInsertMovimentCommand) {
                validCommands.push(command)
            }
        })

        return validCommands;
    }

    validPlaceCommand(command) {
        const params = command.params
        const validParamsPosition = params.x < this.tableSize[0] && params.y < this.tableSize[1]
        return validParamsPosition;
    }

    validMovimentCommand(command) {
        return this.robotControls[command.name] !== undefined;
    }

    mapRobotControls() {
        this.robotControls = {
            'MOVE': () => {
                this.robot.move();
                this.onChangeTable(this.robot.getCurrentPosition());
            },
            'LEFT': () => {
                this.robot.left();
                this.onChangeTable(this.robot.getCurrentPosition());
            },
            'RIGHT': () => {
                this.robot.right();
                this.onChangeTable(this.robot.getCurrentPosition());
            },
            'REPORT': () => this.robot.currentPositionReport(),
        };
    }

    placeRobot(params) {
        this.robot = Robot([params.x, params.y], this.tableSize, params.facing);
        this.onChangeTable(this.robot.getCurrentPosition());
    }
}

const TableGame = (tableSize, onChangeTable) => {
    const tableGame = new _TableGame(tableSize, onChangeTable);

    return {
        execute: (commands) => tableGame.execute(commands)
    }
}

export default TableGame;