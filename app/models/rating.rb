class Rating < ActiveRecord::Base
belongs_to :user
belongs_to :course
validates_uniqueness_of :user_id, :scope=>:course_id
validates_presence_of :user
validates_presence_of :course
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
  if (rate<1.5)
  return "WTF? (" << rating_s <<"/5)"
  end
  if (rate<2.5)
  return "prerequisite: IQ must be over 180 (" << rating_s <<"/5)"
  end
  if (rate<3.5)
  return "eh...can't complain (" << rating_s <<"/5)"
  end
  if (rate<4.5)
  return "GPA booster (" << rating_s <<"/5)"
  end
  else return "I swear this is elementary school material (" << rating_s <<"/5)"
  end
  
  def to_s_i(rate)
  rating_s=rate.to_s
  if (rate<1.5)
  return "World's greatest treatement for Insomnia! (" << rating_s <<"/5)"
  end
  if (rate<2.5)
  return "Zzz...Zzz... (" << rating_s <<"/5)"
  end
  if (rate<3.5)
  return "eh...can't complain (" << rating_s <<"/5)"
  end
  if (rate<4.5)
  return "I took the course 3 times!!! (" << rating_s <<"/5)"
  end
  else return "I cried each time class was over (" << rating_s <<"/5)"
  end
  def to_s_w(rate)
  rating_s=rate.to_s
  if (rate<1.5)
  return "my therapist says I'm scarred for life (" << rating_s <<"/5)"
  end
  if (rate<2.5)
  return "sleep is for losers (" << rating_s <<"/5)"
  end
  if (rate<3.5)
  return "eh...can't complain (" << rating_s <<"/5)"
  end
  if (rate<4.5)
  return "for lazy students only!!! (" << rating_s <<"/5)"
  end
  else return "a semester long vacation (" << rating_s <<"/5)"
  end
end
