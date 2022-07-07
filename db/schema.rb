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

ActiveRecord::Schema[7.0].define(version: 2022_07_06_143621) do
  create_table "catalogs", force: :cascade do |t|
    t.string "uuid"
    t.text "title"
    t.string "version"
    t.string "oscal_version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controls", force: :cascade do |t|
    t.integer "family_id"
    t.integer "parent_id"
    t.text "number", limit: 65535
    t.text "sort_number", limit: 65535
    t.text "title", limit: 65535
    t.text "status", limit: 65535
    t.text "label", limit: 65535
    t.boolean "is_low"
    t.boolean "is_moderate"
    t.boolean "is_high"
    t.boolean "is_privacy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_controls_on_family_id"
    t.index ["parent_id"], name: "index_controls_on_parent_id"
  end

  create_table "families", force: :cascade do |t|
    t.text "acronym", limit: 65535
    t.text "title", limit: 65535
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", force: :cascade do |t|
    t.integer "control_id"
    t.text "href", limit: 65535
    t.text "link_text", limit: 65535
    t.text "link_type", limit: 65535
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["control_id"], name: "index_links_on_control_id"
  end

  create_table "parameters", force: :cascade do |t|
    t.integer "control_id"
    t.text "number", limit: 65535
    t.text "label", limit: 65535
    t.text "selection", limit: 65535
    t.text "how_many", limit: 65535
    t.text "choices", limit: 65535
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["control_id"], name: "index_parameters_on_control_id"
  end

  create_table "parts", force: :cascade do |t|
    t.integer "control_id"
    t.integer "parent_id"
    t.text "number", limit: 65535
    t.text "label", limit: 65535
    t.text "prepend", limit: 65535
    t.text "prose", limit: 65535
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["control_id"], name: "index_parts_on_control_id"
    t.index ["parent_id"], name: "index_parts_on_parent_id"
  end

  create_table "references", force: :cascade do |t|
    t.text "number", limit: 65535
    t.text "citation", limit: 65535
    t.text "href", limit: 65535
    t.text "uuid", limit: 65535
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
