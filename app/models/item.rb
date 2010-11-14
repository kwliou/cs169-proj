class Item < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :course
  has_many :blurbs
  has_many :grades
  has_many :posts

  validates_presence_of :category

  before_create { |item| item.category.downcase! }

  def to_param
    name.gsub(' ', '_')
  end

  def category_s # WTF doesn't String.titleizev2 work anymore???
    category.pluralize.titleizev2;
  end

end