const main = async () => {
  const memeContractFactory = await hre.ethers.getContractFactory('MemePortal');
  const memeContract = await memeContractFactory.deploy({
    value: hre.ethers.utils.parseEther('0.1'),
  });
  await memeContract.deployed();
  console.log('Contract addy:', memeContract.address);

  // console.log("Contract deployed to:", memeContract.address);
  // console.log("Contract deployed by:", owner.address);

  let contractBalance = await hre.ethers.provider.getBalance(
    memeContract.address
  );
  console.log(
    'Contract Balance',
    hre.ethers.utils.formatEther(contractBalance)
  );

  let memeCount;
  memeCount = await memeContract.getTotalMemes();
  console.log(memeCount.toNumber());

  let memeTxn = await memeContract.sendMeme(
    'https://bafybeihko3uz7xx7ryhygibbzz7dr5g4hyyxntpuk6ujvvgdqbyacje7qi.ipfs.infura-ipfs.io/'
  );
  await memeTxn.wait();

  contractBalance = await hre.ethers.provider.getBalance(memeContract.address);
  console.log(
    'Contract balance:',
    hre.ethers.utils.formatEther(contractBalance)
  );

  const [_, randomPerson] = await hre.ethers.getSigners();
  memeTxn = await memeContract
    .connect(randomPerson)
    .sendMeme(
      'https://bafybeihko3uz7xx7ryhygibbzz7dr5g4hyyxntpuk6ujvvgdqbyacje7qi.ipfs.infura-ipfs.io/'
    );
  await memeTxn.wait();

  let allMemes = await memeContract.getAllMemes();
  console.log(allMemes);
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
