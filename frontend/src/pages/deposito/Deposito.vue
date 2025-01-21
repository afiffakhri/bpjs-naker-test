<script setup>
	import { ref, computed, onMounted } from 'vue';
	import Button from 'primevue/button';
	import DataTable from 'primevue/DataTable';
	import Column from 'primevue/column';
	import { useRouter } from 'vue-router';

	import { getDepositoByParams } from '../../api/deposito';
	import { getUserById } from '../../api/user';
	import { getBankById } from '../../api/bank';
	import { getDepositoRateById } from '../../api/depositoRates';

	const userLogin = JSON.parse(localStorage.getItem('user'));

	console.log(userLogin);

	const router = useRouter();
	const depositos = ref([]);

	const goToCreatePage = () => {
		router.push('/depositos/create');
	};

	function formatDate(dateString) {
		const date = new Date(dateString);

		const day = String(date.getDate()).padStart(2, '0');
		const month = String(date.getMonth() + 1).padStart(2, '0');
		const year = String(date.getFullYear()).slice(2);
		const hours = String(date.getHours()).padStart(2, '0');
		const minutes = String(date.getMinutes()).padStart(2, '0');
		const seconds = String(date.getSeconds()).padStart(2, '0');

		return `${day}-${month}-${year} ${hours}:${minutes}:${seconds}`;
	}

	function convertSettlementStatus(settlement_status){
		switch(settlement_status) {
			case 0:
				return 'Pengajuan telah dibuat, menunggu konfirmasi pertama'
			case 1:
				return 'On Progress'
			case 2:
				return 'Settled'
			case 3:
				return 'Rejected'
			default:
				return 'Unknown role, please contact support.'
		}
	}

	const fetchUser = async (created_by) => {
		try {
			const response = await getUserById(created_by);
			return response.selectedUser.name
		} catch (error) {
			console.error('Error fetching user name:', error)
			return 'Unknown User'
		}
	}

	const fetchBank = async (id_bank) => {
		try {
			const response = await getBankById(id_bank);
			return response.selectedBank.bank_name
		} catch (error) {
			console.error('Error fetching bank name:', error)
			return 'Unknown Bank'
		}
	}

	const fetchRate = async (id_deposito_rate) => {
		try {
			const response = await getDepositoRateById(id_deposito_rate);
			const tenor = response.deposito_rate.tenor;
			let rate = response.deposito_rate.rate;

			rate = (rate * 100).toFixed(2);

			const returnedRate = tenor + ' - ' + rate + '%';
			return returnedRate;

		} catch (error) {
			console.error('Error fetching rate:', error)
			return 'Unknown Rate'
		}
	}

	const fetchDepositos = async () => {
		try {
			const data = await getDepositoByParams({
				created_by: 8,
				id_bank: 11
			});
			const depositosData = data.depositos

			const depositosWithDetails = await Promise.all(
				depositosData.map(async (deposito) => {
					const userName = await fetchUser(deposito.created_by)
					const bankName = await fetchBank(deposito.id_bank)
					const rate = await fetchRate(deposito.id_deposito_rate)
					const tanggal_penempatan = formatDate(deposito.tanggal_penempatan)
					const tanggal_jatuh_tempo = formatDate(deposito.tanggal_jatuh_tempo)
					const settlement_status = convertSettlementStatus(deposito.settlement_status)

					return {
						...deposito,
						user_name: userName,
						bank_name: bankName,
						rate: rate,
						tanggal_penempatan: tanggal_penempatan,
						tanggal_jatuh_tempo: tanggal_jatuh_tempo,
						settlement_status: settlement_status
					}
				})
			)
			console.log(depositosWithDetails);
			depositos.value = depositosWithDetails
		} catch (error) {
			console.error('Error fetching depositos:', error)
		}
	}

	onMounted(() => {
		fetchDepositos()
	});
</script>

<template>
	<div class="p-4">
		<!-- Header Section -->
		<div class="flex justify-between items-center mb-4">
			<h1 class="text-2xl font-semibold">List Deposito</h1>
			<button 
				@click="goToCreatePage"
				class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
				Create Deposito
			</button>
		</div>

		<div>
			<DataTable v-if="depositos.length" :value="depositos" dataKey="id" paginator rows="5" responsiveLayout="scroll" class="p-datatable-sm">
				<Column field="id_deposito" header="ID" />
				<Column field="name" header="Nama Nasabah" />
				<Column field="deposit_value" header="Nominal Deposito" />
				<Column field="rate" header="Rate" />
				<Column field="bank_name" header="Bank Deposito" />
				<Column field="estimated_interest" header="Perkiraan Keuntungan" />
				<Column field="estimated_value" header="Perkiraan Jumlah Keuntungan" />
				<Column field="tanggal_penempatan" header="Tanggal Penempatan" />
				<Column field="tanggal_jatuh_tempo" header="Tanggal Jatuh Tempo" />
				<Column field="settlement_status" header="Status Pengajuan" />
				<Column field="user_name" header="Createad By" />
			</DataTable>
			<div v-else class="text-center p-4 text-xl text-gray-600">
				No Data Available
			</div>
		</div>
	</div>
</template>