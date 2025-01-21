const Role = require('../models/role');
const { Op } = require('sequelize');

async function getAllRoles() {
	return await Role.findAll({
		where: {
			id_role: {
				[Op.ne]: 1
			}
		}
	});
}

async function getRoleById(id_role){
	return await Role.findOne({ where: { id_role } });
}

module.exports = { getAllRoles, getRoleById };