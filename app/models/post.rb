class Post < ActiveRecord::Base
  belongs_to :user #, :foreign_key => "user_username"
  belongs_to :item
  has_many :replies, :class_name => 'Post', :foreign_key => 'parent_id'
  belongs_to :parent, :class_name => 'Post'

  regex = Regexp.new '((https?:\/\/|www\.)([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)'
  
  before_save { |post| post.body.gsub!(regex, '<a href="\1">\1</a>') }

  def replies_s
    replies.count.to_s + (replies.count == 1 ? " Reply" : " Replies")
  end
  def created_at_day_s
    created_at.getlocal.strftime("%b %d, %Y")
  end
  def created_at_time_s
    time = created_at.getlocal.strftime("%I:%M %p")
    time.first == '0' ? time[1..-1] : time
  end
end
