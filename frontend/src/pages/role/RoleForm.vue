<script setup>
	import { ref, computed, onMounted } from 'vue';
	import Button from 'primevue/button';
	import Card from 'primevue/card';
	import InputText from 'primevue/inputtext';
	import { useRouter, useRoute } from 'vue-router';

	import { getRolesById, createRole, updateRole } from '../../api/role';

	const userLogin = JSON.parse(localStorage.getItem('user'));

	const route = useRoute();
	const router = useRouter();
	const role = ref({
		role: '',
	});

	const goBack = () => {
		router.push('/roles');
	};

	const formTitle = computed(() => {
		return route.params.id_role ? 'Update Role' : 'Add New Role';
	});

	const fetchRole = async (id) => {
		try {
			const data = await getRolesById(id);

			return data.selectedRole;
		} catch (error) {
			console.log(error)
		}
	}

	onMounted(async () => {
		if (route.params.id_role) {
			role.value = await fetchRole(route.params.id_role);
		}
	});

	const submitForm = () => {
		if (role.value.id_role) {
			patchRole(role.value);
		} else {
			addRole(role.value);
		}
	};

	const addRole = async (newRole) => {
		console.log('Adding role:', newRole);

		try {
			const response = await createRole(newRole);
			router.push('/roles');
			alert('Role successfully created!');
		} catch (error) {
			console.error('Error creating role:', error);
			alert('There was an error creating the role. Please try again.');
		}
	};

	const patchRole = async (updatedRole) => {
		try {
			console.log(updatedRole.id_role);
			const response = await updateRole(updatedRole);
			router.push('/roles');
			alert('Roles successfully updated!');
		} catch (error) {
			console.error('Error updating roles:', error);
			alert('There was an error updating the roles. Please try again.');
		}
		console.log('Updating role:', updatedRole);
	};
</script>
<template>
	<div class="w-full p-4">
		<Card v-if="role" :title="role.id_role" class="w-full">
			<template #content>
				<div class="space-y-6">
					<Button label="Go Back" icon="pi pi-arrow-left" class="p-button-text" @click="goBack" />
					<div class="flex justify-between items-center mb-4">
						<h1 class="text-2xl font-semibold">{{ formTitle }}</h1>
					</div>
					<form @submit.prevent="submitForm" class="space-y-4 bg-white p-6 rounded-lg shadow-md">
						<div class="flex flex-col">
							<label for="roleName" class="mb-2 text-lg font-semibold">Role Name</label>
							<InputText
								v-model="role.role" 
								id="role_name" 
								class="p-inputtext w-full border-2 rounded-md"
								placeholder="Enter role name"
								required
							/>
						</div>

						<!-- Submit Button -->
						<div class="flex justify-end">
							<Button 
								label="Save Role" 
								icon="pi pi-save" 
								class="p-button p-button-primary" 
								type="submit" 
							/>
						</div>
					</form>
				</div>
			</template>
		</Card>
	</div>
</template>