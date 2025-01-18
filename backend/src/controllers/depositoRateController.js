const depositoRateService = require('../services/depositoRateService');
const jwt = require('jsonwebtoken');

async function getAllDepositoRate(req, res) {
	try{
		const deposito_rates = await depositoRateService.getAllDepositoRate();

		res.json({ success: true, deposito_rates: deposito_rates });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting deposito_rates' });
	}

}

async function getDepositoRateById(req, res) {
	const { id } = req.params;

	try{
		const deposito_rate = await depositoRateService.getDepositoRateById(id);

		res.json({ success: true, deposito_rate: deposito_rate });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting deposito_rate' });
	}
}

async function getDepositoRateByBankId(req, res) {
	const { id } = req.params;

	try{
		const deposito_rates = await depositoRateService.getDepositoRateByBankId(id);

		res.json({ success: true, deposito_rates: deposito_rates });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting deposito_rates' });
	}
}

module.exports = { getAllDepositoRate, getDepositoRateById, getDepositoRateByBankId };