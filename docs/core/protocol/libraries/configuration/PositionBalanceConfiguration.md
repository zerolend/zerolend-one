# Solidity API

## PositionBalanceConfiguration

### mintSupply

```solidity
function mintSupply(struct DataTypes.PositionBalance self, struct DataTypes.ReserveSupplies supply, uint256 amount, uint128 index) internal returns (bool isFirst, uint256 supplyMinted)
```

### mintDebt

```solidity
function mintDebt(struct DataTypes.PositionBalance self, struct DataTypes.ReserveSupplies supply, uint256 amount, uint128 index) internal returns (bool isFirst, uint256 supplyMinted)
```

### burnSupply

```solidity
function burnSupply(struct DataTypes.PositionBalance self, struct DataTypes.ReserveSupplies supply, uint256 amount, uint128 index) internal returns (uint256 supplyBurnt)
```

### burnDebt

```solidity
function burnDebt(struct DataTypes.PositionBalance self, struct DataTypes.ReserveSupplies supply, uint256 amount, uint128 index) internal returns (uint256 supplyBurnt)
```

### getSupply

```solidity
function getSupply(struct DataTypes.PositionBalance self, uint256 index) internal view returns (uint256 supply)
```

### getDebt

```solidity
function getDebt(struct DataTypes.PositionBalance self, uint256 index) internal view returns (uint256 debt)
```

