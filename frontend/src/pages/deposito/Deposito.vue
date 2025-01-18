<script setup>
	import { ref, computed } from 'vue';
	import Button from 'primevue/button';
	import DataTable from 'primevue/DataTable';
	import { useRouter } from 'vue-router';

	const router = useRouter();
	const depositos = ref([]);

	const goToCreatePage = () => {
		router.push('/depositos/create');
	};
</script>

<template>
	<div class="p-4">
		<h2 class="text-2xl font-semibold">Deposito Management</h2>

		<Button
  			label="Add Deposito"
  			icon="pi pi-plus"
  			class="p-button-success mb-4 float-right"
  			@click="goToCreatePage"
  		/>
  		<div>
			<DataTable v-if="depositos.length" :value="depositos" dataKey="id" paginator rows="5" responsiveLayout="scroll">
				<Column field="name" header="Deposito Name" />
				<Column field="amount" header="Amount" />
				<Column field="createdAt" header="Created At" />
				<Column
					header="Actions"
					body="{ item }"
					:body-style="{ textAlign: 'center' }"
					:header-style="{ textAlign: 'center' }"
				>
					<Button
						icon="pi pi-eye"
						class="p-button-info p-mr-2"
						@click="onView"
					/>
				</Column>
			</DataTable>
			<div v-else class="text-center p-4 text-xl text-gray-600">
				No Data Available
			</div>
		</div>
	</div>
</template>