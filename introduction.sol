pragma  solidity^0.8.0;     //define supported solidity version

contract Introduction {
    // logging
    event GetEthHistory(address from, uint256 value) ;


    // priavate, olny access by its contract
    // public, the funcition can be access by external app or contract
    // external, the function can be access only from external app
    // internal, only acces by outside contract or in the contract

    function get() public returns (uint256) {
        // declare of view, the view -> we didn't change any state or variable inside the contract
        // pure -> we didn't read or write any variables in storage
        // payable -> accept incoming payment


        emit GetEthHistory(address(this), address(this).balance);
        // get address balance
        return address(this).balance;

    }

    //  make sure the send function is accessible from outside apps
    function send(address to, uint value) external {

        
        /*call is predifined function to call other function outside the contract, it have two return, success or not
        and the value */
        (bool success, bytes memory data) = to.call{value: value}("");

        require(success == true, "Error occurred when sending ether");
    }

    receive() external payable {}
    fallback() external payable {}
}