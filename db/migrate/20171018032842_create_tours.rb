class CreateTours < ActiveRecord::Migration[5.1]
  def change
    create_table :tours do |t|
      t.references :travel, index: true, foreign_key: true
      t.datetime :date_start
      t.datetime :date_end

      t.timestamps
    end
  end
end
