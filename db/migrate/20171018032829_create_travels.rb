class CreateTravels < ActiveRecord::Migration[5.1]
  def change
    create_table :travels do |t|
      t.string :name
      t.boolean :flg_promotion, default: 0
      t.text :schedule
      t.text :description
      t.string :tour_duration
      t.text :note
      t.integer :id_place_from
      t.integer :id_place_to
      t.references :promotion, index: true, foreign_key: true

      t.timestamps
    end
  end
end
