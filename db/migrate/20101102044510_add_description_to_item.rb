class AddDescriptionToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :description, :string
  end

  def self.down
    drop_column :items, :description
  end
end
