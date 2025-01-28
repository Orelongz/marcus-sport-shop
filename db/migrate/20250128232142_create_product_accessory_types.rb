class CreateProductAccessoryTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :product_accessory_types do |t|
      t.bigint :product_id
      t.bigint :accessory_type_id

      t.timestamps
    end

    add_index :product_accessory_types, %i[product_id accessory_type_id], unique: true
  end
end
