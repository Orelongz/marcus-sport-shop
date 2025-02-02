class CreateCarts < ActiveRecord::Migration[7.2]
  def change
    create_table :carts do |t|
      t.bigint :user_id

      t.timestamps
    end

    add_index :carts, :user_id
  end
end
