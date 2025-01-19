const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const DepositoRate = sequelize.define('DepositoRate', {
	id_deposito_rate: {
		type: DataTypes.INTEGER,
		allowNull: false,
		primaryKey: true,
		autoIncrement: true,
		field: 'id_deposito_rate',
	},
	id_bank:{
		type: DataTypes.SMALLINT,
		allowNull: false,
	},
	tenor: {
		type: DataTypes.STRING,
		allowNull: false,
	},
	rate:{
		type: DataTypes.DECIMAL(5, 4),
		allowNull: false,
	}
},
{
	tableName: 'deposito_rate',
	timestamps: false,
});

module.exports = DepositoRate;