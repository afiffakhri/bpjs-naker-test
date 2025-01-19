const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Deposito = sequelize.define('Deposito', {
	id_deposito: {
		type: DataTypes.INTEGER,
		allowNull: false,
		primaryKey: true,
		autoIncrement: true,
		field: 'id_deposito',
	},
	id_deposito_rate: {
		type: DataTypes.SMALLINT,
		allowNull: false,
	},
	deposit_value:{
		type: DataTypes.SMALLINT,
		allowNull: false,
	},
	estimated_interest:{
		type: DataTypes.DECIMAL,
		allowNull: false,
	},
	estimated_value:{
		type: DataTypes.DECIMAL,
		allowNull: false,
	},
	tanggal_penempatan: {
		type: DataTypes.DATE(6),
		allowNull: false,
  },
  tanggal_jatuh_tempo: {
		type: DataTypes.DATE(6),
		allowNull: true,
  },
	settlement_status: {
		type: DataTypes.SMALLINT,
		allowNull: true,
	},
	latest_update: {
		type: DataTypes.DATE(6),
		allowNull: true,
  },
	id_bank: {
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
	phone: {
		type: DataTypes.STRING,
		allowNull: false,
	},
	nama_pemegang_rekening: {
		type: DataTypes.STRING,
		allowNull: false,
	},
	nomor_rekening: {
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
  tableName: 'deposito',
  timestamps: false,
});

module.exports = Deposito;
