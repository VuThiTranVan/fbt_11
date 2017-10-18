class CreateTours < ActiveRecord::Migration[5.1]
  def change
    create_table :tours do |t|
      t.references :travel, index: true, foreign_key: true
      t.string :tour_duration
      t.datetime :date_start
      t.datetime :date_end
      t.float :price

      t.timestamps
    end
  end
end
