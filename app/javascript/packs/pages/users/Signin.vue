<template>
  <div class="jumbotron">
    <h1>ログイン（未完成）</h1>
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <form id="user-form" action="/login" method="post">

          <label for="user_email">電子メール</label>
          <input class="form-control" type="email" name="user[email]" id="user_email" v-model="email">

          <label for="user_password">パスワード</label>
          <input class="form-control" type="password" name="user[password]" id="user_password" v-model="password">

          <label class="checkbox inline" for="session_remember_me">
            <input name="session[remember_me]" type="hidden" value="0">
            <input type="checkbox" value="1" name="session[remember_me]" id="session_remember_me">
            <span>このパソコンにログイン情報を保存する。</span>
          </label>

          <input type="submit" name="commit" value="アカウント作成" class="btn btn-primary" data-disable-with="アカウント作成">
        </form>
        <p>未登録なら…<router-link to="/signup">登録しましょう!</router-link></p>
      </div>
    </div>
  </div>
</template>

<script></script>

<style scoped></style>
