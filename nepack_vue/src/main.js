import { createApp } from 'vue'
import { createPinia } from 'pinia'
import './assets/style.css'
import App from './App.vue'
import axios from 'axios';

import router from './router'
const pinia = createPinia()
createApp(App).use(pinia).use(router).mount('#app')
    

