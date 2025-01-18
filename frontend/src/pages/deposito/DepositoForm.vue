<script setup>
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import InputText from 'primevue/inputtext';
import InputNumber from 'primevue/inputnumber';
import Button from 'primevue/button';

const form = ref({
	id: null,
	name: '',
	amount: null,
});

const router = useRouter();
const route = useRoute();

// Check if it's an edit mode or a create mode based on the route parameters
onMounted(() => {

});


// Create a new deposito
const createDeposito = async () => {
	await depositoService.createDeposito(form.value);
	router.push('/depositos');
};

// Cancel and navigate back to the deposito list
const cancel = () => {
	router.push('/depositos');
};
</script>

<template>
	<div class="p-4">
		<h2 class="text-2xl font-semibold mb-4">
			Deposit
		</h2>

		<form @submit.prevent="isEditMode ? updateDeposito() : createDeposito()">
			<div class="p-fluid">
				<div class="p-field">
					<label for="name">Deposito Name</label>
					<InputText
						id="name"
						v-model="form.name"
						placeholder="Enter deposito name"
						required
					/>
				</div>
				<div class="p-field">
					<label for="amount">Amount</label>
					<InputNumber
						id="amount"
						v-model="form.amount"
						placeholder="Enter amount"
						mode="currency"
						currency="USD"
						locale="en-US"
						required
					/>
				</div>
				<div class="p-d-flex p-jc-between">
					<Button label="Cancel" icon="pi pi-times" @click="cancel" class="p-button-text" />
					<Button label="Save" icon="pi pi-check" type="submit" class="p-button-primary" />
				</div>
			</div>
		</form>
	</div>
</template>