class Item < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :course
  has_many :blurbs
  has_many :grades
  has_many :posts

  validates_presence_of :category

  before_create { |item| item.category = item.category.cap }

  def to_param
    name.gsub(' ', '_')
  end

  def category_s
    category.pluralize.titleizev2;
  end

  def Item.categories_s(categories)
    (categories.split.map { |c| c.pluralize.titleizev2 }).join(', ')
  end

end