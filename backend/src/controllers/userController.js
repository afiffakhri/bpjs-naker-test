const userService = require('../services/userService');
const jwt = require('jsonwebtoken');

async function getAllUsers(req, res) {
	try{
		const users = await userService.getAllUsers();

		res.json({ success: true, users: users });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting users' });
	}

}

async function getUserById(req, res) {
	const { id } = req.params;

	try{
		const selectedUser = await userService.getUserById(id);

		res.json({ success: true, selectedUser: selectedUser });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting roles' });
	}
}

async function getUserByParams(req, res){
	const params = req.body;

	try{
		const users = await userService.getUserByParams(params);

		res.json({ success: true, users: users });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting users' });
	}
}

module.exports = { getAllUsers, getUserById, getUserByParams };