<template>
  <div class="center jumbotron">
    <h1 style="font-size:80px; color:red">上段は未完成SPA</h1>
    <h1>General Concert</h1>
    <div class="row">
      <div class="col-md-4 col-md-offset-4 btn-group-vertical center-inline" role="group" aria-label="積み重ねボタングループ">
        <router-link to='/signup' class="btn btn-lg btn-primary">今すぐ登録する！</router-link>
        <br />
        <%= link_to "通常ログイン", login_path, class: "btn btn-lg btn-success" %>
        <br />
        <%= link_to "/auth/facebook", class: "btn btn-lg btn-social btn-facebook" do %>
          <span class="fab fa-facebook-f"></span>Facebookでログイン
        <% end %>
        <%= link_to "/auth/google_oauth2", class: "btn btn-lg btn-social btn-google" do %>
          <span class="fab fa-google-plus-g"></span>Googleでログイン
        <% end %>
        <%= link_to "/auth/github", class: "btn btn-lg btn-social btn-github" do %>
          <span class="fab fa-github"></span>Githubでログイン
        <% end %>
      </div>
    </div>
  </div>
</template>

<script></script>
<style scoped></style>
