class RemoveBlurbs < ActiveRecord::Migration
  def self.up
    drop_table :blurbs
  end

  def self.down
    create_table "blurbs", :force => true do |t|
      t.string   "text"
      t.boolean  "as_html"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "course_id"
      t.text     "title"
      t.string   "position"
    end
  end
end
