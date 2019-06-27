class CreateMusicLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :music_likes do |t|
      t.integer :liker_id
      t.references :music_post, foreign_key: true

      t.timestamps
    end
    add_index :music_likes, [:liker_id, :music_post_id], unique: true
  end
end
