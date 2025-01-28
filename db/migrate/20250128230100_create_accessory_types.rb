class CreateAccessoryTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :accessory_types do |t|
      t.string :name
      t.belongs_to :product_type

      t.timestamps
    end

    add_index :accessory_types, :name, unique: true
    add_foreign_key :accessory_types, :product_types, on_delete: :restrict
  end
end
