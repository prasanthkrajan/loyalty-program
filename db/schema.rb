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

ActiveRecord::Schema.define(version: 2019_09_23_035035) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "merchants", force: :cascade do |t|
    t.string "full_name"
    t.string "nature_of_business"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "points_logs", force: :cascade do |t|
    t.integer "points_earned"
    t.bigint "user_id"
    t.date "valid_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "issued_by"
    t.index ["user_id"], name: "index_points_logs_on_user_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.string "reward_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["user_id"], name: "index_rewards_on_user_id"
  end

  create_table "user_merchant_transactions", force: :cascade do |t|
    t.string "currency"
    t.decimal "amount"
    t.bigint "merchant_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "index_user_merchant_transactions_on_merchant_id"
    t.index ["user_id"], name: "index_user_merchant_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "loyalty_tier"
    t.string "home_currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_of_birth"
  end

  add_foreign_key "points_logs", "merchants", column: "issued_by"
  add_foreign_key "points_logs", "users"
  add_foreign_key "rewards", "users"
  add_foreign_key "user_merchant_transactions", "merchants"
  add_foreign_key "user_merchant_transactions", "users"
end
