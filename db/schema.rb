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

ActiveRecord::Schema.define(version: 20140524193449) do

  create_table "care_provider_profiles", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "field_of_study"
    t.string   "school"
    t.text     "skills",                       limit: 1255
    t.text     "misc",                         limit: 1255
    t.string   "contact_email"
    t.string   "contact_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.string   "county"
    t.string   "transportation"
    t.string   "gender"
    t.string   "status"
  end

  add_index "care_provider_profiles", ["user_id"], name: "index_care_provider_profiles_on_user_id"

  create_table "care_receiver_profiles", force: true do |t|
    t.string   "name"
    t.date     "birthdate"
    t.string   "gender"
    t.text     "disabilities",                 limit: 1255
    t.text     "hobbies",                      limit: 1255
    t.text     "services_needed",              limit: 1255
    t.text     "misc",                         limit: 1255
    t.string   "hours_needed"
    t.string   "days_needed"
    t.string   "city"
    t.string   "transportation"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.string   "county"
    t.string   "status"
  end

  add_index "care_receiver_profiles", ["user_id"], name: "index_care_receiver_profiles_on_user_id"

  create_table "connections", force: true do |t|
    t.string  "message"
    t.integer "care_receiver_profile_id"
    t.integer "care_provider_profile_id"
    t.string  "care_receiver_profile_approval"
    t.string  "care_provider_profile_approval"
  end

  create_table "employment_surveys", force: true do |t|
    t.integer  "user_id"
    t.string   "kind_of_ad"
    t.string   "contact"
    t.string   "employment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flaggings", force: true do |t|
    t.string   "flaggable_type"
    t.integer  "flaggable_id"
    t.string   "flagger_type"
    t.integer  "flagger_id"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flaggings", ["flaggable_type", "flaggable_id"], name: "index_flaggings_on_flaggable_type_and_flaggable_id"
  add_index "flaggings", ["flagger_type", "flagger_id", "flaggable_type", "flaggable_id"], name: "access_flaggings"

  create_table "page_feedbacks", force: true do |t|
    t.string  "feedback"
    t.string  "controller"
    t.string  "action"
    t.integer "user_id"
  end

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

  create_table "volunteer_opportunities", force: true do |t|
    t.string   "org_name"
    t.string   "event_type"
    t.string   "description"
    t.string   "contact_phone"
    t.string   "contact_name"
    t.string   "contact_email"
    t.datetime "event_start"
    t.datetime "event_end"
    t.integer  "user_id"
    t.boolean  "agree_terms"
    t.string   "ein"
    t.string   "type_of_org"
    t.string   "title"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.string   "required_documents_file_name"
    t.string   "required_documents_content_type"
    t.integer  "required_documents_file_size"
    t.datetime "required_documents_updated_at"
  end

end
