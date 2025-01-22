const settlementProcess = require('../services/settlementProcess');
const depositoService = require('../services/depositoService');
const jwt = require('jsonwebtoken');

async function getAllSettlementProcess(req, res) {
	try{
		const settlement_process = await settlementProcess.getAllSettlementProcess();

		res.json({ success: true, settlement_process: settlement_process });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting settlement_process' });
	}

}

async function getSettlementProcessById(req, res) {
	const { id } = req.params;

	try{
		const settlement_process = await settlementProcess.getSettlementProcessById(id);
		res.json({ success: true, settlement_process: settlement_process });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting settlement_process' });
	}
}

async function getSettlementProcessByDepositoID(req, res) {
	const { id } = req.params;

	try{
		const settlement_process = await settlementProcess.getSettlementProcessByDepositoID(id);

		res.json({ success: true, settlement_process: settlement_process });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting settlement_process' });
	}
}

async function getSettlementProcessByParams(req, res){
	const params = req.body;

	try{
		const settlement_process = await settlementProcess.getSettlementProcessByParams(params);

		res.json({ success: true, settlement_process: settlement_process });
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting settlement_process' });
	}
}

async function updateSettlementProcess(req, res) {
	try{
		let updateData = req.body;

		const currentDate = new Date();
		const c_year = currentDate.getFullYear();
	    const c_month = String(currentDate.getMonth() + 1).padStart(2, '0');
	    const c_day = String(currentDate.getDate()).padStart(2, '0');
	    const c_hours = String(currentDate.getHours()).padStart(2, '0');
	    const c_minutes = String(currentDate.getMinutes()).padStart(2, '0');
	    const c_seconds = String(currentDate.getSeconds()).padStart(2, '0');
		const updatedAt = `${c_year}-${c_month}-${c_day} ${c_hours}:${c_minutes}:${c_seconds}`;

		const id_settlement_process = updateData.id_settlement_process;
		const id_deposito = updateData.id_deposito;
		let latestUpdateText = (updateData.status == 1) ? 'Approved By ' : 'Rejected By ';
		latestUpdateText = latestUpdateText + updateData.nama_approver + ' dari ' + updateData.role + ' ' + updateData.unit_bisnis;
		let depositoStatus = 1;

		if (updateData.last_process && updateData.status == 1) {
			depositoStatus = 2;
		}

		if (updateData.status == 2) {
			depositoStatus = 3
		}

		const settlementProcessUpdateData = {
			status: updateData.status,
			remarks: updateData.remarks,
			updated_at: updatedAt,
			updated_by: updateData.updated_by
		}

		const updateSettlement = await settlementProcess.updateSettlementProcess(id_settlement_process, settlementProcessUpdateData);

		// console.log(updateSettlement);
		// if (!updateSettlement.success) {
		// 	throw new Error('Settlement Process update failed');
		// }
		console.log('Settlement Process update successful!');

		const depositoUpdateData = {
			settlement_status: depositoStatus,
			latest_update: updatedAt,
			latest_update_text: latestUpdateText,
			updated_at: updatedAt,
			updated_by: updateData.updated_by
		}

		console.log(depositoUpdateData);

		const updateDeposito = await depositoService.updateDeposito(id_deposito, depositoUpdateData);
		// if (!updateSettlement.success) {
		// 	throw new Error('Deposito update failed');
		// }

		const returnData = {
			updateData,
			updateSettlement,
			updateDeposito,
		};
		
		res.status(201).json(returnData);
	} catch (error) {
		console.log(error);
		res.status(500).json({ message: 'Error getting settlement_process' });
	}
}

module.exports = { getAllSettlementProcess, getSettlementProcessById, getSettlementProcessByDepositoID, getSettlementProcessByParams, updateSettlementProcess };