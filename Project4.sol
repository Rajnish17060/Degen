// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DegenToken is ERC20 {
    
    struct item{
        uint id;
        string name;
        uint price;
        uint supply;
    }

    item [100000] public collections;
    item [100000] public DegenStore;

    constructor() ERC20("Degen", "DGN") {
        DegenStore[0] = item(1, "Dragon Armor", 1000, 1);
        DegenStore[1] = item(2, "Phoenix Wings", 800, 500);
        DegenStore[2] = item(3, "Shadow Cloak", 900, 250);
        DegenStore[3] = item(4, "Emerald Coin", 100, 1000);
        DegenStore[4] = item(5, "Diamond Coin", 100, 1000);
    }

    string public degenstore = "1. Dragon Armor, 2. Phoenix Wings, 3. Shadow Cloak, 4. Emerald Coin, 5. Diamond Coin";

    function mint(uint amount) external {
        _mint(msg.sender, amount);
    }

    function burn(uint amount) external {
        require(balanceOf(msg.sender) >= amount, "You don't have enough DEGEN Tokens");
        _burn(msg.sender, amount);
    }

    function balance() external view returns(uint){
        return balanceOf(msg.sender);
    }

    function sendToken(address recipient, uint amount) external {
        require(balanceOf(msg.sender) >= amount, "you don't have enough tokens");
        transfer(recipient, amount);
    }

    function redeemItem(uint256 id) public payable {
        require(DegenStore[id - 1].supply > 0, "Item not available");
        require(balanceOf(msg.sender) >= DegenStore[id - 1].price, "You don't have enough DGT");

        DegenStore[id - 1].supply -= 1;
        _burn(msg.sender, DegenStore[id - 1].price);
        collections[id - 1] = item(id, DegenStore[id - 1].name, DegenStore[id - 1].price, collections[id - 1].supply + 1);
    }
}
