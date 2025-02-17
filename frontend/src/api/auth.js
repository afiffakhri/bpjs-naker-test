import api from './index';

export const login = async (email, password) => {
	try {
		const response = await api.post('/auth/login', {
			email,
			password,
		});
		return response.data;
	} catch (error) {
		throw error.response?.data || error;
	}
};