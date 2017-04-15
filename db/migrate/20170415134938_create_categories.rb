class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :dimensions, null: false
      t.float :weight, null: false, default: 0.0
      t.integer :stock, null: false, default: 0
      t.float :insurance_percent, null: false, default: 0.0

      t.timestamps
    end
  end
end
