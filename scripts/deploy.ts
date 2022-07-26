import { ethers } from "hardhat";

async function main() {
  // const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  // const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  // const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

  // const lockedAmount = ethers.utils.parseEther("1");

  //const Lock = await ethers.getContractFactory("Lock");
  //const lock = await Lock.deploy(unlockTime, { value: lockedAmount });

  //await lock.deployed();

  //console.log("Lock with 1 ETH deployed to:", lock.address);

  const XXXFactory = await ethers.getContractFactory("XXXFactory");
  const Factory = await XXXFactory.deploy();

  await Factory.deployed();

  console.log("Factory address : ", Factory.address);

  const XXXFund = await ethers.getContractFactory("XXXFund");
  const Fund = await XXXFund.deploy();

  await Fund.deployed();

  console.log("Fund address : ", Fund.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
