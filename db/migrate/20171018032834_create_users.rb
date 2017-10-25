class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :role
      t.string :address
      t.string :telphone
      t.string :avatar

      t.timestamps
    end
  end
end
