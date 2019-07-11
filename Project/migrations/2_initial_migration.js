const t = artifacts.require("MyFirstToken");

module.exports = function(deployer) {
  deployer.deploy(t);
};
