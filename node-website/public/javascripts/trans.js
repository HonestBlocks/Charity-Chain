import Web3 from 'web3';


var Web3=require('web3');
var quorumjs=require('quorum-js');
var web3=new Web3(new Web3.providers.HttpProvider('http://10.50.0.3:22000'));
web3.eth.personal.unlockAccount("0x48Ea3c7C7EA659a0c46F8b88207B9d7A56361491",'', 22003);
web3.eth.sendTransaction({from: "0x48Ea3c7C7EA659a0c46F8b88207B9d7A56361491" ,to: "0xfd943eABe7F9b6226e618Dcfa68bef244Cc635C8", value: x});


