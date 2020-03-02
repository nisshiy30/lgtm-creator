class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :name
      t.binary :image
      t.string :filetype

      t.timestamps
    end
    add_index :posts, :user_id
  end
end
