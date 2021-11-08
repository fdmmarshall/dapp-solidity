const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const memeContractFactory = await hre.ethers.getContractFactory('MemePortal');
    const memeContract = await memeContractFactory.deploy();
    await memeContract.deployed();
  
    console.log("Contract deployed to:", memeContract.address);
    console.log("Contract deployed by:", owner.address);
  
    let memeCount;
    memeCount = await memeContract.getTotalMemes();
    
    let memeTxn = await memeContract.sendMeme();
    await memeTxn.wait();
  
    memeCount = await memeContract.getTotalMemes();

    memeTxn = await memeContract.connect(randomPerson).sendMeme();
    await memeTxn.wait();

    memeCount = await memeContract.getTotalMemes();
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();