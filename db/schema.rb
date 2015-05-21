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

ActiveRecord::Schema.define(version: 20150414134051) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "controls", force: :cascade do |t|
    t.text     "family"
    t.text     "number"
    t.text     "title"
    t.text     "priority"
    t.boolean  "is_baseline_impact_low"
    t.boolean  "is_baseline_impact_moderate"
    t.boolean  "is_baseline_impact_high"
    t.boolean  "is_withdrawn"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "is_enhancement"
  end

  create_table "families", force: :cascade do |t|
    t.text     "name"
    t.text     "acronym"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "family_type"
  end

  create_table "references", force: :cascade do |t|
    t.string   "number"
    t.text     "reference"
    t.string   "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statements", force: :cascade do |t|
    t.string   "number"
    t.text     "description"
    t.boolean  "is_odv"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "control_number"
  end

  create_table "supplements", force: :cascade do |t|
    t.string   "number"
    t.text     "description"
    t.text     "related"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "withdrawls", force: :cascade do |t|
    t.string   "number"
    t.string   "incorporated_into"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
