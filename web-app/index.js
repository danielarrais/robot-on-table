import TableGame from "./src/table_game.js";

const tableSize = [5, 5];

const timeout = (ms) => {
    return new Promise(resolve => setTimeout(resolve, ms));
}

const mountTable = (positionOfRobot) => {
    const table = $("#bodyTable");
    table.empty();
    for (let y = 0; y < tableSize[0]; y++) {
        const row = $('<tr></tr>');
        for (let x = 0; x < tableSize[1]; x++) {
            const isCurrentRobotPosition = positionOfRobot && positionOfRobot.x === x && positionOfRobot.y === y
            if (isCurrentRobotPosition) {
                row.append(`<td>${positionOfRobot.x},${positionOfRobot.y},${positionOfRobot.facing}</td>`);
            } else {
                row.append("<td></td>");
            }
        }
        table.append(row);
    }
};

const runQueueFunctions = (commands) => {
    (async () => {
        for (const command of commands) {
            await timeout(1000);
            command();
        }
    })()
}

const runGame = () => {
    const commandsQueue = [];
    const commands = $('#commandInput').val();

    mountTable();
    TableGame(tableSize, (position) => {
        commandsQueue.push(() => {
            mountTable(position);
            console.log(`${position.x},${position.y},${position.facing}`)
        });
    }).execute(commands);

    runQueueFunctions(commandsQueue);
};

mountTable();
window.runGame = runGame;