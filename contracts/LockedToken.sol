pragma solidity >=0.4.24 <=0.5.6;

import "openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";

/**
 * @title LockedToken
 * @dev LockedToken is a token holder contract that will allow a
 * beneficiary to extract the tokens after a given release time.
 */
contract LockedToken {
    using SafeERC20 for IERC20;

    // ERC20 basic token contract being held
    IERC20 private _token;

    // donor of tokens
    address private _donor;

    // beneficiary of tokens after they are released
    address private _beneficiary;

    // timestamp when token release is enabled
    uint256 private _releaseTime;
    bool public _revocable;

    event Claim(address beneficiary, uint256 amount, uint256 releaseTime);
    event Revoke(address donor, uint256 amount);

    constructor (IERC20 token, address donor, address beneficiary, uint256 releaseTime, bool revocable) public {
        // require(address(token) != address(0), "LockedToken: token is zero address");
        require(donor != address(0), "LockedToken: donor is zero address");
        require(beneficiary != address(0), "LockedToken: beneficiary is zero address");
        // solhint-disable-next-line not-rely-on-time
        require(releaseTime > block.timestamp, "LockedToken: release time is before current time");

        _token = IERC20(token);
        _donor = donor;
        _beneficiary = beneficiary;
        _releaseTime = releaseTime;
        _revocable = revocable;
    }

    /**
     * @return the token being held.
     */
    function token() public view returns (IERC20) {
        return _token;
    }

    /**
     * @return the donor of the tokens.
     */
    function donor() public view returns (address) {
        return _donor;
    }

    /**
     * @return the beneficiary of the tokens.
     */
    function beneficiary() public view returns (address) {
        return _beneficiary;
    }

    /**
     * @return the time when the tokens are released.
     */
    function releaseTime() public view returns (uint256) {
        return _releaseTime;
    }

    /**
     * @return if tokens are revocable
     */
    function revocable() public view returns (bool) {
        return _revocable;
    }

    /**
     * @return the balance of the tokens.
     */
    function balanceOf() public view returns (uint256) {
        return _token.balanceOf(address(this));
    }

    /**
     * @notice Transfers tokens to donor.
     */
    function revoke() public {
        require(_revocable, "LockedToken: tokens are not revocable");
        require(msg.sender == _donor, "LockedToken: only donor can revoke");

        uint amount = _token.balanceOf(address(this));
        require(amount > 0, "LockedToken: no tokens to revoke");

        _token.safeTransfer(_donor, amount);
        emit Revoke(_donor, amount);
    }

    /**
     * @notice Transfers tokens held by timelock to beneficiary.
     */
    function claim() public {
        // solhint-disable-next-line not-rely-on-time
        require(block.timestamp >= _releaseTime, "LockedToken: current time is before release time");

        uint amount = _token.balanceOf(address(this));
        require(amount > 0, "LockedToken: no tokens to claim");

        _token.safeTransfer(_beneficiary, amount);
        emit Claim(_beneficiary, amount, _releaseTime);
    }
}
