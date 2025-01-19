const depositoService = require('../services/depositoService');
const jwt = require('jsonwebtoken');

async function getAllDeposito(req, res) {
	try{
		const depositos = await depositoService.getAllDeposito();

		res.json({ success: true, depositos: depositos });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting depositos' });
	}

}

async function getDepositoById(req, res) {
	const { id } = req.params;

	try{
		const deposito = await depositoService.getDepositoById(id);
		res.json({ success: true, deposito: deposito });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting roles' });
	}
}

async function create(req, res) {
	try {
		let depositoData = req.body;

		const currentDate = new Date();
		const c_year = currentDate.getFullYear();
	    const c_month = String(currentDate.getMonth() + 1).padStart(2, '0');
	    const c_day = String(currentDate.getDate()).padStart(2, '0');
	    const c_hours = String(currentDate.getHours()).padStart(2, '0');
	    const c_minutes = String(currentDate.getMinutes()).padStart(2, '0');
	    const c_seconds = String(currentDate.getSeconds()).padStart(2, '0');
		const tanggalPenempatan = `${c_year}-${c_month}-${c_day} ${c_hours}:${c_minutes}:${c_seconds}`;
		

		const jatuhTempoDate = new Date(tanggalPenempatan);
	    jatuhTempoDate.setMonth(jatuhTempoDate.getMonth() + depositoData.months);
	    const year = jatuhTempoDate.getFullYear();
	    const month = String(jatuhTempoDate.getMonth() + 1).padStart(2, '0');
	    const day = String(jatuhTempoDate.getDate()).padStart(2, '0');
	    const hours = String(jatuhTempoDate.getHours()).padStart(2, '0');
	    const minutes = String(jatuhTempoDate.getMinutes()).padStart(2, '0');
	    const seconds = String(jatuhTempoDate.getSeconds()).padStart(2, '0');
	    const tanggalJatuhTempo = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;

	    depositoData = {
	    	...depositoData,
	    	tanggal_penempatan: tanggalPenempatan,
	    	tanggal_jatuh_tempo: tanggalJatuhTempo,
	    	settlement_status: 0,
	    };

		const newDeposito = await depositoService.createDeposito(depositoData);
		res.status(201).json(newDeposito);
	} catch (error) {
		res.status(500).json({ message: error.message });
	}
}

async function update(req, res) {
	try {
		const { id_deposito } = req.params;
		const depositoData = req.body;
		const updatedDeposito = await depositoService.updateDeposito(id_deposito, depositoData);
		res.status(200).json(updatedDeposito);
	} catch (error) {
		res.status(500).json({ message: error.message });
	}
}

module.exports = { getAllDeposito, getDepositoById, create, update };