const Deposito = require('../models/Deposito');
const settlementProcess = require('../models/settlementProcess');

async function getAllDeposito() {
	const datas = await Deposito.findAll();

	const depositos = await Promise.all(datas.map(async (data) => {
		const settlement_process = await settlementProcess.findByPk(data.id_deposito);

		return {
			...data.toJSON(),
			settlement_process: settlement_process ? settlement_process : null
		};
	}));

	return depositos;
}

async function getDepositoById(id_deposito){
	const deposito = Deposito.findOne({ where: { id_deposito } });

	const settlement_process = await settlementProcess.findByPk(data.id_deposito);

	return {
		...data.toJSON(),
		settlement_process: settlementProcess ? settlementProcess : null
	};	
}

async function createDeposito(depositoData) {
	try {
		const deposito = await Deposito.create(depositoData);
		return deposito;
	} catch (error) {
		throw new Error('Error creating deposito: ' + error.message);
	}
}

async function updateDeposito(id_deposito, depositoData) {
	try {
		// Find the Deposito by id_deposito
		const deposito = await Deposito.findOne({ where: { id_deposito } });

		if (!deposito) {
			throw new Error('Deposito not found');
		}

		// Update the Deposito record
		await deposito.update(depositoData);

		// Return the updated deposito object
		return deposito;
	} catch (error) {
		throw new Error('Error updating deposito: ' + error.message);
	}
}

module.exports = { getAllDeposito, getDepositoById, createDeposito, updateDeposito };