class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.references :travel, index: true, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
