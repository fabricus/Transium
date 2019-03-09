# Installation steps

To keep the repo lean, we've excluded all modules from node_modules so you should install them manually:
```
npm init
npm install zos
npm install truffle@5.0.4
npm install zos-lib
```
We'll need to install an EVM Registry (by ZepplinOS) so that we don't waste too many ressources:
```
npx zos link openzeppelin-eth
```

Now we can add the contract(s) to the project:
```
npx zos add MyTransium
```

To deploy (compile for now) the contract to an ETH address you can use the following command (replacing the ETH address by one you own) assuming your deploying that on a local blockchain like Ganache:
```
npx zos session --network local --from 0x2dDc168B7Aa06Cf2c8Ab68eF74818120915eb307 --expires 3600
npx zos push
```

WARNING: if you're working on a local blockchain and if that's the first time you use openzeppelin-eth then you need to add a flag to the previous 'push' command:
```
npx zos push --deploy-dependencies
```

You can then initialize (publish) the contract:
```
npx zos create MyTransium --init initialize --args Transium,TRZ
```

# Publishing to testnet (ropsten, rinkeby, etc.) or mainnet
First, you'll probably need to add an npm module:
```
npm install truffle-hdwallet-provider
```
In `truffle-config.js` add the following lines at the beggining of the file:
```js
'use strict';

var HDWalletProvider = require("truffle-hdwallet-provider");
var mnemonic = "SEED_OF_YOUR_WALLET";
```
And then, for each network you want to support, simply add the following (example bellow for ropsten, just change the network name by mainnet, rinkeby or any network you want to set up and that's supported by Infura):
```js
ropsten: {
  provider: function() {
    return new HDWalletProvider(mnemonic, "https://ropsten.infura.io/v3/[YOUR_INFURA_PROJECT_ID]")
  },
  gas: 5000000,
  gasPrice: 5e9,
  network_id: 1
}
```
Once it's done, simply:
```
zos push --network ropsten
```
