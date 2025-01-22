const settlementProcess = require('../models/settlementProcess');
const { Sequelize } = require('sequelize');

async function getAllSettlementProcess() {
	return await settlementProcess.findAll();
}

async function getSettlementProcessById(id_settlement_process){
	return await settlementProcess.findOne({ 
		where: { id_settlement_process },
		order: [
			['priority', 'ASC']
		]
	});
}

async function getSettlementProcessByDepositoID(id_deposito){
	return await settlementProcess.findAll({
		where: { id_deposito },
		order: [
			['priority', 'ASC']
		]
	});
}

async function getSettlementProcessByParams(params){
	console.log(params);
	return await settlementProcess.findAll({
		where: { ...params },
		attributes: [
			'id_deposito', 
            [Sequelize.fn('MAX', Sequelize.col('priority')), 'priority']
		],
		group: ['id_deposito'],
		order: [
			['priority', 'ASC']
		]
	});
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

async function updateSettlementProcess(id_settlement_process, settlementProcessData) {
	try {
		const settlement_process = await settlementProcess.findOne({ where: { id_settlement_process } });

		if (!settlement_process) {
			throw new Error('Deposito not found');
		}

		await settlement_process.update(settlementProcessData);
		return settlement_process;
	} catch (error) {
		throw new Error('Error updating deposito: ' + error.message);
	}
	// try {
	// 	return await settlementProcess.findByIdAndUpdate(id_settlement_process, settlementProcessData, { new: true })
	// } catch (error) {
	// 	throw new Error('Error updating settlementProcess id ('+id_settlement_process+'): ' + error.message);
	// }
}

module.exports = { getAllSettlementProcess, getSettlementProcessById, getSettlementProcessByParams, getSettlementProcessByDepositoID, createSettlementProcess, updateSettlementProcess };