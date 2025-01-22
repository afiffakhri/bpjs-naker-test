<script setup>
	import { ref, computed, onMounted } from 'vue';
	import Button from 'primevue/button';
	import Card from 'primevue/card';
	import Dialog from 'primevue/dialog';
	import DataTable from 'primevue/DataTable';
	import Column from 'primevue/column';
	import { useRouter } from 'vue-router';

	import { getAllRoles, getRolesById } from '../../api/role';

	const userLogin = JSON.parse(localStorage.getItem('user'));

	const router = useRouter();
	const roles = ref([]);

	const goToCreatePage = () => {
		router.push('/roles/create');
	};

	const editData = (id_role) => {
		router.push(`/roles/edit/${id_role}`);
	}

	const viewData = (id_role) => {
		router.push(`/roles/${id_role}`);
	}

	const deleteData = (id_role) => {
		router.push(`/roles/${id_role}`);
	}

	const fetchRoles = async () => {
		try {
			const data = await getAllRoles();

			roles.value = data.roles.map((role, index) => ({
				...role,
				no: index + 1
			}));
		} catch (error) {
			console.log(error)
		}
	}

	console.log(roles.data);

	onMounted(() => {
		fetchRoles()
	});
</script>

<template>
	<div class="w-full p-4">
		<div class="p-4">
			<h2 class="text-2xl font-semibold">Role Management</h2>
			<p>Welcome to the Admin Dashboard</p>
		</div>
		<Card v-if="roles" :title="roles.id_role" class="w-full">
			<template #content>
				<div class="space-y-6">
					<div class="flex justify-between items-center mb-4">
						<h1 class="text-2xl font-semibold">List Role</h1>
						<button 
							@click="goToCreatePage"
							class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
							Add Role
						</button>
					</div>
					<div>
						<DataTable
							v-if="roles.length"
							:value="roles"
							dataKey="id_role"
							stripedRows
							:paginator="true"
							:rows="10"
							:filters="filters"
							scrollable="true"
							paginatorTemplate="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink CurrentPageReport RowsPerPageDropdown"
							:rowsPerPageOptions="[5, 10, 25]"
							currentPageReportTemplate="Showing {first} to {last} of {totalRecords} products"
			            >
			                <Column field="no" header="No." sortable></Column>
			                <Column field="role" header="Role" sortable></Column>
			                <Column :exportable="false">
			                    <template #body="slotProps">
			                        <Button icon="pi pi-pencil" outlined rounded class="mr-2" @click="editData(slotProps.data.id_role)" />
			                        <Button icon="pi pi-trash" outlined rounded severity="danger" @click="confirmDeleteProduct(slotProps.id_role)" />
			                    </template>
			                </Column>
			            </DataTable>
						<div v-else class="text-center p-4 text-xl text-gray-600">
							No Data Available
						</div>
					</div>
				</div>
			</template>
		</Card>

		<!-- Show a loading indicator while the data is being fetched -->
	    <div v-else class="flex justify-center items-center">
	    	<span class="text-xl">Loading...</span>
	    </div>

	    <Dialog v-model:visible="approvalDialog" modal header="Header" :style="{ width: '50vw' }" :breakpoints="{ '1199px': '75vw', '575px': '90vw' }">
	    	<div class="flex items-center gap-4 mb-4">
	    		<i class="pi pi-exclamation-triangle !text-3xl" />
	    		<span class="text-red-300 text-sm">Apakah anda yakin? Segala proses yang sudah dilaksanakan tidak bisa diulang kembali.</span>
            </div>

	    	<div>
	    		<label for="catatan" class="block font-semibold mb-3">*Catatan:</label>
	    		<Textarea id="remarks" v-model="remarks" rows="2" cols="20" fluid />
	    	</div>

	    	<div class="mt-3 text-right">
	    		<Button 
	    			label="Cancel"
	    			icon="pi pi-times"
	    			class="p-button p-button-warn mr-2" 
	    			@click="closeDialog"
	    		/>

	    		<Button 
	    			v-if="action === 'approve'" 
	    			label="Approve"
	    			icon="pi pi-check"
	    			class="mr-2" 
	    			@click="handleApproveReject(1)"
	    		/>
	    		<Button
	    			v-if="action === 'reject'"
	    			label="Reject"
	    			icon="pi pi-ban"
	    			class="p-button p-button-danger"
	    			@click="handleApproveReject(2)"
	    		/>
	    	</div>
	    </Dialog>
	</div>
</template>