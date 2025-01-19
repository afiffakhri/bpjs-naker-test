import api from './index';

export const getAllDepositoRate = async () => {
	try {
		const response = await api.get('/deposito-rates');
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};

export const getDepositoRateById = async(id_deposito_rate) => {
	try {
		const response = await api.get(`/deposito-rates/${id_deposito_rate}`);
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};

export const getDepositoRateByBankId = async(id_bank) => {
	try {
		const response = await api.get(`/deposito-rates-bank/${id_bank}`);
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};