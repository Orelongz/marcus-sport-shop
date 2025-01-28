class CreateAccessories < ActiveRecord::Migration[7.2]
  def change
    create_table :accessories do |t|
      t.string :name
      t.text :description
      t.bigint :accessory_type_id
      t.boolean :out_of_stock, default: false
      t.integer :price, comment: "Price in cents"

      t.timestamps
    end

    add_index :accessories, %i[accessory_type_id out_of_stock]
    add_foreign_key :accessories, :accessory_types, on_delete: :restrict
  end
end
