class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :genre_id
      t.string :title
      t.text :body

      t.timestamps
    end
    add_index :posts, :title
  end
end
