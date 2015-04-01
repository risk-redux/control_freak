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

ActiveRecord::Schema.define(version: 20150401191727) do

  create_table "controls", force: :cascade do |t|
    t.text     "family",                      limit: 65535
    t.text     "number",                      limit: 65535
    t.text     "title",                       limit: 65535
    t.text     "priority",                    limit: 65535
    t.boolean  "is_baseline_impact_low",      limit: 1
    t.boolean  "is_baseline_impact_moderate", limit: 1
    t.boolean  "is_baseline_impact_high",     limit: 1
    t.boolean  "is_withdrawn",                limit: 1
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "is_enhancement",              limit: 1
  end

  create_table "families", force: :cascade do |t|
    t.text     "name",        limit: 65535
    t.text     "acronym",     limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "family_type", limit: 65535
  end

  create_table "statements", force: :cascade do |t|
    t.string   "number",      limit: 255
    t.text     "description", limit: 65535
    t.boolean  "is_odv",      limit: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

end
