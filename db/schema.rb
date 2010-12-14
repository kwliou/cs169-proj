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

ActiveRecord::Schema.define(:version => 20101213203451) do

  create_table "courses", :force => true do |t|
    t.string    "number"
    t.string    "days"
    t.string    "term"
    t.integer   "year"
    t.text      "description"
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.decimal   "points_possible"
    t.integer   "department_id"
  end

  create_table "courses_users", :id => false, :force => true do |t|
    t.integer "user_id",   :null => false
    t.integer "course_id", :null => false
  end

  create_table "departments", :force => true do |t|
    t.string    "name"
    t.string    "abbr"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "grades", :force => true do |t|
    t.string    "letter"
    t.decimal   "points_received"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "user_id"
    t.integer   "item_id"
  end

  create_table "iratings", :force => true do |t|
    t.integer   "easiness"
    t.integer   "interest"
    t.integer   "work_load"
    t.integer   "item_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "user_id"
  end

  create_table "items", :force => true do |t|
    t.string    "category"
    t.timestamp "due_date"
    t.integer   "points"
    t.float     "weight"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.text      "description"
    t.integer   "course_id"
    t.string    "name"
  end

  create_table "posts", :force => true do |t|
    t.string    "title"
    t.text      "body"
    t.timestamp "commented_at"
    t.string    "tags"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "user_id"
    t.integer   "item_id"
    t.integer   "parent_id"
  end

  create_table "ratings", :force => true do |t|
    t.integer   "easiness"
    t.integer   "interest"
    t.integer   "work_load"
    t.integer   "user_id"
    t.integer   "course_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "first_name"
    t.string    "last_name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "username"
    t.string    "email"
    t.string    "crypted_password"
    t.string    "password_salt"
    t.string    "persistence_token"
    t.integer   "fb_id"
  end

end
