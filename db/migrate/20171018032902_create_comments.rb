class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :id_parent, null: true
      t.references :travel, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
