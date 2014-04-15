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

ActiveRecord::Schema.define(version: 20140414182636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "beds", force: true do |t|
    t.string   "name"
    t.string   "capacity"
    t.integer  "greenhouse_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "beds", ["greenhouse_id"], name: "index_beds_on_greenhouse_id", using: :btree
  add_index "beds", ["location_id"], name: "index_beds_on_location_id", using: :btree

  create_table "entries", force: true do |t|
    t.integer  "pots"
    t.integer  "stick_week"
    t.integer  "hang_week"
    t.integer  "finish_week"
    t.integer  "rating"
    t.integer  "status"
    t.integer  "plant_id"
    t.integer  "bed_id"
    t.integer  "greenhouse_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["bed_id"], name: "index_entries_on_bed_id", using: :btree
  add_index "entries", ["greenhouse_id"], name: "index_entries_on_greenhouse_id", using: :btree
  add_index "entries", ["location_id"], name: "index_entries_on_location_id", using: :btree
  add_index "entries", ["plant_id"], name: "index_entries_on_plant_id", using: :btree

  create_table "greenhouses", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "greenhouses", ["location_id"], name: "index_greenhouses_on_location_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plants", force: true do |t|
    t.string   "item_code"
    t.string   "description"
    t.text     "finishtime"
    t.text     "expiration"
    t.integer  "parent_plant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "zones", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "capacity"
    t.integer  "location_id"
    t.integer  "greenhouse_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zones", ["greenhouse_id"], name: "index_zones_on_greenhouse_id", using: :btree
  add_index "zones", ["location_id"], name: "index_zones_on_location_id", using: :btree

end
