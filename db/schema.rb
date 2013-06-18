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

ActiveRecord::Schema.define(:version => 20130618043447) do

  create_table "accounts", :force => true do |t|
    t.string   "content"
    t.integer  "price"
    t.string   "note"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["item_id"], :name => "index_accounts_on_item_id"

  create_table "bank_accounts", :force => true do |t|
    t.string   "bank_name"
    t.string   "branch_name"
    t.string   "branch_number"
    t.string   "name"
    t.string   "code"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bank_accounts", ["user_id"], :name => "index_bank_accounts_on_user_id"

  create_table "information", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "tel"
    t.string   "fax"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "information", ["user_id"], :name => "index_information_on_user_id"

  create_table "items", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "note"
    t.string   "client_name"
    t.string   "state"
    t.datetime "estimated_at"
    t.datetime "ordered_at"
    t.datetime "deliveried_at"
    t.datetime "receipted_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["user_id"], :name => "index_items_on_user_id"

end
