<script setup>
	import { ref, onMounted } from 'vue';
	import Button from 'primevue/button';
	import Card from 'primevue/card';
	import Dialog from 'primevue/dialog';
	import Textarea from 'primevue/textarea';
	import { useToast } from 'primevue/usetoast';
	import { useRouter, useRoute } from 'vue-router';

	import { getDepositoByParams, getDepositoById } from '../../api/deposito';
	import { getUserById } from '../../api/user';
	import { getRolesById } from '../../api/role';
	import { getUnitBisnisById } from '../../api/unitBisnis';
	import { getBankById } from '../../api/bank';
	import { getDepositoRateById } from '../../api/depositoRates';
	import { updateSettlementProcess } from '../../api/settlementProcess';

	const userLogin = JSON.parse(localStorage.getItem('user'));

	const route = useRoute()
	const router = useRouter();
	const toast = useToast();
	const depositos = ref([]);
	const settlementProcess = ref([]);
	const deposito = ref(null);
	const loading = ref(true);
	const approvalDialog = ref(false);
	const action = ref(null);
	const remarks = ref('');
	const dataApproval = ref({});
	const depositoId = route.params.id_deposito

	const openDialog = (datas, actionType) => {
		dataApproval.value = { ...datas, updated_by: userLogin.id_user, nama_approver: userLogin.name};
		action.value = actionType
		approvalDialog.value = true
	}

	const closeDialog = () => {
		approvalDialog.value = false
		dataApproval.value = {};
		remarks.value = ''
	}


	const goBack = () => {
		router.push('/depositos');
	};

	function showApprovalButtons(person) {
		const isApprovalButtonTrue = person.approvalButton === true;
		const isSameUnitBisnis = person.id_unit_bisnis === userLogin.id_unit_bisnis;
		const isSameRole = person.id_role === userLogin.id_role;
		const isUserAssigned = person.id_user === null || person.id_user === userLogin.id_user;

		// console.log(isApprovalButtonTrue && isSameUnitBisnis && isSameRole && isUserAssigned);

		return isApprovalButtonTrue && isSameUnitBisnis && isSameRole && isUserAssigned;
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

	function convertSettlementProcess(settlement_process){
		switch(settlement_process) {
			case 0:
				return 'Menunggu Persetujuan'
			case 1:
				return 'Approved'
			case 2:
				return 'Rejected'
			default:
				return 'Unknown role, please contact support.'
		}
	}

	const handleApproveReject = async (status) => {
		try {
			dataApproval.value.status = status;
			dataApproval.value.remarks = remarks.value;
			const response = await updateSettlementProcess(dataApproval.value);
			// console.log('Deposito created successfully:', response);
			router.push('/depositos');
			alert('Settlement Status successfully updated!');
			approvalDialog.value = false;
		} catch (error) {
			console.error('Error updating settlement status:', error);
			alert('There was an error updating the settlement_status. Please try again.');
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

	const fetchUnitBisnis = async (id_unit_bisnis) => {
		try {
			const response = await getUnitBisnisById(id_unit_bisnis);
			return response.unit_bisnis.unit_bisnis
		} catch (error) {
			console.error('Error fetching unit bisnis name:', error)
			return 'Unknown User'
		}
	}

	const fetchRole = async (id_role) => {
		try {
			const response = await getRolesById(id_role);
			return response.selectedRole.role
		} catch (error) {
			console.error('Error fetching role name:', error)
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

	const fetchDeposito = async () => {
		try {
			const data = await getDepositoById(depositoId);
			const depositoData = data.deposito.deposito
		    const settlementData = data.deposito.settlement_process

		    // GET DETAIL FOR DEPOSITO
		    const userName = await fetchUser(depositoData.created_by)
		    const bankName = await fetchBank(depositoData.id_bank)
		    const rate = await fetchRate(depositoData.id_deposito_rate)
		    const tanggal_penempatan = formatDate(depositoData.tanggal_penempatan)
		    const tanggal_jatuh_tempo = formatDate(depositoData.tanggal_jatuh_tempo)
		    const settlement_status = convertSettlementStatus(depositoData.settlement_status)

		    const depositoWithDetails = {
				...depositoData,
				user_name: userName,
				bank_name: bankName,
				rate: rate.returnedRate,
				bank_deposito: rate.bankDeposito,
				tanggal_penempatan: tanggal_penempatan,
				tanggal_jatuh_tempo: tanggal_jatuh_tempo,
				settlement_status: settlement_status,
				deposit_value: formatCurrency(depositoData.deposit_value),
				estimated_interest: formatCurrency(depositoData.estimated_interest),
				estimated_value: formatCurrency(depositoData.estimated_value)
			}

			
			let settlementDataWithDetails
			if(settlementData.length){
				settlementDataWithDetails = await Promise.all(
					settlementData.map(async (settlement_status, index) => {
						const unitBisnis = await fetchUnitBisnis(settlement_status.id_unit_bisnis)
						const role = await fetchRole(settlement_status.id_role)
						const nama_approver = (settlement_status.id_user) ? await fetchUser(settlement_status.id_user) : null;
						const approvedBy = (settlement_status.updated_by) ? await fetchUser(settlement_status.updated_by) : null;
						const settlement_process_status = convertSettlementProcess(settlement_status.status);

						let showButton = false;
						if(index === 0 && settlement_status.status === 0){
							showButton = true;
						}
						else if (index > 0 && settlementData[index - 1].status !== 0 && settlementData[index - 1].status !== 2 && settlement_status.status === 0) {
							showButton = true;
						}

						// const showButton = (index === 0 || (settlementData[index - 1].status !== 0 && settlementData[index - 1].status !== 2));
						const lastProcess = index === settlementData.length - 1;

						return {
							...settlement_status,
							unit_bisnis: unitBisnis,
							role: role,
							approver: nama_approver,
							approvedBy: approvedBy,
							approvalButton: showButton,
							settlement_process_status: settlement_process_status,
							updated_at: formatDate(settlement_status.updated_at),
							last_process: lastProcess
						}
					})
				)
			}
			else{
				settlementDataWithDetails = settlementData;
			}

			console.log(settlementDataWithDetails);

			return {
				depositoWithDetails,
				settlementDataWithDetails
			};
		} catch (error) {
			console.error('Error fetching depositos:', error)
		}
	}

	onMounted(async () => {
		// deposito.value = await fetchDeposito()
		const data = await fetchDeposito();

		deposito.value = data.depositoWithDetails;
		settlementProcess.value = data.settlementDataWithDetails
		loading.value = false 
	});
</script>
<template>
	<div class="w-full p-4">
		<Card v-if="deposito" :title="deposito.id_deposito" class="w-full">
			<template #content>
				<div class="space-y-6">
					<Button label="Go Back" icon="pi pi-arrow-left" class="p-button-text" @click="goBack" />					
					<div>
						<h3 class="text-lg font-semibold my-4">Data Deposito - {{ deposito.name }}</h3>
						<table class="min-w-full table-auto border-collapse border border-gray-300">
							<!-- Data Nasabah -->
							<thead>
								<tr class="bg-gray-200">
									<th class="px-4 py-2 text-left border border-gray-300" colspan="4">
										<h3 class="text-lg font-semibold">Data Nasabah</h3>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr class="odd:bg-gray-50">
									<td class="px-4 py-2 font-semibold border border-gray-300" colspan="2">Nama Nasabah:</td>
									<td class="px-4 py-2 border border-gray-300" colspan="2">{{ deposito.name }}</td>
								</tr>
								<tr class="odd:bg-gray-50">
									<td class="px-4 py-2 font-semibold border border-gray-300" colspan="2">Email:</td>
									<td class="px-4 py-2 border border-gray-300" colspan="2">{{ deposito.email }}</td>
								</tr>
								<tr class="odd:bg-gray-50">
									<td class="px-4 py-2 font-semibold border border-gray-300" colspan="2">Nomor Telepon:</td>
									<td class="px-4 py-2 border border-gray-300" colspan="2">{{ deposito.phone }}</td>
								</tr>
							</tbody>
							<!-- Data Rekening Pembayaran -->
							<thead>
								<tr class="bg-gray-200">
									<th class="px-4 py-2 text-left border border-gray-300" colspan="4">
										<h3 class="text-lg font-semibold">Data Rekening Pembayaran</h3>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr class="odd:bg-gray-50">
									<td class="px-4 py-2 font-semibold border border-gray-300" colspan="2">Nama Pemegang Rekening:</td>
									<td class="px-4 py-2 border border-gray-300" colspan="2">{{ deposito.nama_pemegang_rekening }}</td>
								</tr>
								<tr class="odd:bg-gray-50">
									<td class="px-4 py-2 font-semibold border border-gray-300" colspan="2">Nomor Rekening:</td>
									<td class="px-4 py-2 border border-gray-300" colspan="2">{{ deposito.nomor_rekening }}</td>
								</tr>
								<tr class="odd:bg-gray-50">
									<td class="px-4 py-2 font-semibold border border-gray-300" colspan="2">Bank:</td>
									<td class="px-4 py-2 border border-gray-300" colspan="2">{{ deposito.bank_name }}</td>
								</tr>
							</tbody>
							<!-- Data Deposito -->
							<thead>
								<tr class="bg-gray-200">
									<th class="px-4 py-2 text-left border border-gray-300" colspan="4">
										<h3 class="text-lg font-semibold">Data Deposito</h3>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr class="odd:bg-gray-50">
									<td class="px-4 py-2 font-semibold border border-gray-300" colspan="2">Nominal:</td>
									<td class="px-4 py-2 border border-gray-300" colspan="2">{{ deposito.deposit_value }}</td>
								</tr>
								<tr class="odd:bg-gray-50">
									<td class="px-4 py-2 font-semibold border border-gray-300" colspan="2">Bank Penyedia Deposito:</td>
									<td class="px-4 py-2 border border-gray-300" colspan="2">{{ deposito.bank_deposito }}</td>
								</tr>
								<tr class="odd:bg-gray-50">
									<td class="px-4 py-2 font-semibold border border-gray-300" colspan="2">Rate:</td>
									<td class="px-4 py-2 border border-gray-300" colspan="2">{{ deposito.rate }}</td>
								</tr>
								<tr class="odd:bg-gray-50">
									<td class="px-4 py-2 font-semibold border border-gray-300" colspan="2">Perkiraan Keuntungan:</td>
									<td class="px-4 py-2 border border-gray-300" colspan="2">{{ deposito.estimated_interest }}</td>
								</tr>
								<tr class="odd:bg-gray-50">
									<td class="px-4 py-2 font-semibold border border-gray-300" colspan="2">Perkiraan Total Keuntungan:</td>
									<td class="px-4 py-2 border border-gray-300" colspan="2">{{ deposito.estimated_value }}</td>
								</tr>
								<tr class="odd:bg-gray-50">
									<td class="px-4 py-2 font-semibold border border-gray-300" colspan="2">Tanggal Penempatan:</td>
									<td class="px-4 py-2 border border-gray-300" colspan="2">{{ deposito.tanggal_penempatan }}</td>
								</tr>
								<tr class="odd:bg-gray-50">
									<td class="px-4 py-2 font-semibold border border-gray-300" colspan="2">Tanggal Jatuh Tempo:</td>
									<td class="px-4 py-2 border border-gray-300" colspan="2">{{ deposito.tanggal_jatuh_tempo }}</td>
								</tr>
								<tr class="odd:bg-gray-50">
									<td class="px-4 py-2 font-semibold border border-gray-300" colspan="2">Settlement Status:</td>
									<td class="px-4 py-2 border border-gray-300" colspan="2">{{ deposito.settlement_status }}</td>
								</tr>
							</tbody>
							<!-- Settlement Status -->
							<thead>
								<tr class="bg-gray-200">
									<th class="px-4 py-2 text-left border border-gray-300" colspan="4">
										<h3 class="text-lg font-semibold">Settlement Status</h3>
									</th>
								</tr>
							</thead>
							<thead>
								<tr class="bg-gray-100">
									<th class="px-4 py-2 text-left border border-gray-300">
										<h5 class="text-base font-semibold">Nama</h5>
									</th>
									<th class="px-4 py-2 text-left border border-gray-300">
										<h5 class="text-base font-semibold">Jabatan</h5>
									</th>
									<th class="px-4 py-2 text-left border border-gray-300">
										<h5 class="text-base font-semibold">Approval Status</h5>
									</th>
									<th class="px-4 py-2 text-left border border-gray-300">
									</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="(person, index) in settlementProcess" :key="index" class="odd:bg-gray-50">
									<td class="px-4 py-2 border border-gray-300">{{ person.approver }}</td>
									<td class="px-4 py-2 border border-gray-300 uppercase">{{ person.role }} {{ person.unit_bisnis }}</td>
									<td class="px-4 py-2 border border-gray-300">
										<span :class="{
											'text-yellow-500': person.settlement_process_status === 'Menunggu Persetujuan',
											'text-green-500': person.settlement_process_status === 'Approved',
											'text-red-500': person.settlement_process_status === 'Rejected'
										}">{{ person.settlement_process_status }}</span>
									</td>
									<td class="px-4 py-2 border border-gray-300">
										<div v-if="showApprovalButtons(person)">
											<Button 
												label="Approve"
												icon="pi pi-check"
												class="p-button p-button-outlined p-button-primary mr-2"
												@click="openDialog(person,'approve')"
											/>

											<Button 
												label="Reject" 
												icon="pi pi-times"
												class="p-button p-button-outlined p-button-danger"
												@click="openDialog(person,'reject')"
											/>
										</div>
										<div v-else>
											<span v-if="person.settlement_process_status !== 'Menunggu Persetujuan'" :class="{
												'text-yellow-500': person.settlement_process_status === 'Menunggu Persetujuan',
												'text-green-500': person.settlement_process_status === 'Approved',
												'text-red-500': person.settlement_process_status === 'Rejected'
											}">{{ person.settlement_process_status }} by: {{ person.approvedBy }} at {{ person.updated_at }}</span>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
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