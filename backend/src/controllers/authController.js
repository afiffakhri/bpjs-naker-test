const authService = require('../services/authService');
const roleService = require('../services/roleService');
const unitBisnisService = require('../services/unitBisnisService');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

async function login(req, res) {
	const { email, password } = req.body;
	try {
		const user = await authService.findByEmail(email);
		if (!user) {
			return res.status(401).json({ success: false, message: 'Invalid email' });
		}

		const isMatch = await bcrypt.compare(password, user.password);
		if (!isMatch) {
			return res.status(401).json({ success: false, message: 'Invalid password' });
		}

		const plainUser = user.get({ plain: true });
		delete plainUser.password;

		let role = null;
		let unit_bisnis = null;

		if (user && user.id_role) {
			role = await roleService.getRoleById(user.id_role);
		}

		if (user && user.id_unit_bisnis) {
			unit_bisnis = await unitBisnisService.getUnitBisnisById(user.id_unit_bisnis);
		}

		plainUser.role = role;
		plainUser.unit_bisnis = unit_bisnis;

		const token = jwt.sign({ userId: plainUser.id_user }, 'secret_key', { expiresIn: '1h' });
		res.json({ success: true, user: plainUser, token: token });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error logging in' });
	}
}

module.exports = { login };