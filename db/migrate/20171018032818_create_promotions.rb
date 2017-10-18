class CreatePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :promotions do |t|
      t.datetime :date_start
      t.datetime :date_end
      t.text :name
      t.text :description
      t.float :discus_percent
      t.integer :flg_del

      t.timestamps
    end
  end
end
