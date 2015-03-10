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

ActiveRecord::Schema.define(version: 20150310150103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "argument_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "arguments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
    t.integer  "argument_type_id"
    t.integer  "discussion_id"
  end

  add_index "arguments", ["argument_type_id"], name: "index_arguments_on_argument_type_id", using: :btree
  add_index "arguments", ["discussion_id"], name: "index_arguments_on_discussion_id", using: :btree
  add_index "arguments", ["question_id"], name: "index_arguments_on_question_id", using: :btree
  add_index "arguments", ["user_id"], name: "index_arguments_on_user_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "research_institute_id"
  end

  add_index "companies", ["contact_id"], name: "index_companies_on_contact_id", using: :btree
  add_index "companies", ["research_institute_id"], name: "index_companies_on_research_institute_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "street",     limit: 255
    t.string   "postalcode", limit: 255
    t.string   "town",       limit: 255
    t.string   "email",      limit: 255
    t.string   "telephone",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discussion_presences", force: :cascade do |t|
    t.integer  "discussions_user_id"
    t.boolean  "present"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "discussion_presences", ["discussions_user_id"], name: "index_discussion_presences_on_discussions_user_id", using: :btree

  create_table "discussions", force: :cascade do |t|
    t.string   "topic",      limit: 255
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.text     "summary"
  end

  add_index "discussions", ["company_id"], name: "index_discussions_on_company_id", using: :btree

  create_table "discussions_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "discussion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color",         limit: 255
    t.integer  "role_id"
    t.boolean  "confirmed",                 default: false
    t.string   "name"
  end

  add_index "discussions_users", ["discussion_id"], name: "index_discussions_users_on_discussion_id", using: :btree
  add_index "discussions_users", ["role_id"], name: "index_discussions_users_on_role_id", using: :btree
  add_index "discussions_users", ["user_id"], name: "index_discussions_users_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "topic",         limit: 255
    t.integer  "discussion_id"
  end

  add_index "questions", ["discussion_id"], name: "index_questions_on_discussion_id", using: :btree

  create_table "research_institutes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deputy_id"
  end

  add_index "research_institutes", ["contact_id"], name: "index_research_institutes_on_contact_id", using: :btree
  add_index "research_institutes", ["deputy_id"], name: "index_research_institutes_on_deputy_id", using: :btree

  create_table "research_institutes_users", force: :cascade do |t|
    t.integer "research_institute_id"
    t.integer "user_id"
  end

  add_index "research_institutes_users", ["research_institute_id"], name: "index_research_institutes_users_on_research_institute_id", using: :btree
  add_index "research_institutes_users", ["user_id"], name: "index_research_institutes_users_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", force: :cascade do |t|
    t.integer  "n"
    t.integer  "e"
    t.integer  "c"
    t.integer  "a"
    t.integer  "o"
    t.integer  "lm"
    t.integer  "mm"
    t.integer  "sm"
    t.integer  "h"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.integer  "n_points"
    t.integer  "e_points"
    t.integer  "c_points"
    t.integer  "a_points"
    t.integer  "o_points"
    t.integer  "lm_points"
    t.integer  "mm_points"
    t.integer  "sm_points"
    t.integer  "h_points"
    t.integer  "school"
    t.integer  "degree"
    t.integer  "personal_status"
    t.integer  "income"
  end

  add_index "surveys", ["user_id"], name: "index_surveys_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "firstname",              limit: 255
    t.string   "lastname",               limit: 255
    t.string   "email",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.string   "encrypted_password",     limit: 255, default: ""
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",                  default: 0
    t.string   "gender"
    t.date     "birthday"
    t.string   "zipcode"
    t.string   "country"
    t.string   "city"
    t.string   "phone"
    t.string   "industry"
    t.boolean  "pseudonym_policy"
    t.boolean  "can_be_called"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  create_table "visual_aids", force: :cascade do |t|
    t.integer  "discussion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",              limit: 255
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "visual_aids", ["discussion_id"], name: "index_visual_aids_on_discussion_id", using: :btree

  create_table "visual_aids_logs", force: :cascade do |t|
    t.integer  "visual_aid_id"
    t.boolean  "open"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visual_aids_logs", ["visual_aid_id"], name: "index_visual_aids_logs_on_visual_aid_id", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "argument_id"
    t.integer  "user_id"
    t.boolean  "is_like"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["argument_id"], name: "index_votes_on_argument_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
