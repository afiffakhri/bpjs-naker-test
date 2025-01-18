const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Role = sequelize.define('Role', {
	id_role: {
		type: DataTypes.INTEGER,
		allowNull: false,
		primaryKey: true,
		field: 'id_role',
	},
	role: {
		type: DataTypes.STRING,
		allowNull: false,
	}
},
{
	tableName: 'role',
	timestamps: false,
});

module.exports = Role;