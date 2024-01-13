(async() => {

    const address = "0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B";
    const abi = [
	{
		"inputs": [],
		"name": "myUint",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "newUint",
				"type": "uint256"
			}
		],
		"name": "setMyUint",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
];


    const contractInstance = new web3.eth.Contract(abi, address);

    console.log(await contractInstance.methods.myUint().call());

    const accounts = await web3.eth.getAccounts();
    const txResult = await contractInstance.methods.setMyUint(600).send({from: accounts[0]});

    console.log(await contractInstance.methods.myUint().call());
    console.log(txResult);
})()