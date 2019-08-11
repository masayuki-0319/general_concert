import Vue        from 'vue/dist/vue.esm.js'
import VueRouter  from 'vue-router'
import Page1      from './pages/Page1.vue'
import Page2      from './pages/Page2.vue'
import About      from './pages/static_pages/About.vue'
import Tos        from './pages/static_pages/Tos.vue'

Vue.use(VueRouter)

const routes = [
  { path: '/',        component: Page1 },
  { path: '/page2',   component: Page2 },
  { path: '/about',   component: About },
  { path: '/tos',     component: Tos }
];

export default new VueRouter({ routes });
