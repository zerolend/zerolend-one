import { ethers } from "ethers";

export function getPositionId(user: string, index: number): string {
  return ethers.keccak256(
    ethers.AbiCoder.defaultAbiCoder().encode(
      ["address", "string", "uint256"],
      [user, "index", index]
    )
  );
}