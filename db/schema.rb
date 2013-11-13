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

ActiveRecord::Schema.define(version: 20131101203820) do

  create_table "choices", force: true do |t|
    t.integer  "user_id"
    t.integer  "search_id"
    t.integer  "restaurant_id"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "follows", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", force: true do |t|
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.integer  "locator_id"
    t.string   "locator_type"
    t.string   "address"
    t.string   "ip_address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hood"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "phone"
  end

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.string   "cuisine"
    t.string   "price"
    t.boolean  "delivery"
    t.boolean  "takeout"
    t.boolean  "reservations"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "yelp_url"
  end

  create_table "searches", force: true do |t|
    t.integer  "user_id"
    t.string   "method_filter"
    t.string   "cuisine_filter"
    t.string   "price_filter"
    t.integer  "members"
    t.time     "time"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
