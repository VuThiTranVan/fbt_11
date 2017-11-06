class CreateBookTours < ActiveRecord::Migration[5.1]
  def change
    create_table :book_tours do |t|
      t.references :tour, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :number_person
      t.text :note
      t.integer :status, null: false, default: 0
      t.string :transaction_id
      t.datetime :purchased_date
      t.float :price
      t.float :total_price

      t.timestamps
    end
  end
end
