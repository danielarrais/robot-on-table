import {COMMANDS, COMMANDS_REGEX_VALIDATION} from "./constants.js";

class _InputCommandsProcessor {
    constructor(commands) {
        this.commandsInput = commands;
    }

    process() {
        if (!this.commandsInput) return [];
        const commands = this.commandsInput.toUpperCase().split(/(\n)/);
        const validsCommands = this.filterValidCommands(commands)
        return this.buildCommands(validsCommands)
    }

    filterValidCommands(commands) {
        if (!commands) return [];
        return commands.filter((command) => this.isValidCommand(command));
    }

    buildCommands(commands) {
        if (!commands) return [];
        const buildedCommands = []
        commands.forEach(command => {
            const isPlaceCommand = command.includes(COMMANDS.place);
            const buildedCommand = isPlaceCommand ? this.buildPlaceCommand(command) : this.buildMovimentCommand(command)
            buildedCommands.push(buildedCommand)
        })
        return buildedCommands;
    }

    isValidCommand(command) {
        const regexValidation = COMMANDS_REGEX_VALIDATION[command] || COMMANDS_REGEX_VALIDATION.PLACE
        return regexValidation.test(command);
    }

    buildPlaceCommand(command) {
        const partsOfCommand = command.split(' ')
        const name = partsOfCommand[0]
        const params = partsOfCommand[1].split(',')
        return {
            name: name,
            params: {
                x: parseInt(params[0]),
                y: parseInt(params[1]),
                facing: params[2]
            }
        }
    }

    buildMovimentCommand(command) {
        return {name: command}
    }
}

const InputCommandsProcessor = (commands) => {
    const inputCommandsProcessor = new _InputCommandsProcessor(commands);

    return {
        process: () => inputCommandsProcessor.process(),
    }
}

export default InputCommandsProcessor;