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

ActiveRecord::Schema.define(version: 20151008034310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "title",      default: "", null: false
    t.text     "body",       default: "", null: false
    t.integer  "school_id",               null: false
    t.integer  "user_id",                 null: false
    t.integer  "category"
  end

  add_index "announcements", ["school_id"], name: "index_announcements_on_school_id", using: :btree
  add_index "announcements", ["user_id"], name: "index_announcements_on_user_id", using: :btree

  create_table "check_ins", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "start",                      null: false
    t.datetime "finish",                     null: false
    t.integer  "school_id"
    t.integer  "user_id"
    t.boolean  "verified",   default: false
    t.text     "comment"
  end

  add_index "check_ins", ["school_id"], name: "index_check_ins_on_school_id", using: :btree
  add_index "check_ins", ["user_id"], name: "index_check_ins_on_user_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "name",                                default: "",  null: false
    t.decimal  "lat",        precision: 10, scale: 7, default: 0.0
    t.decimal  "lng",        precision: 10, scale: 7, default: 0.0
  end

  create_table "semesters", force: :cascade do |t|
    t.datetime "start",      null: false
    t.datetime "finish",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "year"
    t.integer  "season"
  end

  add_index "semesters", ["year", "season"], name: "index_semesters_on_year_and_season", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "verified",               default: false, null: false
    t.string   "first_name",             default: ""
    t.string   "last_name",              default: ""
    t.string   "authentication_token"
    t.integer  "role",                   default: 0
    t.integer  "school_id"
    t.integer  "director_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
