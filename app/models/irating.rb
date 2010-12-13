class Irating < ActiveRecord::Base
belongs_to :item
belongs_to :user
validates_uniqueness_of :user_id, :scope=>:item_id
validates_presence_of :user_id
validates_presence_of :item_id
validates_presence_of :easiness
validates_presence_of :interest
validates_presence_of :work_load
def Irating.total_e(item)
  item.iratings.inject(0){|sum, rating| sum+rating.easiness}
  end
  def Irating.total_i(item)
  item.iratings.inject(0){|sum, rating| sum+rating.interest}
  end
  def Irating.total_w(item)
  item.iratings.inject(0){|sum, rating| sum+rating.work_load}
  end
  
  def Irating.to_s_e(rate)
  return Rating.to_s_e(rate)
  end
  
  def Irating.to_s_i(rate)
  rating_s=rate.to_s
  case rate
  when 0..1.5
  return "I felt stupider after finishing (" << rating_s <<"/5)"
  when 1.5..2.5
  return "my brain was in sleep mode the whole time (" << rating_s <<"/5)"
  when 2.5..3.5
  return "eh...can't complain (" << rating_s <<"/5)"
  when 3.5..4.5
  return "After the 10th time of looking over it, I still learned something new (" << rating_s <<"/5)"
  when 4.5..5
  return "it uncovers the secrets of the universe!!! (" << rating_s <<"/5)"
  end
  end
  
  def Irating.to_s_w(rate)
  rating_s=rate.to_s
  case rate
  when 0..1.5
  return "even a time machine can't save you (" << rating_s <<"/5)"
  when 1.5..3.5
  return Rating.to_s_w(rate)
  when 3.5..4.5
  return "definitely not a CS project (" << rating_s <<"/5)"
  when 4.5..5
  return "I don't remember doing ANY work (" << rating_s <<"/5)"
  end
  end
end
