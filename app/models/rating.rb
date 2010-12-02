class Rating < ActiveRecord::Base
belongs_to :user
belongs_to :course
validates_uniqueness_of :user_id, :scope=>:course_id
validates_presence_of :user_id
validates_presence_of :course_id
validates_presence_of :easiness
validates_presence_of :interest
validates_presence_of :work_load
 def Rating.total_e(course)
  course.ratings.inject(0){|sum, rating| sum+rating.easiness}
  end
  def Rating.total_i(course)
  course.ratings.inject(0){|sum, rating| sum+rating.interest}
  end
  def Rating.total_w(course)
  course.ratings.inject(0){|sum, rating| sum+rating.work_load}
  end
  
  def to_s_e(rate)
  rating_s=rate.to_s
  case rate
  when 0..1.5
  return "WTF? (" << rating_s <<"/5)"
  when 1.5..2.5
  return "prerequisite: IQ must be over 180 (" << rating_s <<"/5)"
  when 2.5..3.5
  return "eh...can't complain (" << rating_s <<"/5)"
  when 3.5..4.5
  return "GPA booster (" << rating_s <<"/5)"
  when 4.5..5
  return "I swear this is elementary school material (" << rating_s <<"/5)"
  end
  end
  
  def to_s_i(rate)
  rating_s=rate.to_s
  case rate
  when 0..1.5
  return "World's greatest treatement for Insomnia! (" << rating_s <<"/5)"
  when 1.5..2.5
  return "Zzz...Zzz... (" << rating_s <<"/5)"
  when 2.5..3.5
  return "eh...can't complain (" << rating_s <<"/5)"
  when 3.5..4.5
  return "I took the course 3 times!!! (" << rating_s <<"/5)"
  when 4.5..5
  return "I cried each time class was over (" << rating_s <<"/5)"
  end
  end
  
  def to_s_w(rate)
  rating_s=rate.to_s
  case rate
  when 0..1.5
  return "my therapist says I'm scarred for life (" << rating_s <<"/5)"
  when 1.5..2.5
  return "sleep is for losers (" << rating_s <<"/5)"
  when 2.5..3.5
  return "eh...can't complain (" << rating_s <<"/5)"
  when 3.5..4.5
  return "for lazy students only!!! (" << rating_s <<"/5)"
  when 4.5..5
  return "a semester long vacation (" << rating_s <<"/5)"
  end
  end
end
