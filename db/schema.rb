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

ActiveRecord::Schema.define(version: 2015_11_23_213538) do

  create_table "controls", force: :cascade do |t|
    t.text "family_name", limit: 65535
    t.text "number", limit: 65535
    t.text "title", limit: 65535
    t.text "priority", limit: 65535
    t.boolean "is_baseline_impact_low", limit: 1
    t.boolean "is_baseline_impact_moderate", limit: 1
    t.boolean "is_baseline_impact_high", limit: 1
    t.boolean "is_withdrawn", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_enhancement", limit: 1
    t.integer "parent_id", limit: 4
    t.integer "family_id", limit: 4
  end

  create_table "families", force: :cascade do |t|
    t.text "name", limit: 65535
    t.text "acronym", limit: 65535
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "family_type", limit: 65535
  end

  create_table "references", force: :cascade do |t|
    t.text "reference", limit: 65535
    t.string "link", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "control_id", limit: 4
  end

  create_table "statements", force: :cascade do |t|
    t.string "number", limit: 255
    t.text "description", limit: 65535
    t.boolean "is_odv", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "control_id", limit: 65535
  end

  create_table "supplements", force: :cascade do |t|
    t.text "description", limit: 65535
    t.text "related", limit: 65535
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "control_id", limit: 4
  end

  create_table "withdrawals", force: :cascade do |t|
    t.string "incorporated_into", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "control_id", limit: 4
  end

end
