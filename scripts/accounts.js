(async () => {
    const accounts = await web3.eth.getAccounts();
    console.log(accounts, accounts.length);
    const balance = await web3.eth.getBalance(accounts[0]);
    console.log(balance);
    console.log(await web3.utils.fromWei(balance, "ether"));
})()