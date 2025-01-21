import api from './index';

export const getAllUsers = async () => {
	try {
		const response = await api.get('/users');
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};

export const getUserById = async(id_user) => {
	try {
		const response = await api.get(`/users/${id_user}`);
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};

export const getUserByParams = async(id_unit_bisnis, id_role) => {
	try {
		const response = await api.post('/users-query',{
			id_unit_bisnis,
			id_role
		});
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};