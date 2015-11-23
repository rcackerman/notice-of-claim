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

ActiveRecord::Schema.define(version: 20151123183253) do

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
  end

  create_table "officers", force: :cascade do |t|
    t.string   "name"
    t.string   "badge_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "screeners", force: :cascade do |t|
    t.boolean  "harmed_mistreated"
    t.datetime "incident_occurred_on"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
