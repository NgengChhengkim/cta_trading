# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160624150241) do

  create_table "brands", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "guests", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "email",        limit: 255
    t.string   "address",      limit: 255
    t.string   "phone_number", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "image",       limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "product_carts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "product_id", limit: 4
    t.integer  "quantity",   limit: 4, default: 1
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "product_carts", ["product_id"], name: "index_product_carts_on_product_id", using: :btree
  add_index "product_carts", ["user_id"], name: "index_product_carts_on_user_id", using: :btree

  create_table "product_orders", force: :cascade do |t|
    t.integer  "customer_id",   limit: 4
    t.string   "customer_type", limit: 255
    t.integer  "quantity",      limit: 4
    t.integer  "product_id",    limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "product_orders", ["product_id"], name: "index_product_orders_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "code",              limit: 255
    t.float    "weight",            limit: 24
    t.integer  "number_per_case",   limit: 4
    t.decimal  "whole_sale_price",                precision: 10
    t.decimal  "retail_sale_price",               precision: 10
    t.decimal  "price_per_case",                  precision: 10
    t.float    "discount",          limit: 24
    t.decimal  "discount_price",                  precision: 10
    t.string   "smell",             limit: 255
    t.text     "description",       limit: 65535
    t.text     "usage",             limit: 65535
    t.integer  "category_id",       limit: 4
    t.integer  "supplier_id",       limit: 4
    t.integer  "brand_id",          limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "products", ["brand_id"], name: "index_products_on_brand_id", using: :btree
  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["supplier_id"], name: "index_products_on_supplier_id", using: :btree

  create_table "promotions", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "content",    limit: 255
    t.string   "image",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "slide_images", force: :cascade do |t|
    t.string   "image",       limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "country_id",  limit: 4
  end

  add_index "suppliers", ["country_id"], name: "index_suppliers_on_country_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.integer  "role",                   limit: 4,   default: 2
    t.string   "address",                limit: 255
    t.string   "phone_number",           limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "product_carts", "products"
  add_foreign_key "product_carts", "users"
  add_foreign_key "product_orders", "products"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "suppliers"
  add_foreign_key "suppliers", "countries"
end
