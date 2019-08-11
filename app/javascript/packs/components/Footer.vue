<template>
  <footer>
    <span>General Concert New {{displayDate}}</span>
    <nav>
      <ul>
        <li><router-link to='/'>ホーム</router-link></li>
        <li><router-link to='/about'>アプリ概要</router-link></li>
        <li><router-link to='/tos'>利用規約</router-link></li>
      </ul>
    </nav>
  </footer>
</template>

<script>
  import moment from 'moment';
  export default {
    name: 'global_footer',
    props: {
      msg: String
    },
    computed: {
      displayDate: function() {
        return moment(new Date()).format('YYYY');
      },
    },
  }
</script>

<style scoped>
  margin-top: 45px;
  padding-top: 5px;
  border-top: 1px solid $gray-medium-light;
  color: black;
  a {
    color: $gray;
    background-color: rgba(229, 229, 229, 0.5);
    &:hover {
      color: black;
    }
  }
  span {
    float: left;
    background-color: rgba(229, 229, 229, 0.5);
  }
  ul {
    float: right;
    list-style: none;
    li {
      float: left;
      margin-left: 15px;
    }
  }
</style>
