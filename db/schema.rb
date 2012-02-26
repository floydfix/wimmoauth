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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120223070015) do

  create_table "app_types", :force => true do |t|
    t.string "description"
    t.string "oauth_path"
    t.string "params"
    t.string "params_end"
    t.string "oauth_path_2"
    t.string "oauth_path_3"
    t.string "params_2"
    t.string "params_3"
    t.string "params_end_2"
    t.string "params_end_3"
    t.string "get_user_path"
  end

  create_table "app_users", :force => true do |t|
    t.integer  "app_id"
    t.string   "user_id"
    t.string   "user_name"
    t.string   "token"
    t.string   "code"
    t.integer  "code_expire"
    t.boolean  "code_reset"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "app_users", ["app_id", "user_id"], :name => "index_app_users_on_app_id_and_user_id", :unique => true

  create_table "apps", :force => true do |t|
    t.integer  "user_id"
    t.string   "app_name"
    t.integer  "app_type"
    t.string   "app_key"
    t.string   "ext_app_key"
    t.string   "ext_app_secret"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.binary   "image"
  end

  add_index "apps", ["user_id", "ext_app_key", "ext_app_secret"], :name => "index_apps_on_user_id_and_ext_app_key_and_ext_app_secret", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
