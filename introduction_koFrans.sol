pragma solidity ^0.6.4;

contract ecomerce{
    // struct
    struct  Product {
    uint id;
    string name;
    uint price;
    address payable seller;
    bool purchased;
}

    //state variable
    address public owner; //contract owner
    uint public productCount = 0; //count of products
    mapping(uint => Product) public products; //store products data

    // event (LOG)
    event ProductCreated(
        uint id,
        string name,
        uint price,
        address payable seller,
        bool purchased
    );

    //  event (BUY OR SELL)
    event ProductPurchased(
        uint id,
        string name,
        uint price,
        address payable seller,
        address payable buyer,
        bool purchased
    );

    constructor () public {
        owner = msg.sender; //the contract deployment
    }

    function CreateProduct(string memory _name, uint _price) public {
        require(bytes(_name).length > 0, "Product name is required");

        require(_price > 0, "Product prcie must be greater than 0");

        // increment the product count
        productCount++;

        products[productCount]=Product(productCount, _name, _price, msg.sender, false);
        emit ProductCreated(productCount, _name, _price, msg.sender, false);
    }

    // function for purchase product
    function PurchasedProduct(uint _id) public payable {

        // fetch the product
        Product memory _product = products[_id];

        // ensure the product exists
        require(_product.id > 0 && _product.id <= productCount, "Product not found");

        //ensure the product not been purchased yet
        require(_product.purchased, "Prouduct has already been purchased");

        // ensure the buyer send enough Ether to cover the price
        require(msg.value >= _product.price, "Not enough Ether sent");

        require(_product.seller !=  msg.sender, "Seller cannot buy thier own product");

        // transfer ownership to buyer
        _product.seller.transfer(msg.value); //transfer ether to seller
        _product.purchased = true; //mark as purchased
        products[_id] = _product;

        //Emit the product purchase event
        emit ProductPurchased(_id, _product.name, _product.price, _product.seller, payable (msg.sender), false);
    }

}

