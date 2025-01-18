const User = require('../models/user');

async function login(email, password) {
	return await User.findOne({ where: { email, password } });
}

async function findByEmail(email){
	return await User.findOne({ where: { email } });
}

module.exports = { login, findByEmail };