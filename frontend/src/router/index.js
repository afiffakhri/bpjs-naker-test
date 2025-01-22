import { createRouter, createWebHistory } from 'vue-router';
import Login from '@/pages/Login.vue';
import DashboardLayout from '@/components/layout/DashboardLayout.vue';
import Dashboard from '@/pages/Dashboard.vue';
import User from '@/pages/user/User.vue';
import Role from '@/pages/role/Role.vue';
import RoleForm from '@/pages/role/RoleForm.vue';
import Deposito from '@/pages/deposito/Deposito.vue';
import DepositoForm from '@/pages/deposito/DepositoForm.vue';
import DetailDeposito from '@/pages/deposito/DetailDeposito.vue'

const isLoggedIn = () => {
	return localStorage.getItem('token') !== null;
};

const routes = [
	{
		path: '/',
		redirect: '/login',
	},
	{
		path: '/login',
		name: 'Login',
		component: Login,
	},
	{
		path: '/',
		component: DashboardLayout,
		meta: { requiresAuth: true },
		children: [
			{ path: '/dashboard', component: Dashboard },
			{ path: '/users', component: User },
			{ path: '/roles', component: Role },
			{ path: '/roles/create', component: RoleForm },
			{ path: '/roles/edit/:id_role', component: RoleForm },
			{ path: '/depositos', component: Deposito },
			{ path: '/depositos/create', component: DepositoForm },
			{ path: '/depositos/:id_deposito', component: DetailDeposito },
		],
	}
];

const router = createRouter({
	history: createWebHistory(),
	routes,
});

router.beforeEach((to, from, next) => {
	if (to.meta.requiresAuth && !isLoggedIn()) {
		next({ path: '/' });
	} else {
		next();
	}
});

export default router;