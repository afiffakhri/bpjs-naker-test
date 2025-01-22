const roleService = require('../services/roleService');
const jwt = require('jsonwebtoken');

async function getAllRoles(req, res) {
	try{
		const roles = await roleService.getAllRoles();

		res.json({ success: true, roles: roles });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting roles' });
	}

}

async function getRolesById(req, res) {
	const { id } = req.params;

	try{
		const selectedRole = await roleService.getRoleById(id);

		res.json({ success: true, selectedRole: selectedRole });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting roles' });
	}
}

async function createRole(req, res){
	const params = req.body;

	try{
		const role = await roleService.createRole(params);

		res.json({ success: true, role: role });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting role' });
	}
}

async function updateRole(req, res) {
	try {
		const roleData = req.body;
		const updatedRole = await roleService.updateRole(roleData.id_role, {role: roleData.role});
		res.status(200).json(updatedRole);
	} catch (error) {
		res.status(500).json({ message: error.message });
	}
}

module.exports = { getAllRoles, getRolesById, createRole, updateRole };