class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :comment, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
    add_index :likes, [:comment_id, :user_id], unique: true
  end
end
