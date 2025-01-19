import api from './index';

export const getAllUnitBisnis = async () => {
	try {
		const response = await api.get('/unit-bisnis');
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};

export const getUnitBisnisById = async(id_unit_bisnis) => {
	try {
		const response = await api.get('/unit-bisnis/${id_unit_bisnis}');
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};