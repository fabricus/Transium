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
npx zos session --network local --from YOUR_ETH_ADDR --expires 3600
npx zos push
```

WARNING: if you're working on a local blockchain and if that's the first time you use openzeppelin-eth then you need to add a flag to the previous 'push' command:
```
npx zos push --deploy-dependencies
```

You can then initialize (publish) the contract:
```
npx zos create MyTransium --init initialize --args Transium,TRZ,[ETH_ADDR_THAT_CAN_MINT],[ETH_ADDR_THAT_CAN_PAUSE]
```

# Publishing to testnet (ropsten, rinkeby, etc.) or mainnet
First, you'll probably need to add an npm module:
```
npm install truffle-hdwallet-provider
```
You can copy/paste the content of `dummy-truffle-config.js` into `truffle-config.js` (remove existing content) and simply update your INFURA_KEY as well as your ".secret" file (actually you'll have to create that file and it should only contain your mnemonic / 12 words seed).

The dummy file contains examples for local netword and Ropsten testnet but if you want to add a new one (like mainnet for example) simply add another bloc like this:
```js
mainnet: {
  provider: function() {
    return new HDWalletProvider(mnemonic, "https://mainnet.infura.io/v3/[YOUR_INFURA_PROJECT_ID]")
  },
  gas: 5000000,
  gasPrice: 5e9,
  network_id: 1
}
```

Once it's done (example for deploying on Ropsten), simply:
```
zos push --network ropsten
```
