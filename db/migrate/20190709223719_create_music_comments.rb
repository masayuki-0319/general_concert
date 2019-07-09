class CreateMusicComments < ActiveRecord::Migration[5.2]
  def change
    create_table :music_comments do |t|
      t.text :comment
      t.integer :commenter_id
      t.references :music_post, foreign_key: true

      t.timestamps
    end
  end
end
