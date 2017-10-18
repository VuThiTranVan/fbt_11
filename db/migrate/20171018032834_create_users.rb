class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password
      t.string :role
      t.string :address
      t.string :telphone
      t.string :avata

      t.timestamps
    end
  end
end
