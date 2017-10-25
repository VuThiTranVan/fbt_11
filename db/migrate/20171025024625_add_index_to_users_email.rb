class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :email, unique: true
    change_column :users, :role, :integer, null: false, default: 1
  end
end
