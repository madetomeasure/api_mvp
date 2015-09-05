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

ActiveRecord::Schema.define(version: 20150905185421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deliveries", force: :cascade do |t|
    t.integer  "subscriber_id"
    t.integer  "message_id"
    t.datetime "delivered_at"
  end

  add_index "deliveries", ["subscriber_id", "message_id"], name: "index_deliveries_on_subscriber_id_and_message_id", unique: true, using: :btree

  create_table "message_parts", force: :cascade do |t|
    t.string   "mime_type",  null: false
    t.text     "body",       null: false
    t.integer  "message_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "message_parts", ["message_id", "mime_type"], name: "index_message_parts_on_message_id_and_mime_type", unique: true, using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "subject",    limit: 77, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "subscriber_data", force: :cascade do |t|
    t.integer  "subscriber_id", null: false
    t.json     "traits",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "subscriber_data", ["subscriber_id"], name: "index_subscriber_data_on_subscriber_id", unique: true, using: :btree

  create_table "subscribers", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscribers", ["email"], name: "index_subscribers_on_email", unique: true, using: :btree

  add_foreign_key "message_parts", "messages"
end
