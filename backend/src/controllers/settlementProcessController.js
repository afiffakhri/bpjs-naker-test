const settlementProcess = require('../services/settlementProcess');
const jwt = require('jsonwebtoken');

async function getAllSettlementProcess(req, res) {
	try{
		const settlement_process = await settlementProcess.getAllSettlementProcess();

		res.json({ success: true, settlement_process: settlement_process });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting settlement_process' });
	}

}

async function getSettlementProcessById(req, res) {
	const { id } = req.params;

	try{
		const settlement_process = await settlementProcess.getSettlementProcessById(id);
		res.json({ success: true, settlement_process: settlement_process });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting settlement_process' });
	}
}

async function getSettlementProcessByDepositoID(req, res) {
	const { id } = req.params;

	try{
		const settlement_process = await settlementProcess.getSettlementProcessByDepositoID(id);

		res.json({ success: true, settlement_process: settlement_process });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting settlement_process' });
	}
}

module.exports = { getAllSettlementProcess, getSettlementProcessById, getSettlementProcessByDepositoID };