const main = async () => {
  const memeContractFactory = await hre.ethers.getContractFactory('MemePortal');
  const memeContract = await memeContractFactory.deploy();
  await memeContract.deployed();
  console.log('Contract addy:', memeContract.address);

  // console.log("Contract deployed to:", memeContract.address);
  // console.log("Contract deployed by:", owner.address);

  let memeCount;
  memeCount = await memeContract.getTotalMemes();
  console.log(memeCount.toNumber());

  let memeTxn = await memeContract.sendMeme(
    'https://bafybeihko3uz7xx7ryhygibbzz7dr5g4hyyxntpuk6ujvvgdqbyacje7qi.ipfs.infura-ipfs.io/'
  );
  await memeTxn.wait();

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
