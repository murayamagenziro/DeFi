// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./JamToken.sol";
import "./StellartToken.sol";

contract TokenFarm {


    // Declaraciones iniciales
    string public name = "Stellart Token Farm";
    address public owner;

    JamToken public jamToken;
    StellartToken public stellartToken;

    // Estructuras de datos
    address [] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address=> bool) public hasStaked;
    mapping(address => bool) public isStaking;

    // Constructor
    constructor(StellartToken _stellartToken, JamToken _jamToken) {
        stellartToken = _stellartToken;
        jamToken = _jamToken;
        owner = msg.sender;
    }

    // Stake de tokens
    function stakeTokens(uint _amount) public {
        // Se require una cantidad superior a 0
        require(_amount > 0, "La cantidad no puede ser negativa");
        // Transferir tokens JAM al Smart Contract principal
        jamToken.transferFrom(msg.sender, address(this), _amount);
        // Actualizar el saldo del staking
        stakingBalance[msg.sender] += _amount;
        // Guardar el usuario
        if(!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        // Actualizamos el estado del staking
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }
    // Quitar el staking de los tokens
    function unstakeTokens() public {
        // saldo del staking de un usuario
        uint balance = stakingBalance[msg.sender];
        // Se require una cantidad superior a 0
        require(balance > 0, "El balance del staking es 0");
        // Transferencia de los tokens al usurio
        jamToken.transfer(msg.sender, balance);
        // Resetea el balance de staking del usuario
        stakingBalance[msg.sender] = 0;
        // Actualizar el estado del staking
        isStaking[msg.sender] = false;
    }

    // Emisión de Tokens (recompensas)
    function issueTokens() public {
        // Únicamente ejecutable por el owner
        require(msg.sender == owner, "No eres el owner");
        // Emitir tokens a todos los stakers
        for(uint i=0; i <stakers.length; i++){
            address recipient = stakers[i];
            uint balance = stakingBalance[recipient];
            if (balance > 0){
                stellartToken.transfer(recipient, balance)                ;
            }
        }
    }
}