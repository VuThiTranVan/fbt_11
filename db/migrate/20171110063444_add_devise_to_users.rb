class AddDeviseToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      # Database authenticatable
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      # Rememberable
      t.datetime :remember_created_at
    end
    add_index :users, :email, unique: true
  end
end
