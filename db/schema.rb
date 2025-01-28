# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_01_28_232531) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "accessory_type_id"
    t.boolean "out_of_stock", default: false
    t.integer "price", comment: "Price in cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accessory_type_id", "out_of_stock"], name: "index_accessories_on_accessory_type_id_and_out_of_stock"
  end

  create_table "accessory_types", force: :cascade do |t|
    t.string "name"
    t.bigint "product_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_accessory_types_on_name", unique: true
    t.index ["product_type_id"], name: "index_accessory_types_on_product_type_id"
  end

  create_table "complementary_accessory_constraints", force: :cascade do |t|
    t.bigint "accessory_id"
    t.bigint "complementary_accessory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "complementary_accessory_prices", force: :cascade do |t|
    t.bigint "accessory_id"
    t.bigint "complementary_accessory_id"
    t.bigint "price", comment: "Price of the complemenatry accessory when combined with an accessory"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_accessory_types", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "accessory_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "accessory_type_id"], name: "idx_on_product_id_accessory_type_id_eb43373e4e", unique: true
  end

  create_table "product_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_product_types_on_name", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "product_type_id"
    t.integer "price", comment: "Price in cents"
    t.boolean "out_of_stock", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_type_id", "out_of_stock"], name: "index_products_on_product_type_id_and_out_of_stock"
  end

  create_table "url_media_files", force: :cascade do |t|
    t.string "url"
    t.string "url_media_able_type"
    t.bigint "url_media_able_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url_media_able_type", "url_media_able_id"], name: "index_url_media_files_on_url_media_able"
  end

  add_foreign_key "accessories", "accessory_types", on_delete: :restrict
  add_foreign_key "accessory_types", "product_types", on_delete: :restrict
  add_foreign_key "complementary_accessory_constraints", "accessories", on_delete: :cascade
  add_foreign_key "complementary_accessory_prices", "accessories", on_delete: :cascade
  add_foreign_key "products", "product_types", on_delete: :restrict
end
