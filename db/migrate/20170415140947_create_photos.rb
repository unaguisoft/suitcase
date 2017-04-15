class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :image_uid, null: false
      t.string :image_name, null: false
      t.references :category, foreign_key: true, null: false

      t.timestamps
    end
  end
end
