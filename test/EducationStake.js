const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("EducationStake", function () {
  let EducationStake, educationStake, owner, addr1, addr2;

  beforeEach(async function () {
    [owner, addr1, addr2, _] = await ethers.getSigners();

    const VRFCoordinatorMock = await ethers.getContractFactory("VRFCoordinatorMock");
    const vrfCoordinatorMock = await VRFCoordinatorMock.deploy();
    await vrfCoordinatorMock.deployed();

    const LinkToken = await ethers.getContractFactory("LinkToken");
    const linkToken = await LinkToken.deploy();
    await linkToken.deployed();

    EducationStake = await ethers.getContractFactory("EducationStake");
    educationStake = await EducationStake.deploy(
      vrfCoordinatorMock.address,
      linkToken.address,
      ethers.utils.formatBytes32String("keyHash"),
      ethers.utils.parseEther("0.1")
    );
    await educationStake.deployed();
  });

  it("Should allow a user to start a course", async function () {
    await educationStake.connect(addr1).startCourse(ethers.utils.parseEther("1"), 3600, { value: ethers.utils.parseEther("1") });
    const stake = await educationStake.stakes(addr1.address);
    expect(stake).to.equal(ethers.utils.parseEther("1"));
  });

  it("Should allow a user to finish a course", async function () {
    await educationStake.connect(addr1).startCourse(ethers.utils.parseEther("1"), 3600, { value: ethers.utils.parseEther("1") });
    await educationStake.connect(addr1).finishCourse();
    const completed = await educationStake.completedCourses(addr1.address);
    expect(completed).to.be.true;
  });

  it("Should distribute rewards correctly", async function () {
    await educationStake.connect(addr1).startCourse(ethers.utils.parseEther("1"), 3600, { value: ethers.utils.parseEther("1") });
    await educationStake.connect(addr2).startCourse(ethers.utils.parseEther("1"), 3600, { value: ethers.utils.parseEther("1") });

    await educationStake.connect(addr1).finishCourse();
    await ethers.provider.send("evm_increaseTime", [3600]);
    await ethers.provider.send("evm_mine");

    const initialBalance = await ethers.provider.getBalance(addr1.address);
    await educationStake.distributeRewards();
    const finalBalance = await ethers.provider.getBalance(addr1.address);

    expect(finalBalance).to.be.above(initialBalance);
  });
});