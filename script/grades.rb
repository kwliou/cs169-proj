require File.expand_path('../../config/environment',  __FILE__)

course = Course.find(26)
items = course.items
data = []
items.each do |item|
  data << {:name => item.name, :due_date => item.due_date,
           :points => item.points}
end

j = ActiveSupport::JSON
deadline = j.encode(data)
puts j.encode(data)