This folder contains the verification of the ZeroLend One protocol using CVL, Certora's Verification Language.

We first give a high-level description of the verification and then describe the folder and file structure of the specification files.

# High-level description

The ZeroLend protocol allows users to take out over-collateralized loans for ERC20 tokens. Unlike single asset isolated pools, users can take out multiple loans for an individual asset.

## ERC20 tokens and transfers
