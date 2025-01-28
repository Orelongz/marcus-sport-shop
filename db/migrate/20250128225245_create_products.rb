class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.bigint :product_type_id
      t.integer :price, comment: "Price in cents"
      t.boolean :out_of_stock, default: false

      t.timestamps
    end

    add_index :products, %i[product_type_id out_of_stock]
    add_foreign_key :products, :product_types, on_delete: :restrict
  end
end
