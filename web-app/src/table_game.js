import Robot from "./robot.js";
import {COMMANDS} from "./constants.js";

class _TableGame {
    constructor(tableSize = [5, 5], onChangeTable) {
        this.tableSize = tableSize;
        this.robot = {};
        this.onChangeTable = onChangeTable || this.defaultOnChangeTable;

        this.mapRobotControls();
    }

    execute(commands) {
        const validsCommands = this.filterValidCommands(commands);
        this.runCommands(validsCommands);
    }

    runCommands(commands) {
        commands?.forEach(command => {
            if (command.name === COMMANDS.place) {
                this.placeRobot(command.params);
            } else {
                this.robotControls[command.name]();
            }
        });
    }

    filterValidCommands(commands) {
        const validCommands = [];

        commands?.forEach(command => {
            const hasPlaceCommand = !(validCommands.length === 0);
            const isPlaceCommand = command.name === COMMANDS.place;
            const isValidPlaceCommand = isPlaceCommand && this.isValidPlaceCommand(command);
            const isValidMovimentCommand = !isPlaceCommand && hasPlaceCommand && this.isValidMovimentCommand(command);

            if (isValidPlaceCommand || isValidMovimentCommand) {
                validCommands.push(command);
            }
        })

        return validCommands;
    }

    isValidPlaceCommand(command) {
        const params = command.params;
        const isValidXCoordinate = params.x >= 0 && params.x < this.tableSize[0];
        const isValidYCoordinate = params.y >= 0 && params.y < this.tableSize[0];

        return isValidXCoordinate && isValidYCoordinate;
    }

    isValidMovimentCommand(command) {
        return this.robotControls[command.name] !== undefined;
    }

    mapRobotControls() {
        this.robotControls = {
            [COMMANDS.move]: () => {
                this.robot.move();
                this.onChangeTable(this.robot.getCurrentPosition());
            },
            [COMMANDS.left]: () => {
                this.robot.left();
                this.onChangeTable(this.robot.getCurrentPosition());
            },
            [COMMANDS.right]: () => {
                this.robot.right();
                this.onChangeTable(this.robot.getCurrentPosition());
            },
            [COMMANDS.report]: () => this.robot.currentPositionReport(),
        };
    }

    placeRobot(params) {
        this.robot = Robot([params.x, params.y], this.tableSize, params.facing);
        this.onChangeTable(this.robot.getCurrentPosition());
    }

    defaultOnChangeTable(position) {}
}

const TableGame = (tableSize, onChangeTable) => {
    const tableGame = new _TableGame(tableSize, onChangeTable);

    return {
        execute: (commands) => tableGame.execute(commands)
    }
}

export default TableGame;