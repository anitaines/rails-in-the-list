class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.string :name, null: false
      t.float :latitude
      t.float :longitude
      t.text :comments
      t.string :status

      t.timestamps
    end
  end
end
