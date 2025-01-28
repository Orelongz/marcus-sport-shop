class CreateComplementaryAccessoryConstraints < ActiveRecord::Migration[7.2]
  def change
    create_table :complementary_accessory_constraints do |t|
      t.bigint :accessory_id
      t.bigint :complementary_accessory_id

      t.timestamps
    end

    add_foreign_key :complementary_accessory_constraints, :accessories, on_delete: :cascade
  end
end
