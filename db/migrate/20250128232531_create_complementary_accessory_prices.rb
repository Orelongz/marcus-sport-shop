class CreateComplementaryAccessoryPrices < ActiveRecord::Migration[7.2]
  def change
    create_table :complementary_accessory_prices do |t|
      t.bigint :accessory_id
      t.bigint :complementary_accessory_id
      t.bigint :price, comment: "Price of the complemenatry accessory when combined with an accessory"

      t.timestamps
    end

    add_foreign_key :complementary_accessory_prices, :accessories, on_delete: :cascade
  end
end
