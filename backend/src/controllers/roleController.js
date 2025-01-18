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

module.exports = { getAllRoles, getRolesById };