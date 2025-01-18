const DepositoRate = require('../models/DepositoRate');

async function getAllDepositoRate() {
	return await DepositoRate.findAll();
}

async function getDepositoRateById(id_deposito_rate){
	return await DepositoRate.findOne({ where: { id_deposito_rate } });
}

async function getDepositoRateByBankId(id_bank){
	return await DepositoRate.findAll({ where: { id_bank } });
}

module.exports = { getAllDepositoRate, getDepositoRateById, getDepositoRateByBankId };