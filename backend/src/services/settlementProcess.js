const settlementProcess = require('../models/settlementProcess');

async function getAllSettlementProcess() {
	return await settlementProcess.findAll();
}

async function getSettlementProcessById(id_settlement_status){
	return await settlementProcess.findOne({ where: { id_settlement_status } });
}

async function getSettlementProcessByDepositoID(id_deposito){
	return await settlementProcess.findAll({ where: { id_deposito }});
}

async function createSettlementProcess(settlementProcessData) {
	try {
		const insert = await settlementProcess.bulkCreate(settlementProcessData,{
			validate: true
		});
		return insert;
	} catch (error) {
		throw new Error('Error creating settlementProcess: ' + error.message);
	}
}

module.exports = { getAllSettlementProcess, getSettlementProcessById, getSettlementProcessByDepositoID, createSettlementProcess };