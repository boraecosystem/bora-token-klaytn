pragma solidity >=0.4.24 <=0.5.6;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Capped.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Pausable.sol";
import "./BlacklistedRole.sol";
import "./LockedToken.sol";

contract BoraToken is ERC20, ERC20Detailed, ERC20Capped, ERC20Burnable, ERC20Pausable, BlacklistedRole {

    event Lock(address token, address beneficiary, uint256 amount, uint256 releaseTime);
    event Burn(address to, uint256 amount, uint256 totalSupply);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor(uint256 initialSupply) ERC20Detailed("BORA", "BORA", 18) ERC20Capped(initialSupply) public {
        _mint(msg.sender, initialSupply);
    }

    /**
     * @dev modified with blacklisted role.
     *
     * Requirements:
     *
     * - the caller must not have Blacklisted role.
     */
    function transfer(address to, uint256 value) public notBlacklisted returns (bool) {
        return super.transfer(to, value);
    }

    /**
     * @dev modified with blacklisted role.
     *
     * Requirements:
     *
     * - the caller must not have Blacklisted role.
     * - `sender` must not have Blacklisted role.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public notBlacklisted returns (bool) {
        require(!isBlacklisted(sender), "BoraToken: sender has the Blacklisted role");
        return super.transferFrom(sender, recipient, amount);
    }

    /**
     * @dev Locks `amount` tokens
     *
     * Emits a `Lock` event.
     *
     * Requirements:
     *
     * - the caller must have the `PauserRole`.
     * - `donor` cannot be the zero address.
     * - `beneficiary` cannot be the zero address.
     */
    function lock(address donor, address beneficiary, uint256 amount, uint256 duration, bool revocable) public onlyPauser returns (LockedToken) {
        // solhint-disable-next-line not-rely-on-time
        uint256 releaseTime = now.add(duration.mul(1 days));
        LockedToken lockedToken = new LockedToken(this, donor, beneficiary, releaseTime, revocable);
        transfer(address(lockedToken), amount);
        emit Lock(address(lockedToken), beneficiary, lockedToken.balanceOf(), releaseTime);
        return lockedToken;
    }

    /**
     * @dev Destroys `amount` tokens from the caller.
     *
     * Emits a `Burn` event.
     */
    function burn(uint256 amount) public onlyMinter {
        ERC20Burnable.burn(amount);
        emit Burn(msg.sender, amount, totalSupply());
    }

    /**
     * @dev Adds ownership (MinterRole, PauserRole, WhitelistAdminRole) to `newOwner`.
     *
     * Emits a `OwnershipTransferred` event.
     *
     * Requirements:
     *
     * - the caller must have the `MinterRole`, `PauserRole` and `WhitelistAdminRole`.
     * - `newOwner` cannot be the zero address.
     */
    function addOwnership(address newOwner) public onlyMinter onlyPauser onlyWhitelistAdmin {
        require(newOwner != address(0), "BoraToken: add ownership to the zero address");
        super.addMinter(newOwner);
        super.addPauser(newOwner);
        super.addWhitelistAdmin(newOwner);
        emit OwnershipTransferred(msg.sender, newOwner);
    }

    /**
     * @dev Renounces ownership (MinterRole, PauserRole, WhitelistAdminRole) from the caller.
     *
     * Emits a `OwnershipTransferred` event with `newOwner` set to the zero address.
     *
     * Requirements:
     *
     * - the caller must have the `MinterRole`, `PauserRole` and `WhitelistAdminRole`.
     */
    function renounceOwnership() public onlyMinter onlyPauser onlyWhitelistAdmin {
        super.renounceMinter();
        super.renouncePauser();
        super.renounceWhitelistAdmin();
        emit OwnershipTransferred(msg.sender, address(0));
    }
}
