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

ActiveRecord::Schema.define(version: 20140309111100) do

  create_table "argument_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "arguments", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
    t.integer  "argument_type_id"
    t.integer  "discussion_id"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "research_institute_id"
  end

  create_table "contacts", force: true do |t|
    t.string   "street"
    t.string   "postalcode"
    t.string   "town"
    t.string   "email"
    t.string   "telephone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discussion_presences", force: true do |t|
    t.integer  "discussions_user_id"
    t.boolean  "present"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discussions", force: true do |t|
    t.string   "topic"
    t.integer  "moderator_id"
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_question_id"
    t.integer  "company_id"
  end

  create_table "discussions_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "discussion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "topic"
    t.integer  "discussion_id"
  end

  create_table "research_institutes", force: true do |t|
    t.string   "name"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deputy_id"
  end

  create_table "research_institutes_users", force: true do |t|
    t.integer "research_institute_id"
    t.integer "user_id"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",                            null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "argument_id"
    t.integer  "user_id"
    t.boolean  "is_like"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
