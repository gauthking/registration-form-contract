pragma solidity ^0.8.4;

contract myForm {
    struct formdetails {
        string name;
        uint256 age;
        string dept;
        string year;
        uint256 timeOfRegis;
    }

    formdetails[] formList;

    mapping(address => bool) private isRegistered;

    modifier registerVerification(address _add, uint256 _age) {
        require(
            !isRegistered[_add],
            "You have a already registered with this wallet, please try another with another account"
        );
        require(
            _age > 18,
            "Should be older than 18 inorder to register for this course"
        );
        _;
    }

    function registerMember(
        string calldata _name,
        uint256 _age,
        string calldata _dept,
        string calldata _year
    ) public registerVerification(msg.sender, _age) {
        isRegistered[msg.sender] = true;
        formList.push(formdetails(_name, _age, _dept, _year, block.timestamp));
    }

    function callMember(string memory _name)
        public
        view
        returns (formdetails memory s)
    {
        for (uint256 i = 0; i < formList.length; i++) {
            if (
                keccak256(abi.encodePacked(formList[i].name)) ==
                keccak256(abi.encodePacked(_name))
            ) {
                return formList[i];
            }
        }
    }
}
