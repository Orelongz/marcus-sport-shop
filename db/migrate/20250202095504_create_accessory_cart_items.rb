class CreateAccessoryCartItems < ActiveRecord::Migration[7.2]
  def change
    create_table :accessory_cart_items do |t|
      t.bigint :cart_item_id
      t.bigint :accessory_id

      t.timestamps
    end

    add_index :accessory_cart_items, %i[cart_item_id accessory_id]
  end
end
