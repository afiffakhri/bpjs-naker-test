import api from './index';

export const getAllDeposito = async () => {
	try {
		const response = await api.get('/depositos');
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};

export const getDepositoById = async(id_deposito) => {
	try {
		const response = await api.get(`/depositos/${id_deposito}`);
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};

export const createDeposito = async (depositoData) => {
	try {
		const response = await api.post('/depositos', depositoData);
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};

export const updateDeposito = async (id_deposito, depositoData) => {
	try {
		const response = await api.patch(`/depositos/${id_deposito}`, depositoData);
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};