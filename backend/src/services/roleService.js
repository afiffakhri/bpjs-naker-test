const Role = require('../models/role');

async function getAllRoles() {
	return await Role.findAll();
}

async function getRoleById(id_role){
	return await Role.findOne({ where: { id_role } });
}

module.exports = { getAllRoles, getRoleById };