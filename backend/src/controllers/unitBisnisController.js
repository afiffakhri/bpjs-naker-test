const unitBisnisService = require('../services/unitBisnisService');
const jwt = require('jsonwebtoken');

async function getAllUnitBisnis(req, res) {
	try{
		const unit_bisnis = await unitBisnisService.getAllUnitBisnis();

		res.json({ success: true, unit_bisnis: unit_bisnis });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting unit_bisnis' });
	}

}

async function getUnitBisnisById(req, res) {
	const { id } = req.params;

	try{
		const unit_bisnis = await unitBisnisService.getUnitBisnisById(id);

		res.json({ success: true, unit_bisnis: unit_bisnis });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting unit_bisnis' });
	}
}

module.exports = { getAllUnitBisnis, getUnitBisnisById };