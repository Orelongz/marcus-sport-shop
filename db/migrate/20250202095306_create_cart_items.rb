class CreateCartItems < ActiveRecord::Migration[7.2]
  def change
    create_table :cart_items do |t|
      t.bigint :product_id
      t.bigint :cart_id

      t.timestamps
    end

    add_index :cart_items, %i[cart_id product_id]
  end
end
