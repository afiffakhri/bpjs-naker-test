const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const User = sequelize.define('User', {
	id_user: {
		type: DataTypes.INTEGER,
		allowNull: false,
		primaryKey: true,
		autoIncrement: true,
		field: 'id_user',
	},
	id_role: {
		type: DataTypes.SMALLINT,
		allowNull: false,
	},
	id_unit_bisnis: {
		type: DataTypes.SMALLINT,
		allowNull: true,
	},
	name: {
		type: DataTypes.STRING,
		allowNull: false,
	},
	email: {
		type: DataTypes.STRING,
		allowNull: false,
	},
	password: {
		type: DataTypes.STRING,
		allowNull: false,
	},
	created_at: {
		type: DataTypes.DATE(6),
		allowNull: true,
    },
    created_by: {
    	type: DataTypes.SMALLINT,
    	allowNull: true,
    },
    updated_at: {
    	type: DataTypes.DATE(6),
    	allowNull: true,
    },
    updated_by: {
    	type: DataTypes.SMALLINT,
    	allowNull: true,
    },
}, 
{
  tableName: 'user',
  timestamps: false,
});

module.exports = User;
