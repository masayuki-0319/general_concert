import Vue          from 'vue/dist/vue.esm.js'
import VueRouter    from 'vue-router'
import Home         from './pages/static_pages/Home.vue'
import About        from './pages/static_pages/About.vue'
import Tos          from './pages/static_pages/Tos.vue'
import UsersSignup  from './pages/users/Signup.vue'
import UsersSignin  from './pages/users/Signin.vue'

Vue.use(VueRouter)

const routes = [
  { path: '/',        component: Home },
  { path: '/about',   component: About },
  { path: '/tos',     component: Tos },
  { path: '/signup',  component: UsersSignup },
  { path: '/login',   component: UsersSignin },
];

export default new VueRouter({ routes });
