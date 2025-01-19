const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const SettlementProcess = sequelize.define('SettlementProcess', {
	id_settlement_process: {
		type: DataTypes.INTEGER,
		allowNull: false,
		primaryKey: true,
		autoIncrement: true,
		field: 'id_settlement_process',
	},
	id_deposito: {
		type: DataTypes.INTEGER,
		allowNull: false,
	},
	id_unit_bisnis: {
		type: DataTypes.INTEGER,
		allowNull: false,
	},
	id_role: {
		type: DataTypes.INTEGER,
		allowNull: true,
	},
	id_user: {
		type: DataTypes.INTEGER,
		allowNull: true,
	},
	priority: {
		type: DataTypes.INTEGER,
		allowNull: false,
	},
	status: {
		type: DataTypes.INTEGER,
		allowNull: false,
	},
	remarks: {
		type: DataTypes.STRING,
		allowNull: true,
	},
	updated_at: {
		type: DataTypes.DATE(6),
		allowNull: true,
	},
	updated_by: {
		type: DataTypes.INTEGER,
		allowNull: true,
	},
},
{
	tableName: 'settlement_process',
	timestamps: false,
});

module.exports = SettlementProcess;