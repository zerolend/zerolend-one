import { Provider } from '@ethersproject/providers';
import { ethers, keccak256 } from 'ethers';

export const buildBytecode = (
  constructorTypes: any[],
  constructorArgs: any[],
  contractBytecode: string
) => `${contractBytecode}${encodeParams(constructorTypes, constructorArgs).slice(2)}`;

export const buildCreate2Address = (factoryAddress: string, saltHex: string, byteCode: string) => {
  return `0x${keccak256(
    `0x${['ff', factoryAddress, saltHex, keccak256(byteCode)]
      .map((x) => x.replace(/0x/, ''))
      .join('')}`
  ).slice(-40)}`.toLowerCase();
};

export const numberToUint256 = (value: number) => {
  const hex = value.toString(16);
  return `0x${'0'.repeat(64 - hex.length)}${hex}`;
};

export const saltToHex = (salt: string | number) => ethers.id(salt.toString());

export const encodeParam = (dataType: any, data: any) => {
  const abiCoder = new ethers.AbiCoder();
  return abiCoder.encode([dataType], [data]);
};

export const encodeParams = (dataTypes: any[], data: any[]) => {
  const abiCoder = new ethers.AbiCoder();
  return abiCoder.encode(dataTypes, data);
};

export const isContract = async (address: string, provider: Provider) => {
  const code = await provider.getCode(address);
  return code.slice(2).length > 0;
};

export function getCreate2Address({
  factoryAddress,
  salt,
  contractBytecode,
  constructorTypes = [] as string[],
  constructorArgs = [] as any[],
}: {
  salt: string | number;
  factoryAddress: string;
  contractBytecode: string;
  constructorTypes?: string[];
  constructorArgs?: any[];
}) {
  return buildCreate2Address(
    factoryAddress,
    saltToHex(salt),
    buildBytecode(constructorTypes, constructorArgs, contractBytecode)
  );
}
