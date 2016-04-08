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

ActiveRecord::Schema.define(version: 20160408010913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notices", force: :cascade do |t|
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "name"
    t.string   "address"
    t.string   "incident_location"
    t.datetime "incident_occurred_at"
    t.text     "incident_description"
    t.boolean  "officer_injured_me"
    t.string   "officer_injured_me_how"
    t.boolean  "officer_threatened_injury"
    t.boolean  "officer_searched"
    t.string   "officer_searched_how"
    t.boolean  "officer_took_property"
    t.text     "officer_took_what"
    t.boolean  "officer_damaged_property"
    t.text     "officer_damaged_what"
    t.boolean  "officer_destroyed_property"
    t.text     "officer_destroyed_what"
    t.boolean  "officer_arrested_no_probable_cause"
    t.boolean  "officer_refused_medical_attention"
    t.boolean  "none_of_the_above"
    t.integer  "number_officers"
    t.boolean  "damages_physical_pain"
    t.boolean  "damages_medical_attention"
    t.boolean  "damages_miss_work"
    t.boolean  "damages_embarrassment"
    t.boolean  "damages_property"
    t.boolean  "damages_emotional_distress"
    t.integer  "screener_id"
  end

  add_index "notices", ["screener_id"], name: "index_notices_on_screener_id", using: :btree

  create_table "officers", force: :cascade do |t|
    t.string   "name"
    t.string   "badge_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "notice_id"
  end

  add_index "officers", ["notice_id"], name: "index_officers_on_notice_id", using: :btree

  create_table "outputs", force: :cascade do |t|
    t.integer  "notice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "physical_injuries", force: :cascade do |t|
    t.integer  "notice_id"
    t.boolean  "beaten_with_object"
    t.boolean  "choked"
    t.boolean  "pepper_sprayed"
    t.boolean  "tasered"
    t.boolean  "attacked_by_police_animal"
    t.boolean  "hit_by_police_vehicle"
    t.boolean  "handcuffs_too_tight"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "physical_force"
    t.boolean  "other"
    t.text     "other_description"
  end

  add_index "physical_injuries", ["notice_id"], name: "index_physical_injuries_on_notice_id", using: :btree

  create_table "screeners", force: :cascade do |t|
    t.boolean  "harmed_mistreated"
    t.datetime "incident_occurred_on"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "searched_objects", force: :cascade do |t|
    t.integer  "notice_id"
    t.boolean  "vehicle"
    t.boolean  "bag"
    t.boolean  "pockets"
    t.boolean  "home"
    t.boolean  "other"
    t.text     "other_details"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "searched_objects", ["notice_id"], name: "index_searched_objects_on_notice_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "notices", "screeners"
  add_foreign_key "officers", "notices"
  add_foreign_key "outputs", "notices"
  add_foreign_key "physical_injuries", "notices"
  add_foreign_key "searched_objects", "notices"
end
