class Item < ActiveRecord::Base
  belongs_to :course
  has_many :blurbs
  has_many :grades
  has_many :posts

  validates_presence_of :category

  before_create { |item| item.category.downcase! }

  def to_param
    name.gsub(' ', '_')
  end

  def category_s # pretty string for navigation bar
    category.titleizev2.pluralize;
  end
end
