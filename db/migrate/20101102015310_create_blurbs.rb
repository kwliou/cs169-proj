class CreateBlurbs < ActiveRecord::Migration
  def self.up
    create_table :blurbs do |t|
      t.string :text
      t.boolean :as_html
      t.timestamps
    end
  end

  def self.down
    drop_table :blurbs
  end
end
