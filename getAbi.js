const fs = require('fs');
const contract = JSON.parse(fs.readFileSync('./build/contracts/MyTransium.json', 'utf8'));
console.log(JSON.stringify(contract.abi));
