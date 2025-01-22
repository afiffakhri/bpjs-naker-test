<script setup>
	import { ref, computed, onMounted } from 'vue';
	import Button from 'primevue/button';
	import DataTable from 'primevue/DataTable';
	import Column from 'primevue/column';
	import { useRouter } from 'vue-router';

	import { getAllDeposito, getDepositoById, getDepositoByParams } from '../../api/deposito';
	import { getUserById } from '../../api/user';
	import { getBankById } from '../../api/bank';
	import { getDepositoRateById } from '../../api/depositoRates';
	import { getSettlementProcessByParams } from '../../api/settlementProcess';

	const userLogin = JSON.parse(localStorage.getItem('user'));

	// console.log(userLogin);

	const router = useRouter();
	const depositos = ref([]);

	const goToCreatePage = () => {
		router.push('/depositos/create');
	};

	const viewData = (id_deposito) => {
		router.push(`/depositos/${id_deposito}`);
	}

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

	const formatCurrency = (value) => {
		if (isNaN(value)) return value;
		return 'Rp.' + parseFloat(value).toLocaleString('id-ID');
	};

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
			const bankDeposito = await fetchBank(response.deposito_rate.id_bank);

			const tenor = response.deposito_rate.tenor;
			let rate = response.deposito_rate.rate;

			rate = (rate * 100).toFixed(2);

			const returnedRate = tenor + ' - ' + rate + '%';
			return {
				returnedRate,
				bankDeposito,
			};

		} catch (error) {
			console.error('Error fetching rate:', error)
			return 'Unknown Rate'
		}
	}

	const fetchDepositoById = async (id_deposito) => {
		try {
			const response = await getDepositoById(id_deposito);
			return response.deposito
		} catch (error) {
			console.error('Error fetching bank name:', error)
			return 'Unknown Bank'
		}
	}

	const fetchDepositos = async () => {
		try {
			let data;

			if(userLogin.id_role === 1) {
				data = await getAllDeposito();
				console.log(data);
			}
			else if(userLogin.id_role === 5) {
				data = await getDepositoByParams({
					created_by: userLogin.id_user
				});
			}
			else if(userLogin.id_role === 6) {
				const settlement_process = await getSettlementProcessByParams({
					id_unit_bisnis: userLogin.id_unit_bisnis,
					id_role: userLogin.id_role
				});

				const depositos = [];

				for (const settlement_status of settlement_process.settlement_process) {
					const depositoDetails = await getDepositoById(settlement_status.id_deposito);

					depositos.push(depositoDetails.deposito.deposito);
				}

				data = {
					depositos: depositos
				}
			}
			else {
				const settlement_process = await getSettlementProcessByParams({
					id_unit_bisnis: userLogin.id_unit_bisnis
				});

				const depositos = [];

				for (const settlement_status of settlement_process.settlement_process) {
					const depositoDetails = await getDepositoById(settlement_status.id_deposito);

					depositos.push(depositoDetails.deposito.deposito);
				}

				data = {
					depositos: depositos
				}
			}
			const depositosData = data.depositos

			const depositosWithDetails = await Promise.all(
				depositosData.map(async (deposito, index) => {
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
						rate: rate.returnedRate,
						bank_deposito: rate.bankDeposito,
						tanggal_penempatan: tanggal_penempatan,
						tanggal_jatuh_tempo: tanggal_jatuh_tempo,
						settlement_status: settlement_status,
						no: index + 1,
						deposit_value: formatCurrency(deposito.deposit_value),
						estimated_interest: formatCurrency(deposito.estimated_interest),
						estimated_value: formatCurrency(deposito.estimated_value)
					}
				})
			)
			// console.log(depositosWithDetails);
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
	<div class="p-8">
		<!-- Header Section -->
		<div class="flex justify-between items-center mb-4">
			<h1 class="text-2xl font-semibold">List Deposito</h1>
			<button 
				v-if="userLogin.id_role === 1 || userLogin.id_role === 5"
				@click="goToCreatePage"
				class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
				Create Deposito
			</button>
		</div>

		<div style="max-width: 75vw;">
			<DataTable
				v-if="depositos.length"
				:value="depositos"
				dataKey="id_deposito"
				stripedRows
				:paginator="true"
				:rows="10"
				:filters="filters"
				scrollable="true"
				scrollWidth="600"
				paginatorTemplate="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink CurrentPageReport RowsPerPageDropdown"
				:rowsPerPageOptions="[5, 10, 25]"
				currentPageReportTemplate="Showing {first} to {last} of {totalRecords} products"
            >
                <Column field="no" header="No." sortable style="width: 3rem"></Column>
                <Column field="name" header="Nama Nasabah" sortable style="min-width: 6rem"></Column>
                <Column field="deposit_value" header="Nominal Deposito" style="min-width: 12rem"></Column>
                <Column field="rate" header="Rate" style="min-width: 10rem"></Column>
                <Column field="bank_deposito" header="Bank Deposito" style="min-width: 8rem"></Column>
                <Column field="estimated_interest" header="Perkiraan Keuntungan" style="min-width: 12rem"></Column>
                <Column field="estimated_value" header="Perkiraan Jumlah Keuntungan" style="min-width: 12rem"></Column>
                <Column field="tanggal_penempatan" header="Tanggal Penempatan" style="min-width: 12rem"></Column>
                <Column field="tanggal_jatuh_tempo" header="Tanggal Jatuh Tempo" style="min-width: 16rem"></Column>
                <Column field="settlement_status" header="Status Pengajuan" style="min-width: 20rem"></Column>
                <Column field="user_name" header="Createad By" style="min-width: 16rem"></Column>
                <Column :exportable="false" style="min-width: 12rem">
                    <template #body="slotProps">
                        <Button icon="pi pi-eye" outlined rounded class="mr-2" @click="viewData(slotProps.data.id_deposito)" />
                    </template>
                </Column>
            </DataTable>
			<div v-else class="text-center p-4 text-xl text-gray-600">
				No Data Available
			</div>
		</div>
	</div>
</template>