import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async function ({
  getNamedAccounts,
  deployments,
  ...hre
}: HardhatRuntimeEnvironment) {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  await deploy("SupplyLogic", {
    from: deployer,
    args: [],
    log: true,
    deterministicDeployment: false
  });

  const borrowLogicArtifact = await deploy("BorrowLogic", {
    from: deployer,
    args: [],
    log: true,
    deterministicDeployment: false
  });

  await deploy("LiquidationLogic", {
    from: deployer,
    log: true,
    deterministicDeployment: false
  });

  await deploy("FlashLoanLogic", {
    from: deployer,
    log: true,
    deterministicDeployment: false,
    libraries: {
      BorrowLogic: borrowLogicArtifact.address,
    },
  });

  await deploy("PoolLogic", {
    from: deployer,
    log: true,
    deterministicDeployment: false
  });

  return true;
};

func.id = "LogicLibraries";
func.tags = ["LogicLibraries", "core", "logic"];

export default func;
