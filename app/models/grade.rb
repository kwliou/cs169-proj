class Grade < ActiveRecord::Base
  has_one :assignment
end
