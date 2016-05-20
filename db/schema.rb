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

ActiveRecord::Schema.define(version: 20160520181727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "email_addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "email_address"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "organization_id"
    t.boolean  "confirmed"
  end

  add_index "email_addresses", ["organization_id"], name: "index_email_addresses_on_organization_id", using: :btree
  add_index "email_addresses", ["user_id"], name: "index_email_addresses_on_user_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.decimal  "cost"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "items", ["order_id"], name: "index_items_on_order_id", using: :btree
  add_index "items", ["user_id"], name: "index_items_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "organization_id"
    t.datetime "date_ordered"
    t.datetime "expiration"
    t.integer  "admin_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "description"
    t.decimal  "minimum_cost"
  end

  add_index "orders", ["admin_id"], name: "index_orders_on_admin_id", using: :btree
  add_index "orders", ["organization_id"], name: "index_orders_on_organization_id", using: :btree
  add_index "orders", ["restaurant_id"], name: "index_orders_on_restaurant_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "domain_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "address"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_orders", ["order_id"], name: "index_user_orders_on_order_id", using: :btree
  add_index "user_orders", ["user_id"], name: "index_user_orders_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "name"
    t.string   "venmo"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "email_confirmed"
    t.string   "confirm_token"
  end

end
