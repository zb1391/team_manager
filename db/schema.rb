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

ActiveRecord::Schema.define(version: 20151022002920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campifications", force: true do |t|
    t.integer  "summer_camp_id"
    t.integer  "summer_camper_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "coupons", force: true do |t|
    t.string  "title"
    t.string  "description"
    t.boolean "active",       default: true
    t.date    "active_until"
  end

  create_table "display_tournament_locations", force: true do |t|
    t.integer "display_tournament_id"
    t.integer "location_id"
  end

  create_table "display_tournaments", force: true do |t|
    t.string  "season"
    t.integer "min_grade"
    t.integer "max_grade"
    t.integer "guaranteed_games"
    t.float   "price"
    t.string  "genders"
    t.boolean "active",             default: true
    t.integer "tournament_type_id"
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

  create_table "home_page_files", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "the_file_file_name"
    t.string   "the_file_content_type"
    t.integer  "the_file_file_size"
    t.datetime "the_file_updated_at"
    t.integer  "team_id"
  end

  create_table "home_page_panels", force: true do |t|
    t.text    "html"
    t.string  "additional_link"
    t.string  "additional_link_text"
    t.boolean "is_active",            default: false
    t.integer "priority_order"
    t.string  "title"
  end

  create_table "hotelifications", force: true do |t|
    t.integer  "hotel_id"
    t.integer  "event_id"
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
    t.date     "start_date"
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
    t.float    "amount_owe"
    t.float    "amount_paid"
  end

  create_table "summer_camps", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "end_registration_date"
    t.string   "camp_type"
  end

  create_table "team_tryout_times", force: true do |t|
    t.integer "tryout_time_id"
    t.integer "team_id"
  end

  create_table "teams", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.integer  "coach_id"
    t.string   "gender"
    t.string   "team_type"
    t.string   "name"
    t.string   "color"
    t.integer  "age"
    t.integer  "grade"
  end

  create_table "tournament_locations", force: true do |t|
    t.integer "location_id"
    t.integer "tournament_id"
  end

  create_table "tournament_types", force: true do |t|
    t.string "name"
  end

  create_table "tournaments", force: true do |t|
    t.string   "name"
    t.date     "the_date"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "end_date"
    t.string   "genders",               default: "Both"
    t.integer  "min_grade",             default: 3
    t.integer  "max_grade",             default: 12
    t.date     "end_registration_date"
    t.integer  "tournament_type_id"
  end

  create_table "tryout_dates", force: true do |t|
    t.date    "date"
    t.integer "tryout_id"
  end

  create_table "tryout_times", force: true do |t|
    t.time    "time"
    t.integer "tryout_date_id"
  end

  create_table "tryouts", force: true do |t|
    t.string "season"
  end

end
