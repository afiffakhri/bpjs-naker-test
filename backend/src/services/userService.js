const User = require('../models/user');
const Role = require('../models/role');
const UnitBisnis = require('../models/unitBisnis');

async function getAllUsers() {
	return await User.findAll();
}

async function getUserById(id_user){
	return await User.findOne({ where: { id_user } });
}

async function getUserByParams(params){
	const users = await User.findAll({ where: params });
	// return await User.findAll({ where: params });

	const usersWithDetails = await Promise.all(users.map(async (user) => {
		const role = await Role.findByPk(user.id_role);
		const unitBisnis = await UnitBisnis.findByPk(user.id_unit_bisnis);

		return {
			...user.toJSON(),
			role: role ? role.role : null,
			unit_bisnis: unitBisnis ? unitBisnis.unit_bisnis : null
		};
	}));

	return usersWithDetails;
}

module.exports = { getAllUsers, getUserById, getUserByParams };