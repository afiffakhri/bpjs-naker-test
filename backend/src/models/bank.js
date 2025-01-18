const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Bank = sequelize.define('Bank', {
	id_bank: {
		type: DataTypes.INTEGER,
		allowNull: false,
		primaryKey: true,
		field: 'id_bank',
	},
	bank_name: {
		type: DataTypes.STRING,
		allowNull: false,
	}
},
{
	tableName: 'bank',
	timestamps: false,
});

module.exports = Bank;