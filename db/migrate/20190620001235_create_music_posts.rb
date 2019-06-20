class CreateMusicPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :music_posts do |t|
      t.text :iframe
      t.string :title
      t.references :user, foreign_key: true
      t.string :references

      t.timestamps
    end
    add_index :music_posts, [:user_id, :created_at]
  end
end
