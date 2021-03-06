# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_18_034536) do

  create_table "stock_prices", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "open"
    t.float "high"
    t.float "low"
    t.float "close"
    t.float "adjusted_close"
    t.integer "volume"
    t.float "dividend_amount"
    t.float "split_coefficient"
    t.string "symbol"
  end

  create_table "time_series", force: :cascade do |t|
    t.string "closing_date"
    t.float "close"
    t.float "adjusted_close"
    t.string "symbol"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "stock_price_id"
    t.index ["stock_price_id"], name: "index_time_series_on_stock_price_id"
  end

  add_foreign_key "time_series", "stock_prices"
end
