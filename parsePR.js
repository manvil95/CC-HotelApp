const fs = require('fs');
const readline = require('readline')

async function extractTests(){

    //by default we specify that all tests should run
    let testsFile = __dirname+'/testsToRun.txt';
    await fs.promises.writeFile(testsFile,'all');

    const lines = readline.createInterface({
        input: fs.createReadStream(__dirname+'/pr_body.txt'),
        crlfDelay: Infinity
    });

    for await (const line of lines) {
        //special delimiter for apex tests
        if (line.includes('Apex::[') && line.includes(']::Apex')) {
            let tests = line.substring(8, line.length - 7);
            let testsArray = tests.split(',');
            await fs.promises.writeFile(testsFile, ''); // Clear the file first
            for (const test of testsArray) {
                await fs.promises.appendFile(testsFile, `--array-flag ${test.trim()} `);
            }
        }
    }
}

extractTests();