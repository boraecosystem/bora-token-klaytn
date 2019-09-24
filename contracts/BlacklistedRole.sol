pragma solidity >=0.4.24 <=0.5.6;

import "openzeppelin-solidity/contracts/access/Roles.sol";
import "openzeppelin-solidity/contracts/access/roles/WhitelistAdminRole.sol";

/**
 * @title BlacklistedRole
 * @dev Blacklisted accounts have been approved by a WhitelistAdmin to prevent certain actions.
 */
contract BlacklistedRole is WhitelistAdminRole {
    using Roles for Roles.Role;

    event BlacklistedAdded(address indexed account);
    event BlacklistedRemoved(address indexed account);

    Roles.Role private _blacklisteds;

    modifier notBlacklisted() {
        require(!isBlacklisted(msg.sender), "BlacklistedRole: caller has the Blacklisted role");
        _;
    }

    function isBlacklisted(address account) public view returns (bool) {
        return _blacklisteds.has(account);
    }

    function addBlacklisted(address account) public onlyWhitelistAdmin {
        _addBlacklisted(account);
    }

    function removeBlacklisted(address account) public onlyWhitelistAdmin {
        _removeBlacklisted(account);
    }

    function _addBlacklisted(address account) internal {
        _blacklisteds.add(account);
        emit BlacklistedAdded(account);
    }

    function _removeBlacklisted(address account) internal {
        _blacklisteds.remove(account);
        emit BlacklistedRemoved(account);
    }
}
