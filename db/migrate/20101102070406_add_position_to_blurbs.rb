class AddPositionToBlurbs < ActiveRecord::Migration
  def self.up
    add_column :blurbs, :position, :string
  end

  def self.down
    remove_column :blurbs, :position
  end
end
