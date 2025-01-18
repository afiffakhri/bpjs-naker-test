const Bank = require('../models/Bank');

async function getAllBank() {
	return await Bank.findAll();
}

async function getBankById(id_bank){
	return await Bank.findOne({ where: { id_bank } });
}

module.exports = { getAllBank, getBankById };