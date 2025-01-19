<script setup>
import { ref, computed } from 'vue';
import Sidebar from 'primevue/sidebar';
import Menu from 'primevue/menu';
import Button from 'primevue/button';
import { useRouter } from 'vue-router';

const sidebarVisible = ref(false);
const router = useRouter();

const user = JSON.parse(localStorage.getItem('user'));

const menuItems = [
	{ label: 'Dashboard', icon: 'pi pi-home', to: '/dashboard' },
	{ label: 'User Management', icon: 'pi pi-users', to: '/users', role: 'admin' },
	{ label: 'Deposito Management', icon: 'pi pi-money-bill', to: '/depositos' }
];

const filteredMenuItems = computed(() => {
	if (user.id_role === 1) {
		return menuItems;
	}

	return menuItems.filter(item => item.role !== 'admin');
});

const toggleSidebar = () => {
	sidebarVisible.value = !sidebarVisible.value;
};

const handleLogout = () => {
	localStorage.removeItem('token');
	localStorage.removeItem('user');
	router.push('/');
};

const pageTitle = computed(() => {
	const routeName = router.currentRoute.value.name;
	switch (routeName) {
		case 'Dashboard':
			return 'Dashboard';
		case 'Users':
			return 'User Management';
		case 'Depositos':
			return 'Deposito Management';
		default:
			return 'Admin Dashboard';
	}
});
</script>

<template>
	<div class="flex h-screen bg-gray-100">
		<div class="hidden lg:block w-64 bg-gray-800 text-white p-4 h-full">
			<h2 class="text-xl mb-6">Hi, {{user.name}}{{user.unit_bisnis ? ' - (' + user.unit_bisnis.unit_bisnis + ')' : ''}}{{user.role ? ' - (' + user.role.role + ')' : ''}}</h2>
			<Menu :model="filteredMenuItems">
				<template #item="{ item, props }">
					<router-link v-if="item.to" v-slot="{ href, navigate }" :to="item.to" custom>
						<a v-ripple :href="href" v-bind="props.action" @click="navigate">
							<span :class="item.icon" />
							<span class="ml-2">{{ item.label }}</span>
						</a>
					</router-link>
					<a v-else v-ripple :href="item.url" :target="item.target" v-bind="props.action">
						<span :class="item.icon" />
						<span class="ml-2">{{ item.label }}</span>
					</a>
				</template>
			</Menu>
		</div>

		<!-- Main Content Area -->
		<div class="flex-1 flex flex-col h-full">
			<!-- Top Bar -->
			<div class="bg-white shadow-md p-4 flex justify-between items-center">
				<!-- Hamburger button for smaller screens -->
				<button
					class="lg:hidden p-2 rounded-md text-gray-700 hover:text-gray-900"
					@click="toggleSidebar"
				>
					<i class="pi pi-bars text-xl"></i>
				</button>
				<h1 class="text-xl font-semibold">Dashboard</h1>
				<!-- Logout Button -->
				<Button
					icon="pi pi-sign-out"
					label="Logout"
					class="p-button-rounded p-button-danger"
					@click="handleLogout"
				/>
			</div>

			<!-- Main Content -->
			<div class="p-4 flex-1 overflow-auto">
				<!-- Dynamic Content (based on the active route) -->
				<router-view />
			</div>
		</div>

		<!-- Sidebar on small screens (Responsive) -->
		<div
			v-show="sidebarVisible"
			class="lg:hidden fixed inset-0 bg-gray-800 bg-opacity-75 z-10"
			@click="toggleSidebar"
		>
			<div class="bg-gray-800 text-white w-64 p-4 h-full">
				<h2 class="text-xl mb-6">Admin Dashboard</h2>
				<Menu :model="filteredMenuItems">
					<template #item="{ item, props }">
						<router-link v-if="item.to" v-slot="{ href, navigate }" :to="item.to" custom>
							<a v-ripple :href="href" v-bind="props.action" @click="navigate">
								<span :class="item.icon" />
								<span class="ml-2">{{ item.label }}</span>
							</a>
						</router-link>
						<a v-else v-ripple :href="item.url" :target="item.target" v-bind="props.action">
							<span :class="item.icon" />
							<span class="ml-2">{{ item.label }}</span>
						</a>
					</template>
				</Menu>
			</div>
		</div>
	</div>
</template>