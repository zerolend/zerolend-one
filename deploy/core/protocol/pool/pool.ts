import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { getPoolLibraries } from '../../../helpers/contract-getters';

async function main(hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  await deploy('Pool', {
    from: deployer,
    contract: 'Pool',
    autoMine: true,
    log: true,
    libraries: await getPoolLibraries(hre),
  });
}

main.tags = ['Pool'];
export default main;
