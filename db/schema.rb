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

ActiveRecord::Schema.define(version: 20140328172030) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: true do |t|
    t.integer  "organization_id"
    t.string   "coach"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender"
    t.string   "grade"
    t.string   "email"
    t.string   "cell"
  end

  create_table "coaches", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.string   "encrypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
    t.boolean  "admin",              default: false
  end

  create_table "events", force: true do |t|
    t.integer  "eventtype_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "the_date"
    t.time     "the_time"
    t.time     "end_time"
    t.integer  "hotel_id"
    t.integer  "location_id"
    t.integer  "court"
    t.date     "end_date"
    t.text     "description"
  end

  create_table "eventtypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hotels", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.float    "price"
    t.string   "addtional_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "additional_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contact_name"
    t.string   "email"
    t.string   "phone"
    t.integer  "tournament_id"
    t.float    "amount_owe"
    t.float    "amount_paid"
    t.time     "paid_at"
  end

  create_table "payment_notifications", force: true do |t|
    t.text     "params"
    t.integer  "organization_id"
    t.string   "status"
    t.string   "transaction_id"
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "uniform_number"
    t.string   "parent_first_name"
    t.string   "parent_last_name"
    t.string   "parent_email"
    t.string   "parent_cell"
    t.string   "emergency_phone"
    t.string   "parent_email2"
  end

  create_table "summer_campers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "gender"
    t.string   "grade"
    t.string   "email"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "waiver_name"
    t.date     "waiver_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "summer_camp_id"
    t.float    "amount_owe"
    t.float    "amount_paid"
  end

  create_table "summer_camps", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.integer  "coach_id"
    t.string   "gender"
    t.string   "grade"
    t.string   "team_type"
    t.string   "name"
    t.string   "color"
    t.integer  "age"
  end

  create_table "tournaments", force: true do |t|
    t.string   "name"
    t.date     "the_date"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
