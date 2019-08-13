<template>
  <div class="jumbotron">
    <h1>新規登録（未完成）</h1>
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <form id="user-form" action="/signup" method="post">

          <label for="user_name">名前</label>
          <input class="form-control" type="text" name="user[name]" id="user_name">

          <label for="user_email">電子メール</label>
          <input class="form-control" type="email" name="user[email]" id="user_email">

          <label for="user_password">パスワード</label>
          <input class="form-control" type="password" name="user[password]" id="user_password">

          <label for="user_password_confirmation">パスワード確認</label>
          <input class="form-control" type="password" name="user[password_confirmation]" id="user_password_confirmation">

          <input type="submit" name="commit" value="アカウント作成" class="btn btn-primary" data-disable-with="アカウント作成">
        </form>
      </div>
    </div>
  </div>
</template>

<script></script>

<style scoped></style>
