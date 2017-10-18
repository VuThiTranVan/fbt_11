class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.string :name
      t.string :city
      t.text :description
      t.boolean :flg_del

      t.timestamps
    end
  end
end
