pragma solidity >=0.5.0;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";

//Non-fungible token
contract CoShoe is ERC721Full {
    struct Shoe {
        address owner;
        string name;
        string image;
        bool sold;
    }

    //need to convert to wei, can use uint64 to store the wei value, can not use smaller uint type
    uint64 price = (1 ether) / 2;

    //var defined as shoesSold in c. but later referred to as soldShoes? Assume first is correct
    uint8 shoesSold = 0;

    Shoe[] public shoes;

    address public minter;
    mapping(address => uint256) public balances;

    //Mint 100 CoShoe tokens --->>> Out of gas error when trying to mint large amounts
    constructor() public ERC721Full("CoShoe token", "CS") {
        for (uint8 i = 0; i < 20; i++) {
            shoes.push(Shoe(msg.sender, "", "", false));
            _mint(msg.sender, i);
        }
    }


    function buyShoe(string memory name, string memory image) public payable {
        require(shoesSold < uint8(shoes.length), "No more shoes in stock");
        require(msg.value == price, "Amount does not match price");
        shoes[shoesSold].owner = msg.sender;
        shoes[shoesSold].name = name;
        shoes[shoesSold].image = image;
        shoes[shoesSold].sold = true;
        shoesSold++;
    }

    function checkPurchases() public view returns (bool[] memory) {
        bool[] memory purchases;
        for (uint8 i = 0; i <= uint8(shoes.length); i++) {
            if (shoes[i].owner == msg.sender) {
                purchases[i] = true;
            }
        }
        return purchases;
    }

    function numberCoShoe() external view returns (uint8) {
        return uint8(shoes.length);
    }

    function numberShoesSold() external view returns (uint8) {
        return shoesSold;
    }

}
