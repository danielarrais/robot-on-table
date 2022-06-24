const COMMANDS = {
    place: 'PLACE',
    move: 'MOVE',
    left: 'LEFT',
    right: 'RIGHT',
    report: 'REPORT',
};

const FACINGS = {
    north: 'NORTH',
    east: 'EAST',
    south: 'SOUTH',
    west: 'WEST'
}

const PLACE_COMMAND_REGEX = `/(\b${COMMANDS.place}\b) \d+,\d+,((\b${FACINGS.north}\b)|(\b${FACINGS.east}\b)|(\b${FACINGS.north}\b)|(\b${FACINGS.west}\b))/`;
const OTHER_COMMANDS_REGEX = `/(\b${COMMANDS.right}\b)|(\b${COMMANDS.move}\b)|(\b${COMMANDS.left}\b)|(\b${COMMANDS.report}\b)/`;
const COMMANDS_REGEX_VALIDATION = {
    [COMMANDS.place]: PLACE_COMMAND_REGEX,
    [COMMANDS.right]: OTHER_COMMANDS_REGEX,
    [COMMANDS.left]: OTHER_COMMANDS_REGEX,
    [COMMANDS.right]: OTHER_COMMANDS_REGEX,
    [COMMANDS.report]: OTHER_COMMANDS_REGEX,
};

export {COMMANDS, FACINGS, COMMANDS_REGEX_VALIDATION};