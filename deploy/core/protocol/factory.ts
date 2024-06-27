import { ZeroAddress } from "ethers";
import { HardhatRuntimeEnvironment } from "hardhat/types";

async function main(hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  const deployment = await deploy("Factory", {
    from: deployer,
    contract: "Factory",
    args: [ZeroAddress],
    autoMine: true,
    log: true,
  });

  await hre.run("verify:verify", { address: deployment.address });
}

main.tags = ["Factory"];
export default main;
