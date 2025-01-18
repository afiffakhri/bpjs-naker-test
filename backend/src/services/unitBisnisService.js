const UnitBisnis = require('../models/unitBisnis');

async function getAllUnitBisnis() {
	return await UnitBisnis.findAll();
}

async function getUnitBisnisById(id_unit_bisnis){
	return await UnitBisnis.findOne({ where: { id_unit_bisnis } });
}

module.exports = { getAllUnitBisnis, getUnitBisnisById };