class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.references :travel, foreign_key: true
      t.references :user, foreign_key: true
      t.float :star_number

      t.timestamps
    end
    add_index :ratings, [:travel_id, :user_id], unique: true
  end
end
