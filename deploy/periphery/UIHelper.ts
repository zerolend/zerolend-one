import { HardhatRuntimeEnvironment } from 'hardhat/types';

async function main(hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  const factory = await deployments.get('PoolFactory');
  const manager = await deployments.get('PoolConfigurator');

  const args = [factory.address, manager.address];

  const deployment = await deploy('UIHelper', {
    from: deployer,
    contract: 'UIHelper',
    args,
    autoMine: true,
    log: true,
    waitConfirmations: 2,
  });

  await hre.run('verify:verify', {
    address: deployment.address,
    constructorArguments: args,
  });
}

main.tags = ['UIHelper'];
export default main;
