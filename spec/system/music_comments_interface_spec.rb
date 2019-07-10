require 'rails_helper'

RSpec.feature 'MusicCommentsInterface', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:other_music) { create(:music_post, user_id: other_user.id) }
  let!(:comment) { create(:music_comment, commenter_id: user.id, music_post_id: other_music.id) }

  background do
    log_in_as user
    visit music_post_path(other_music)
  end

  scenario '投稿動画にコメントする。' do
    fill_in 'music_comment_comment', with: 'TestComment'
    click_on 'コメント投稿'
    expect(page).to have_content 'TestComment'
    expect(page).to have_content 'コメント削除'
  end

  scenario 'コメントを削除する。' do
    expect(page).to have_content comment.comment
    click_on 'コメント削除'
    expect(page).not_to have_content comment.comment
  end
end
