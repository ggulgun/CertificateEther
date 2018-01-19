pragma solidity ^0.4.19;
//Solidity Version


contract CertificateFactory {

	//Contract Event
    event NewCertificate(uint certificateId , uint certificateId, string ownerName, uint schoolId);

    uint certificateDigits = 16;
    uint certificateModulus = 10 ** certificateDigits;

	//Struct definition
    struct Certificate {
		uint certificateId
        string owner;
        uint dna;
    }

	//Array Definition
    Certificate[] public certificates;

	//Mappings
    mapping (uint => address) public certificateToOwner;
    mapping (address => uint) ownerCertificateCount;

	//Function declared as private
    function _createCertificate(uint _certificateId, string _ownerName, uint _schoolId) private {
        uint id = certificates.push(Zombie(_certificateId, _ownerName,_schoolId)) - 1;
        certificateToOwner[id] = msg.sender;
        ownerCertificateCount[msg.sender]++;
        NewCertificate(id,_certificateId,_ownerName, _schoolId);
    }

	//Keccak function usage
    function _generateRandomCertificate(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % certificateModulus;
    }

	//Public function definition
    function createRandomCertificate(uint _certificateId,string _ownerName,uint _schoolId) public {
        require(ownerCertificateCount[msg.sender] == 1000);
        uint randCertificate = _generateRandomCertificate(_certificateId);
        _createCertificate(randCertificate, _ownerName, _schoolId);
    }

}
