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

ActiveRecord::Schema.define(version: 2020_11_23_213538) do

  create_table "families", force: :cascade do |t|
    t.text "acronym", limit: 65535
    t.text "title", limit: 65535

    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controls", force: :cascade do |t|
    t.belongs_to :family

    t.references :parent

    t.text "number", limit: 65535
    t.text "sort_number", limit: 65535
    t.text "title", limit: 65535

    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parameters", force: :cascade do |t|
    t.belongs_to :control

    t.text "number", limit: 65535
    t.text "label", limit: 65535
    t.text "selection", limit: 65535
    t.text "alternatives", limit: 65535
    t.text "depends_on", limit: 65535

    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "references", force: :cascade do |t|
    t.text "number", limit: 65535
    t.text "citation", limit: 65535
    t.text "href", limit: 65535

    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parts", force: :cascade do |t|
    t.belongs_to :control
    
    t.references :parent

    t.text "number", limit:65535
    t.text "label", limit: 65535
    t.text "prepend", limit: 65535
    t.text "prose", limit: 65535

    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", force: :cascade do |t|
    t.belongs_to :control
    
    t.text "href", limit: 65535
    t.text "link_text", limit: 65535
    t.text "link_type", limit: 65535

    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
