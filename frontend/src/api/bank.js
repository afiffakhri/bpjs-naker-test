import api from './index';

export const getAllBank = async () => {
	try {
		const response = await api.get('/banks');
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};

export const getBankById = async(id_bank) => {
	try {
		const response = await api.get(`/banks/${id_bank}`);
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};