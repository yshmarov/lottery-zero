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

ActiveRecord::Schema[8.0].define(version: 2020_12_19_171122) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bets", force: :cascade do |t|
    t.integer "weight", default: 0, null: false
    t.bigint "roulette_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["roulette_id"], name: "index_bets_on_roulette_id"
    t.index ["user_id"], name: "index_bets_on_user_id"
  end

  create_table "charges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_charges_on_user_id"
  end

  create_table "roulettes", force: :cascade do |t|
    t.integer "shares_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shares_taken", default: 0, null: false
    t.integer "shares_available", default: 0, null: false
    t.integer "percent_left", default: 0, null: false
    t.integer "bets_count", default: 0, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_roulettes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "balance", default: 0, null: false
    t.integer "charges_count", default: 0, null: false
    t.integer "bets_count", default: 0, null: false
    t.integer "charges_sum", default: 0, null: false
    t.integer "bets_sum", default: 0, null: false
    t.integer "roulettes_count", default: 0, null: false
    t.integer "shares_won", default: 0, null: false
    t.integer "leader_score", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bets", "roulettes"
  add_foreign_key "bets", "users"
  add_foreign_key "charges", "users"
  add_foreign_key "roulettes", "users"
end
