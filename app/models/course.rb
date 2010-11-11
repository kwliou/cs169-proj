class Course < ActiveRecord::Base
  has_many :items
  has_many :blurbs
  has_and_belongs_to_many :users

  @@abbr = {
    "computer science" => "compsci",
    "anthropology" => "anthro"
  }
  
  def to_param
    "#{dept}_#{number}"
  end

  def dept
    @@abbr[department.downcase].upcase || department
  end
  def Course.unabbr(abbr)
    @@abbr.index(abbr.downcase).each_upcase || abbr
  end
end

class String
  def each_upcase
    self.split(' ').map {|w| w.capitalize }.join(' ')
  end
end
