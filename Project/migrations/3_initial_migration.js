const c = artifacts.require("ClaimsRegistry");

module.exports = function(deployer) {
  deployer.deploy(c);
};
