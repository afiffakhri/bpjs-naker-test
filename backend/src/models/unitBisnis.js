const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const UnitBisnis = sequelize.define('UnitBisnis', {
	id_unit_bisnis: {
		type: DataTypes.INTEGER,
		allowNull: false,
		primaryKey: true,
		field: 'id_unit_bisnis',
	},
	unit_bisnis: {
		type: DataTypes.STRING,
		allowNull: false,
	}
},
{
	tableName: 'unit_bisnis',
	timestamps: false,
});

module.exports = UnitBisnis;