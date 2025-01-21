<script setup>
import { ref, computed, onMounted } from 'vue';
import Button from 'primevue/button';
import { useRoute } from 'vue-router'

import { getDepositoByParams } from '../../api/deposito';
import { getUserById } from '../../api/user';
import { getBankById } from '../../api/bank';
import { getDepositoById } from '../../api/deposito';
import { getDepositoRateById } from '../../api/depositoRates';


const route = useRoute()
const depositoId = route.params.id_deposito

const deposito = ref()


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


const fetchDeposito = async () => {
  try {
    const data = await getDepositoById(depositoId);
    const depositoData = data.deposito.deposito
    const settlementData = data.deposito.settlement_process

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
      rate: rate,
      tanggal_penempatan: tanggal_penempatan,
      tanggal_jatuh_tempo: tanggal_jatuh_tempo,
      settlement_status: settlement_status
    }

    deposito.value = depositoWithDetails;
    console.log(deposito.value);
  } catch (error) {
    console.error('Error fetching depositos:', error)
  }
}


onMounted(() => {
  fetchDeposito()
})
</script>
<template>
  <div class="max-w-7xl mx-auto px-4 py-6 sm:px-6 lg:px-8">
    <div class="bg-white shadow-md rounded-lg p-6">
      <h2 class="text-2xl font-semibold text-gray-800 mb-4">Deposito Details</h2>
      
      <!-- Deposito Detail Section -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div>
          <p class="text-gray-600"><strong>Name:</strong> </p>
          <p class="text-gray-600"><strong>Deposit Value:</strong> </p>
          <p class="text-gray-600"><strong>Estimated Interest:</strong></p>
          <p class="text-gray-600"><strong>Estimated Value:</strong> </p>
        </div>
        
        <div>
          <p class="text-gray-600"><strong>Bank Name:</strong> </p>
          <p class="text-gray-600"><strong>Rate:</strong> </p>
          <p class="text-gray-600"><strong>User Name:</strong> </p>
          <p class="text-gray-600"><strong>Created At:</strong></p>
        </div>
      </div>

      <!-- Status Section -->
      <div class="mt-6">
        <h3 class="text-xl font-medium text-gray-700">Status</h3>
        <div class="mt-3">
          <p class="text-gray-600">
            <strong>Settlement Process:</strong>
          </p>
          <p class="text-gray-600"><strong>Settlement Status:</strong></p>
        </div>
      </div>

      <!-- Back Button -->
      <div class="mt-6">
        <router-link to="/depositos" class="text-blue-500 hover:text-blue-700">
          &larr; Back to Depositos List
        </router-link>
      </div>
    </div>
  </div>
</template>