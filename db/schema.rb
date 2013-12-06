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

ActiveRecord::Schema.define(version: 20131206005541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "metadata", force: true do |t|
    t.string "key",   null: false
    t.text   "value"
  end

  add_index "metadata", ["key"], name: "index_metadata_on_key", unique: true, using: :btree

  create_table "word_camps", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "address"
    t.date     "start"
    t.date     "end"
    t.string   "guid",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
  end

  add_index "word_camps", ["created_at"], name: "index_word_camps_on_created_at", using: :btree
  add_index "word_camps", ["guid"], name: "index_word_camps_on_guid", unique: true, using: :btree
  add_index "word_camps", ["start"], name: "index_word_camps_on_start", using: :btree

end
