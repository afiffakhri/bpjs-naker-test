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

export const createRole = async (roleData) => {
	try {
		const response = await api.post('/roles', roleData);
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};

export const updateRole = async (roleData) => {
	try {
		const response = await api.patch(`/roles-update`, roleData);
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};