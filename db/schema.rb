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

ActiveRecord::Schema.define(version: 20190611045048) do

  create_table "codes", force: :cascade do |t|
    t.text "code"
    t.text "explanation"
    t.text "ensihoito"
  end

  create_table "events", force: :cascade do |t|
    t.integer  "code_id"
    t.integer  "location_id"
    t.integer  "state_id"
    t.integer  "unit_id"
    t.boolean  "from_hq"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "operation_id"
  end

  create_table "locations", force: :cascade do |t|
    t.text    "location"
    t.text    "shortcode"
    t.integer "type_id"
    t.integer "x"
    t.integer "y"
    t.float   "lat"
    t.float   "lon"
  end

  create_table "operations", force: :cascade do |t|
    t.text    "name"
    t.text    "latitude"
    t.text    "longitude"
    t.text    "zoom"
    t.text    "width"
    t.text    "height"
    t.text    "postfix"
    t.boolean "current"
    t.text    "smsurl"
    t.text    "tetraport"
    t.text    "map"
    t.string  "smstoken"
    t.string  "smsfrom"
  end

  create_table "states", force: :cascade do |t|
    t.text "state"
    t.text "explanation"
  end

  create_table "types", force: :cascade do |t|
    t.text "name"
  end

  create_table "units", force: :cascade do |t|
    t.text     "unit"
    t.integer  "state_id"
    t.integer  "location_id"
    t.integer  "listorder",   default: 1
    t.text     "phone"
    t.text     "imei"
    t.float    "lat"
    t.float    "lon"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "car"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "operation_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
