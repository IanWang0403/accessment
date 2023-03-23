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

ActiveRecord::Schema[7.0].define(version: 2023_03_23_102750) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guests", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_guests_on_email", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.string "reservation_code", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "nights", null: false
    t.bigint "guest_id", null: false
    t.integer "guests", null: false
    t.integer "adults", null: false
    t.integer "children", null: false
    t.integer "infants", null: false
    t.string "status", null: false
    t.string "currency", null: false
    t.money "payout_price", scale: 2, null: false
    t.money "security_price", scale: 2, null: false
    t.money "total_price", scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
    t.index ["reservation_code"], name: "index_reservations_on_reservation_code", unique: true
  end

  create_table "webhook_events", force: :cascade do |t|
    t.string "event_type"
    t.jsonb "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "reservations", "guests"
end
