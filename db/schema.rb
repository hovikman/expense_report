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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120822032415) do

  create_table "companies", :force => true do |t|
    t.string   "name",           :limit => 30, :null => false
    t.integer  "currency_id",                  :null => false
    t.string   "contact_person", :limit => 30, :null => false
    t.string   "contact_title",  :limit => 20, :null => false
    t.string   "contact_phone",  :limit => 20, :null => false
    t.string   "contact_email",  :limit => 40, :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "accountant_id"
  end

  create_table "currencies", :force => true do |t|
    t.string   "name",       :limit => 30, :null => false
    t.string   "code",       :limit => 3,  :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "expense_details", :force => true do |t|
    t.integer  "expense_id",                                    :null => false
    t.integer  "expense_type_id",                               :null => false
    t.date     "date",                                          :null => false
    t.integer  "currency_id",                                   :null => false
    t.decimal  "amount",                                        :null => false
    t.decimal  "exchange_rate",   :precision => 8, :scale => 2, :null => false
    t.text     "comments"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "expense_statuses", :force => true do |t|
    t.string   "name",       :limit => 20, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "expense_types", :force => true do |t|
    t.string   "name",       :limit => 30, :null => false
    t.integer  "company_id",               :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "expenses", :force => true do |t|
    t.integer  "user_id",                                         :null => false
    t.date     "submit_date",                                     :null => false
    t.text     "purpose",                                         :null => false
    t.integer  "expense_status_id",                               :null => false
    t.decimal  "advance_pay",       :precision => 8, :scale => 2, :null => false
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.integer  "owner_id"
  end

  create_table "user_types", :force => true do |t|
    t.string   "name",       :limit => 20, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "company_id",                    :null => false
    t.string   "name",            :limit => 30, :null => false
    t.integer  "manager_id"
    t.string   "email",           :limit => 40, :null => false
    t.integer  "user_type_id",                  :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
