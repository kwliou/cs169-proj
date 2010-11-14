# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101114000840) do

  create_table "blurbs", :force => true do |t|
    t.string   "text"
    t.boolean  "as_html"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
    t.text     "title"
    t.string   "position"
  end

  create_table "courses", :force => true do |t|
    t.string   "department"
    t.string   "number"
    t.string   "days"
    t.string   "term"
    t.integer  "year"
    t.text     "description"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "short_title"
    t.decimal  "points_possible"
  end

  create_table "courses_users", :id => false, :force => true do |t|
    t.integer "user_id",   :null => false
    t.integer "course_id", :null => false
  end

  create_table "grades", :force => true do |t|
    t.string   "letter"
    t.decimal  "points_received"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "item_id"
  end

  create_table "items", :force => true do |t|
    t.string   "category"
    t.datetime "due_date"
    t.integer  "points"
    t.float    "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description", :limit => 255
    t.integer  "course_id"
    t.string   "name"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "commented_at"
    t.string   "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "item_id"
    t.integer  "parent_id"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
  end

end
