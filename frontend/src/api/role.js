import api from './index';

export const getAllRoles = async () => {
	try {
		const response = await api.get('/roles');
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};

export const getRolesById = async(id_role) => {
	try {
		const response = await api.get(`/roles/${id_role}`);
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};