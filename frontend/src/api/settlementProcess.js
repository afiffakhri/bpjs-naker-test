import api from './index';

export const getAllSettlementProcess = async () => {
	try {
		const response = await api.get('/settlement-process');
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};

export const getSettlementProcessById = async(id_settlement_process) => {
	try {
		const response = await api.get(`/settlement-process/${id_settlement_process}`);
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};

export const getSettlementProcessByDepositoID = async(id_deposito) => {
	try {
		const response = await api.get(`/settlement-process/${id_deposito}`);
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};

export const getSettlementProcessByParams = async(params) => {
	try {
		const response = await api.post('/settlement-process-query', params);
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};

export const updateSettlementProcess = async (updatedData) => {
	try {
		const response = await api.patch('/settlement-process', updatedData);
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};