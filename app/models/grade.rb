class Grade < ActiveRecord::Base
  belongs_to :item
  belongs_to :user
  
  validates_presence_of :item, :points_received
  validates_numericality_of :points_received
end