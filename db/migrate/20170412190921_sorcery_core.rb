class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email, null: false
      t.string  :name, null: false
      t.integer :role, null: false, default: 1 # Enum
      t.string  :crypted_password
      t.string  :salt

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
