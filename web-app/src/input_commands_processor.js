const PLACE_COMMAND_REGEX = /(\bPLACE\b) \d+,\d+,((\bNORTH\b)|(\bEAST\b)|(\bSOUTH\b)|(\bWEST\b))/
const OTHER_COMMANDS_REGEX = /(\bMOVE\b)|(\bLEFT\b)|(\bRIGHT\b)|(\bREPORT\b)/
const commandsRegexValidation = {
    'PLACE': PLACE_COMMAND_REGEX,
    'MOVE': OTHER_COMMANDS_REGEX,
    'LEFT': OTHER_COMMANDS_REGEX,
    'RIGHT': OTHER_COMMANDS_REGEX,
    'REPORT': OTHER_COMMANDS_REGEX,
}

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
            const isPlaceCommand = command.includes('PLACE');
            const buildedCommand = isPlaceCommand ? this.buildPlaceCommand(command) : this.buildMovimentCommand(command)
            buildedCommands.push(buildedCommand)
        })
        return buildedCommands;
    }

    isValidCommand(command) {
        const regexValidation = commandsRegexValidation[command] || commandsRegexValidation.PLACE
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