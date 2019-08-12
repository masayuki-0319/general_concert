<template>
  <div class="center jumbotron">
    <h1 style="font-size:80px; color:red">未完成SPA</br>（ログイン前のみ実装）</h1>
    <h1>General Concert</h1>
    <div class="row">
      <div class="col-md-4 col-md-offset-4 btn-group-vertical center-inline" role="group" aria-label="積み重ねボタングループ">
        <a href="/signup" class="btn btn-lg btn-primary">今すぐ登録する！</a>
        <br />
        <a href="/login" class="btn btn-lg btn-success">通常ログイン</a>
        <br />
        <a href="/auth/facebook" class="btn btn-lg btn-social btn-facebook">
          <span class="fab fa-facebook-f"></span>Facebookでログイン
        </a>
        <a href="/auth/google" class="btn btn-lg btn-social btn-google">
          <span class="fab fa-google-plus-g"></span>Googleでログイン
        </a>
        <a href="/auth/github" class="btn btn-lg btn-social btn-github">
          <span class="fab fa-github"></span>Githubでログイン
        </a>
      </div>
    </div>
  </div>
</template>

<script></script>
<style scoped></style>
