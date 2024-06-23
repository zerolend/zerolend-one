// import
import { ethers } from 'ethers';
import { getCreate2Address } from './create2';

// declare deployment parameters
import contractArtifact from '../artifacts/contracts/core/protocol/factory/Factory.sol/Factory.json';
const constructorTypes = ['address'];
const constructorArgs = ['0x6aac0942b8147bffab73789a82ee12fda7735bac'];
const factoryAddress = '0x6aac0942b8147bffab73789a82ee12fda7735bac';

const job = () => {
  let i = 0;

  while (true) {
    const salt = ethers.id('' + i);
    // Calculate contract address
    const computedAddress = getCreate2Address({
      salt: salt,

      factoryAddress,
      contractBytecode: contractArtifact.bytecode,
      constructorTypes: constructorTypes,
      constructorArgs: constructorArgs,
    });

    if (computedAddress.startsWith('0x000000')) {
      console.log('found the right salt hash');
      console.log('salt', salt);
      break;
    }

    if (i % 100000 == 0) console.log(i, 'salt', salt);
    i++;
  }
};

job();
