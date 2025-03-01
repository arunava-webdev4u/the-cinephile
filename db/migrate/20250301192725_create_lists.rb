class CreateLists < ActiveRecord::Migration[8.0]
  def change
    create_table :lists do |t|
      t.string :name, null: false
      t.text :description
      t.string :type, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
