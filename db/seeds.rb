User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# 動画URL投稿
users = User.order(:created_at).take(5)
iframes = [
  '<iframe width="560" height="315" src="https://www.youtube.com/embed/lGkPU44Zr9g" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>',
  '<iframe width="560" height="315" src="https://www.youtube.com/embed/qvxNjTilGL0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>',
  '<iframe width="560" height="315" src="https://www.youtube.com/embed/iVEad8FnLPU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
]
iframes.each do |iframe|
  users.each_with_index { |user,i| user.music_posts.create!(iframe: iframe, title: "どうぶつの森オーケストラ-#{i}") }
end

# フォロー関係
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
