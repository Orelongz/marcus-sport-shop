class AddUniqueIndexOnComplementaryAccessoryPrice < ActiveRecord::Migration[7.2]
  def change
    add_index :complementary_accessory_prices, :complementary_accessory_id, unique: true
  end
end
