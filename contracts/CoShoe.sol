pragma solidity >=0.5.0;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";

//Non-fungible token
contract CoShoe is ERC271 {

    struct Shoe {
        address payable owner;
        string name;
        string image;
        bool sold;
    }

    //need to convert to wei, can use uint64 to store the wei value, can not use smaller uint type
    uint64 price = (1 ether)/2;

    //var defined as shoesSold in c but later referred to as soldShoes? Assume first is correct
    uint8 shoesSold = 0;

    address public minter;
    mapping(address => uint256) public balances;

    Shoe[] public Shoes;

    constructor() public {
        minter = msg.sender;
    }

    function mint(address receiver) public {
        require(msg.sender == minter, "Function can only be called by minter.");
        balances[receiver] += 100;
        for (i = 1; i < 100; i++) {
            Shoes.push(Shoe(minter, "", "", false));
        }
    }

    function buyShoe(string name, string image) external payable {
        //require(Shoes[]);
        require(msg.value == price, "Price does not match");
        Shoes(msg.sender, name, image, true);

        shoesSold++;
    }

    // function checkPurchases() public view returns (bool[]) {
    //     bool[] purchases;
    //     for (i = 0; i <= Shoes.length; i++) {
            
    //         if (Shoes[i] ==)
    //     }
    // }

}
