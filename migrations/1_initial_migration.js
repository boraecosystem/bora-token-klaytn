const Migrations = artifacts.require("Migrations");
const BoraToken = artifacts.require("BoraToken");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(BoraToken, '1325000000000000000000000000');
};
