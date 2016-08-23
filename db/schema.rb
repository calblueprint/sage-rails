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

ActiveRecord::Schema.define(version: 20160823223820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "title",       default: "", null: false
    t.text     "body",        default: "", null: false
    t.integer  "school_id"
    t.integer  "user_id",                  null: false
    t.integer  "category"
    t.integer  "semester_id"
  end

  add_index "announcements", ["school_id"], name: "index_announcements_on_school_id", using: :btree
  add_index "announcements", ["user_id"], name: "index_announcements_on_user_id", using: :btree

  create_table "check_ins", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "start",                       null: false
    t.datetime "finish",                      null: false
    t.integer  "school_id"
    t.integer  "user_id"
    t.boolean  "verified",    default: false
    t.text     "comment"
    t.integer  "semester_id"
  end

  add_index "check_ins", ["school_id"], name: "index_check_ins_on_school_id", using: :btree
  add_index "check_ins", ["semester_id"], name: "index_check_ins_on_semester_id", using: :btree
  add_index "check_ins", ["user_id"], name: "index_check_ins_on_user_id", using: :btree

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections",             default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                                null: false
    t.string   "auth_key"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

  add_index "rpush_feedback", ["device_token"], name: "index_rpush_feedback_on_device_token", using: :btree

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",                        default: "default"
    t.text     "alert"
    t.text     "data"
    t.integer  "expiry",                       default: 86400
    t.boolean  "delivered",                    default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                       default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                default: false
    t.string   "type",                                             null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",             default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                           null: false
    t.integer  "retries",                      default: 0
    t.string   "uri"
    t.datetime "fail_after"
    t.boolean  "processing",                   default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category"
    t.boolean  "content_available",            default: false
    t.text     "notification"
  end

  add_index "rpush_notifications", ["delivered", "failed"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))", using: :btree

  create_table "schools", force: :cascade do |t|
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "name",                                default: "",  null: false
    t.decimal  "lat",        precision: 10, scale: 7, default: 0.0
    t.decimal  "lng",        precision: 10, scale: 7, default: 0.0
    t.string   "address"
    t.integer  "radius",                              default: 200
  end

  create_table "semesters", force: :cascade do |t|
    t.datetime "start",                           null: false
    t.datetime "finish"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "season"
    t.boolean  "paused",          default: false
    t.integer  "weeks_completed", default: 0
  end

  create_table "user_semesters", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "semester_id"
    t.boolean  "completed",   default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "total_time",  default: 0
    t.integer  "status",      default: 1
  end

  add_index "user_semesters", ["user_id", "semester_id"], name: "index_user_semesters_on_user_id_and_semester_id", unique: true, using: :btree

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
    t.integer  "volunteer_type",         default: 0
    t.string   "image"
    t.integer  "device_type"
    t.string   "device_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
