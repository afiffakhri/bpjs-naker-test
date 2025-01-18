const bankService = require('../services/bankService');
const jwt = require('jsonwebtoken');

async function getAllBank(req, res) {
	try{
		const banks = await bankService.getAllBank();

		res.json({ success: true, banks: banks });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting banks' });
	}

}

async function getBankById(req, res) {
	const { id } = req.params;

	try{
		const selectedBank = await bankService.getBankById(id);

		res.json({ success: true, selectedBank: selectedBank });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting bank' });
	}
}

module.exports = { getAllBank, getBankById };