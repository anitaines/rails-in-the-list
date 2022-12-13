class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :amount
      t.text :comment
      t.references :list, null: false, foreign_key: true
      t.boolean :purchased, default: false
      t.datetime :purchased_date
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
