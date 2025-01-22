import { createApp } from 'vue'
import App from './App.vue';
import router from './router';
import axios from 'axios';

import Aura from '@primevue/themes/aura';
import PrimeVue from 'primevue/config';
import ToastService from 'primevue/toastservice';

import 'primeicons/primeicons.css';
import './assets/main.css'

const app = createApp(App);

app.use(router);
app.use(ToastService);
app.use(PrimeVue, {
    theme: {
        preset: Aura,
        options: {
            darkModeSelector: '.app-dark'
        }
    }
});
app.mount('#app');