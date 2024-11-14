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

ActiveRecord::Schema[7.2].define(version: 2024_11_12_044641) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "entities", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.bigint "parent_id"
    t.string "password_digest"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pin_digest"
    t.index ["parent_id"], name: "index_entities_on_parent_id"
    t.index ["type"], name: "index_entities_on_type"
    t.index ["username"], name: "index_entities_on_username", unique: true
  end

  create_table "entity_tokens", force: :cascade do |t|
    t.string "token"
    t.datetime "expired_at"
    t.bigint "entity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_id"], name: "index_entity_tokens_on_entity_id"
  end

  create_table "stock_details", force: :cascade do |t|
    t.string "symbol"
    t.string "identifier"
    t.float "open"
    t.float "day_high"
    t.float "day_low"
    t.float "last_price"
    t.float "previous_close"
    t.float "change"
    t.float "p_change"
    t.float "year_high"
    t.float "year_low"
    t.float "total_traded_value"
    t.float "total_traded_volume"
    t.datetime "last_update_time"
    t.float "per_change_30d"
    t.float "per_change_365d"
    t.bigint "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_updated_time"
    t.index ["stock_id"], name: "index_stock_details_on_stock_id"
  end

  create_table "team_details", force: :cascade do |t|
    t.string "code"
    t.string "email"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_details_on_team_id"
  end

  create_table "user_details", force: :cascade do |t|
    t.string "phone_number"
    t.string "email"
    t.date "birthdate"
    t.string "birthplace"
    t.text "address"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_details_on_user_id"
  end

  create_table "wallet_transactions", force: :cascade do |t|
    t.string "creditable_type"
    t.bigint "creditable_id"
    t.string "debitable_type"
    t.bigint "debitable_id"
    t.integer "amount", null: false
    t.date "transaction_date", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by"], name: "index_wallet_transactions_on_created_by"
    t.index ["creditable_type", "creditable_id"], name: "index_wallet_transactions_on_creditable"
    t.index ["debitable_type", "debitable_id"], name: "index_wallet_transactions_on_debitable"
    t.index ["number"], name: "index_wallet_transactions_on_number", unique: true
    t.index ["transaction_date"], name: "index_wallet_transactions_on_transaction_date"
    t.index ["updated_by"], name: "index_wallet_transactions_on_updated_by"
  end
end
