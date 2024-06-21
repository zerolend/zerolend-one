## Feature List

Here we document the final list of features we want to showcase in the protocol

- **Multiple pools & assets** - Permission-less listing of assets and pools through a simple UI
- **Chain abstraction -** Abstraction of the interaction of the chain so that we can give support to EVM and non-EVM chains such as Solana, TON, Sui etc…
- **Smart Accounts -** Allow users to make smart accounts that allow multiple transactions to be made through one account. This allow features like gas-less tx’s, touch-id based tx’s etc etc.. Ideally to make the flow seamless, we should batch the creation of the smart-account and the tx execution in one tx itself.
- **Instant Liquidations** - Powered by Pyth Express Relay.
- **NFT Positions** - Allow users to have multiple positions per wallet; and allow positions to be moved easily.
- **Automated Risk Manager -** As detailed over here: [ZL - Automated Risk Manager](https://www.notion.so/ZL-Automated-Risk-Manager-77301ade66a7441fb8bbbd0deef2f89e?pvs=21) this allows risk management to be automated and done at scale
- **Cross-chain Vaults** - This allows users to deposit into vaults that distribute liquidity across multiple chains. Users can deposit liquidity onto the ETH chain and the risk manager or curator can bridge the liquidity into another chain. Since most of liquidity is on the ETH chain, this allows users to get exposure to yield from other L2 chains while at the same time giving L2 curators the liquidity of ETH.

Steps for Certora

```
virtualenv venv
pip3 install solc-select certora-cli
solc-select install 0.8.19
solc-select use 0.8.19

# add certora key here
export CERTORAKEY=
certoraRun contracts/mocks/tokens/MintableERC20.sol --verify MintableERC20:test/certora/ERC20.spec --solc solc
```
