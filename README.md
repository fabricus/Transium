# Installation steps

To keep the repo lean, we've excluded all modules from node_modules so you should install them manually:
```
npm init
npm install zos
npm install truffle@5.0.4
npm install zos-lib
```
You need to create 2 files at the root of the projet: `.key` and `.secret`. `.key` should only contain a single string representing your INFURA API KEY (something like `732...1c6e2`) - It's not necessary if you are running a local blockchain. The file `.secret` should contain the 1é words seed/mnemonic used to generate your wallet (whatever you're running this on a local blockchain or a testnet or even mainnet you'll need that).

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
The `truffle-config.js` file provided here contains examples for local network and Ropsten testnet but if you want to add a new one (like mainnet for example) simply add another bloc like this:
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
