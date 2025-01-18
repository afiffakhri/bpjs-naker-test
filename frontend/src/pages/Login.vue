<script setup>
	import { ref } from 'vue';
	import { useRouter } from 'vue-router';
	import { login } from '../api/auth';
	import InputText from 'primevue/inputtext';
	import Button from 'primevue/button';

	const email = ref('');
	const password = ref('');
	const errorMessage = ref(null);

	const router = useRouter();

	const handleLogin = async () => {
		try {
			const response = await login(email.value, password.value);
			if (response.success) {
				localStorage.setItem('token', response.token);
				localStorage.setItem('user', JSON.stringify(response.user));
				// console.log(JSON.stringify(response.user));
				router.push('/dashboard');
				// console.log("Login successful");
			} else {
				errorMessage.value = response.message;
			}
		} catch (error) {
			errorMessage.value = error.message || 'An error occurred during login.';
		}
	};
</script>

<template>
	<div class="flex items-center justify-center min-h-screen bg-gray-100">
		<div class="w-full max-w-sm p-8 bg-white rounded-lg shadow-lg">
			<h2 class="text-2xl font-semibold text-center text-indigo-600 mb-6">Login</h2>

			<form @submit.prevent="handleLogin">
				<div class="mb-4">
					<label for="email" class="block text-sm font-medium text-gray-700">Email</label>
					<InputText
						id="email"
						v-model="email"
						placeholder="Enter your email"
						class="w-full p-3 mt-2 text-sm border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500"
					/>
				</div>
				<div class="mb-6">
					<label for="password" class="block text-sm font-medium text-gray-700">Password</label>
					<InputText
						id="password"
						type="password"
						v-model="password"
						placeholder="Enter your password"
						class="w-full p-3 mt-2 text-sm border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500"
					/>
				</div>

				<Button label="Login" icon="pi pi-sign-in" type="submit" class="w-full p-3 bg-indigo-600 text-white hover:bg-indigo-700 rounded-md focus:outline-none" />
			</form>

			<p v-if="errorMessage" class="mt-4 text-center text-sm text-red-500">
				{{ errorMessage }}
			</p>
		</div>
	</div>
</template>