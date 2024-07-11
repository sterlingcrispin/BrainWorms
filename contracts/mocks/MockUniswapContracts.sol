// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MockWETH9 {
    string public name = "Wrapped Ether";
    string public symbol = "WETH";
    uint8 public decimals = 18;
}

contract MockUniswapV2Factory {
    address public factoryAddress;
    address public WETHAddress;

    constructor(address _WETHAddress) {
        factoryAddress = address(this);
        WETHAddress = _WETHAddress;
    }

    function factory() external view returns (address) {
        return factoryAddress;
    }
}

contract MockUniswapV2Router {
    address public factory;
    address public WETH;

    constructor(address _factory, address _WETH) {
        factory = _factory;
        WETH = _WETH;
    }
}
