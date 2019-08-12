import Vue        from 'vue/dist/vue.esm.js'
import VueRouter  from 'vue-router'
import Home       from './pages/static_pages/Home.vue'
import About      from './pages/static_pages/About.vue'
import Tos        from './pages/static_pages/Tos.vue'
import UsersNew   from './pages/users/New.vue'

Vue.use(VueRouter)

const routes = [
  { path: '/',        component: Home },
  { path: '/about',   component: About },
  { path: '/tos',     component: Tos },
  { path: '/signup',  component: UsersNew },
];

export default new VueRouter({ routes });
