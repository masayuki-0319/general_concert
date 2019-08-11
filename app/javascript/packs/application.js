import Vue from 'vue/dist/vue.esm.js'
import App from '../App.vue'
import Router from './router.js'

var app = new Vue({
  router: Router,
  el: '#app',
  render: h => h(App)
});
