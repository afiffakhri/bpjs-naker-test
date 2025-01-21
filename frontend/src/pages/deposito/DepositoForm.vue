<script setup>
import { ref, computed, onMounted, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import InputText from 'primevue/inputtext';
import InputNumber from 'primevue/inputnumber';
import Dropdown from 'primevue/dropdown';
import Button from 'primevue/button';

import { getAllBank } from '../../api/bank';
import { getAllRoles } from '../../api/role';
import { getUserByParams } from '../../api/user';
import { getAllDepositoRate, getDepositoRateById, getDepositoRateByBankId } from '../../api/depositoRates';
import { createDeposito } from '../../api/deposito';

const userLogin = JSON.parse(localStorage.getItem('user'));

const formData = ref({
	name: '',
	email: '',
	phone: '',
	selectedBank: null,
	nasabahName: '',
	rekeningNumber: '',
	nominal: 0,
	selectedDepositBank: null,
	selectedInterestRate: null,
	estimatedInterest: 0,
	estimated_value: 0
});

const router = useRouter();
const route = useRoute();
const banks = ref();
const interestRates = ref([]);
const tenor = ref('');
const rate = ref('');
const months = ref('');
const roles = ref([]);
const users = ref({});

const investasiRows = ref([
	{ id_role: null, id_user: null },
]);

const settlementRows = ref([
	{ id_role: null, id_user: null },
]);

onMounted(() => {
	fetchAllBanks();
	getRoles();
});

const onlyNumber = ($event) => {
   //console.log($event.keyCode); //keyCodes value
   let keyCode = ($event.keyCode ? $event.keyCode : $event.which);
   if (keyCode < 48 || keyCode > 57) { // 46 is dot
      $event.preventDefault();
      alert('Please only input number');
   }
}

const getRoles = async () => {
	try {
		const data = await getAllRoles();
		roles.value = data.roles;
	} catch (error) {
		console.log(error)
	}
};

const fetchAllBanks = async () => {
	try {
		const data = await getAllBank();
		banks.value = data.banks;
	} catch (error) {
		console.log(error)
	}
};

const fetchInterestRates = async () => {
	if (!formData.value.selectedDepositBank) {
		interestRates.value = [];
		return;
	}

	try {
		const response = await getDepositoRateByBankId(formData.value.selectedDepositBank);
		interestRates.value = response.deposito_rates;
	} catch (error) {
		console.error('Error fetching interest rates:', error);
	}
};

const fetchUsers = async (index, type = 'investasi') => {
	const row = type === 'investasi' ? investasiRows.value[index] : settlementRows.value[index];
	const id_unit_bisnis = type === 'investasi' ? 1 : 2;


	if (row.id_role) {
		 const data = await getUserByParams(id_unit_bisnis, row.id_role);
		 // console.log(data);
		 users.value[row.id_role] = data.users;
	}
};

const formattedInterestRates = computed(() => {
	return interestRates.value.map(rate => ({
		...rate,
		interestLabel: `${rate.tenor} - ${(rate.rate * 100).toFixed(2)}%`,
	}));
});

watch(
	[
		() => formData.value.nominal, 
		() => formData.value.selectedInterestRate
	], 
	() => {
		if (formData.value.nominal) {
			calculateEstimatedInterest();
		}

		if (formData.value.selectedInterestRate) {
			chooseRate();
		}
	}
);

const chooseRate = async () => {
	const selectedRate = formData.value.selectedInterestRate;

	if (selectedRate) {
		try {
			const rateData = await getDepositoRateById(selectedRate);
			tenor.value = rateData.deposito_rate.tenor;
			rate.value = rateData.deposito_rate.rate;

			calculateEstimatedInterest();
		} catch (error) {
			console.error('Error fetching rate data:', error);
		}
	}
};

const calculateEstimatedInterest = () => {
	const nominal = formData.value.nominal;
	months.value = tenor.value ? parseInt(tenor.value.split(' ')[0], 10) : 12;
	let daysInMonth = 365;

	if(months.value != 12){
		daysInMonth = months.value * 30;;
	}

	if(nominal){
		formData.value.estimatedInterest = nominal;
	}

	if (formData.value.nominal && formData.value.selectedInterestRate) {
		const interest = ((nominal * rate.value) * (daysInMonth/365) );
		formData.value.estimatedInterest = interest.toFixed(2);
	}
};

const isInvalid = (value) => {
	return !value;
};

const addRow = (type) => {
	const newRow = { id_role: null, id_user: null };
	if (type === 'investasi') {
		investasiRows.value.push(newRow);
	} else if (type === 'settlement') {
		settlementRows.value.push(newRow);
	}
};

const removeRow = (type, index) => {
	if (type === 'investasi') {
		investasiRows.value.splice(index, 1);
	} else if (type === 'settlement') {
		settlementRows.value.splice(index, 1);
	}
};


const submit = async () => {
	formData.value.estimated_value = Number(formData.value.nominal) + Number(parseFloat(formData.value.estimatedInterest).toFixed(2));

	const depositoData = {
		id_deposito_rate: formData.value.selectedInterestRate,
		deposit_value: formData.value.nominal,
		estimated_interest: formData.value.estimatedInterest,
		estimated_value: formData.value.estimated_value,
		months: months.value,
		name: formData.value.name,
		email: formData.value.email,
		phone: formData.value.phone,
		nama_pemegang_rekening: formData.value.nasabahName,
		id_bank: formData.value.selectedBank,
		nomor_rekening: formData.value.rekeningNumber,
		selectedDepositBank: formData.value.selectedDepositBank,
		created_by: userLogin.id_user
	};

	if(!investasiRows.value[0]?.id_role){
		alert("Please choose at least 1 from Unit Bisnis Investasi in Settlement Process");
		return false;
	}
	else{
		depositoData.unit_bisnis_investasi = investasiRows.value;
	}

	if(!settlementRows.value[0]?.id_role){
		alert("Please choose at least 1 from Unit Bisnis Settlement in Settlement Process");
		return false;
	}
	else{
		depositoData.unit_bisnis_settlement = settlementRows.value;
	}

	try {
		const response = await createDeposito(depositoData);
		// console.log('Deposito created successfully:', response);

		router.push('/depositos');
		alert('Deposito successfully created!');
	} catch (error) {
		console.error('Error creating deposito:', error);
		alert('There was an error creating the deposito. Please try again.');
	}
};

const cancel = () => {
	router.push('/depositos');
};
</script>

<template>
	<div class="p-6 max-w-4xl mx-auto">
		<h1 class="text-2xl font-semibold mb-6">Formulir Deposito</h1>

		<form @submit.prevent="submit" class="space-y-6">

			<!-- First Section: Data Nasabah -->
			<div class="border-b pb-6">
				<h2 class="text-xl font-semibold mb-4">Data Nasabah</h2>
				<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
					<div class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm">
						<label for="name" class="block font-medium mb-2">Nama</label>
						<InputText v-model="formData.name" id="name" class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm" fluid type="text" placeholder="Nama" required />
					</div>
					<div>
						<label for="email" class="block font-medium mb-2">Email</label>
						<InputText v-model="formData.email" type="email" class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm" id="email" fluid required />
					</div>
					<div>
						<label for="phone" class="block font-medium mb-2">Nomor Telepon</label>
						<InputText v-model="formData.phone" @keypress="onlyNumber" type="tel" id="phone" class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm" fluid required />
					</div>
				</div>
			</div>

			<!-- Second Section: Data Rekening Pembayaran -->
			<div class="border-b pb-6">
				<h2 class="text-xl font-semibold mb-4">Data Rekening Pembayaran</h2>
				<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
					<div>
						<label for="bank" class="block font-medium mb-2">Bank</label>
						<Dropdown 
							v-model="formData.selectedBank" :options="banks" optionLabel="bank_name" optionValue="id_bank" placeholder="Pilih Bank" class="w-full md:w-14rem" required />
					</div>
					<div>
						<label for="nasabah" class="block font-medium mb-2">Nama Pemegang Rekening</label>
						<InputText v-model="formData.nasabahName" type="text" id="nasabah" class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm" fluid required />
					</div>
					<div>
						<label for="rekening" class="block font-medium mb-2">Nomor Rekening</label>
						<InputText v-model="formData.rekeningNumber" @keypress="onlyNumber" type="text" id="rekening" class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm" fluid required />
					</div>
				</div>
			</div>

			<!-- Third Section: Data Deposito -->
			<div class="border-b pb-6">
				<h2 class="text-xl font-semibold mb-4">Data Deposito</h2>
				<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
					<div>
						<label for="nominal" class="block font-medium mb-2">Nominal Penempatan</label>
						<InputText 
							v-model="formData.nominal"
							@keypress="onlyNumber"
							id="nominal"
							class="w-full"
							inputId="withoutgrouping"
							:useGrouping="false"
							placeholder="Nominal"
							fluid />
					</div>
					<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
						<div>
							<label for="interestRate" class="block font-medium mb-2">Pilih Bank</label>
							<Dropdown 
							v-model="formData.selectedDepositBank" :options="banks" optionLabel="bank_name" optionValue="id_bank" placeholder="Pilih Bank" class="w-full md:w-14rem" @change="fetchInterestRates" required />
						</div>
						<div>
							<label for="interestRate" class="block font-medium mb-2">Interest Rate</label>
							<Dropdown 
								v-model="formData.selectedInterestRate"
								:options="formattedInterestRates"
								optionLabel="interestLabel"
								optionValue="id_deposito_rate"
								placeholder="Pilih Rate"
								class="w-full"
								:disabled="!formData.selectedDepositBank || !interestRates.length"
								required />
						</div>
					</div>
					<div>
						<label for="estimatedInterest" class="block font-medium mb-2">Estimated Interest</label>
						<InputText
							v-model="formData.estimatedInterest"
							type="text"
							id="estimatedInterest"
							class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm" fluid
							readonly
						/>
					</div>
				</div>
			</div>

			<div class="border-b pb-6">
				<h2 class="text-xl font-semibold mb-4">Settlement Process</h2>

				<div class="space-y-6">
					<div class="border p-4 rounded-lg">
						<h3 class="text-xl font-semibold mb-4">Unit Bisnis Investasi</h3>
						<p class="text-blue-400 text-sm">*Process settlement deposito bottom - up</p>
						<div v-for="(row, index) in investasiRows" :key="index" class="flex gap-4 mb-4">
							<div class="w-full">
								<label class="block text-sm font-semibold mb-1">Role</label>
								<Dropdown 
									v-model="row.id_role"
									:options="roles"
									optionLabel="role"
									optionValue="id_role"
									placeholder="Pilih Role"
									class="w-full md:w-14rem"
									:required="true"
									:class="{'border-red-500': isInvalid(row.id_role)}"
									@change="fetchUsers(index)"
								/>
								<p v-if="isInvalid(row.id_role)" class="text-red-500 text-sm">Role is required</p>
							</div>

							<div class="w-full">
								<label class="block text-sm font-semibold mb-1">User</label>
								<Dropdown
									v-model="row.id_user"
									:options="users[row.id_role] || []"
									optionLabel="name"
									optionValue="id_user"
									placeholder="Pilih User"
									class="w-full"
								/>
							</div>

							<Button 
								v-if="index === 0" 
								@click="addRow('investasi')" 
								class="p-2 bg-green-500 text-white rounded-full hover:bg-green-600 focus:outline-none">
								<i class="pi pi-plus"></i>
							</Button>

							<Button 
								v-else 
								@click="removeRow('investasi', index)" 
								class="p-2 bg-red-500 text-white rounded-full hover:bg-red-600 focus:outline-none">
								<i class="pi pi-trash"></i>
							</Button>
						</div>
					</div>
					<div class="border p-4 rounded-lg">
						<h3 class="text-xl font-semibold mb-4">Unit Bisnis Settlement</h3>
						<p class="text-blue-400 text-sm">*Process settlement deposito top - down</p>
						<div v-for="(row, index) in settlementRows" :key="index" class="flex gap-4 mb-4">
							<div class="w-full">
								<label class="block text-sm font-semibold mb-1">Role</label>
								<Dropdown
									v-model="row.id_role"
									:options="roles"
									optionLabel="role"
									optionValue="id_role"
									placeholder="Pilih Role"
									class="w-full"
									:required="true"
									:class="{'border-red-500': isInvalid(row.id_role)}"
									@change="fetchUsers(index, 'settlement')"
								/>
								<p v-if="isInvalid(row.id_role)" class="text-red-500 text-sm">Role is required</p>
							</div>

							<div class="w-full">
								<label class="block text-sm font-semibold mb-1">User</label>
								<Dropdown
									v-model="row.id_user"
									:options="users[row.id_role] || []"
									optionLabel="name"
									optionValue="id_user"
									placeholder="Pilih User"
									class="w-full"
								/>
							</div>
							<Button 
								v-if="index === 0" 
								@click="addRow('settlement')" 
								class="p-2 bg-green-500 text-white rounded-full hover:bg-green-600 focus:outline-none">
								<i class="pi pi-plus"></i>
							</Button>
							<Button
								v-else
								@click="removeRow('settlement', index)" 
								class="p-2 bg-red-500 text-white rounded-full hover:bg-red-600 focus:outline-none">
								<i class="pi pi-trash"></i>
							</Button>
						</div>
					</div>
				</div>
			</div>

			<div class="mt-6 float-right">
				<Button class="m-4" label="Cancel" icon="pi pi-times" @click="cancel" severity="warn" rounded />
				<Button class="m-4" label="Submit" icon="pi pi-money-bill" type="submit" severity="success" rounded />
			</div>
		</form>
	</div>
</template>