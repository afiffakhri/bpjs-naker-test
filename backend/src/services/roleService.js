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

async function createRole(roleData) {
	try {
		const role = await Role.create(roleData);
		return role;
	} catch (error) {
		throw new Error('Error creating role: ' + error.message);
	}
}

async function updateRole(id_role, roleData) {
	try {
		const role = await Role.findOne({ where: { id_role } });

		if (!role) {
			throw new Error('role not found');
		}

		await role.update(roleData);

		return role;
	} catch (error) {
		throw new Error('Error updating role: ' + error.message);
	}
}

module.exports = { getAllRoles, getRoleById, createRole, updateRole };