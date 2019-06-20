FactoryBot.define do
  factory :music_post, class: 'MusicPost' do
    iframe { '<iframe width="560" height="315" src="https://www.youtube.com/embed/daS06STpEx4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>' }
    sequence(:title) { |n| "#{n}-任天堂メドレー" }
    association :user
  end
end
