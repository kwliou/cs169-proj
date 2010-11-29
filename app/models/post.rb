class Post < ActiveRecord::Base
  belongs_to :user #, :foreign_key => "user_username"
  belongs_to :item
  has_many :replies, :class_name => 'Post', :foreign_key => 'parent_id'
  belongs_to :parent, :class_name => 'Post'

  validates_presence_of :title, :body, :tags

  regex = Regexp.new '((https?:\/\/|www\.)([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)'
  
  before_save do |post|
    post.body.gsub!(regex, '<a href="\1" rel="nofollow">\1</a>')
    post.tags = (post.tags.split(',').map {|t| t.downcase.strip}).sort.join(', ')
  end

  def tags_array
    tags.split(', ')
  end
  def replies_s
    replies.count.to_s + (replies.count == 1 ? " Reply" : " Replies")
  end
  def created_at_day_s
    created_at.getlocal.strftime("%b %d, %Y")
  end
  def created_at_time_s
    #For some reason %l instead of %I doesn't work
    time = created_at.getlocal.strftime("%I:%M %p")
    time.first == '0' ? time[1..-1] : time
  end
  def sanitize # for views only
    ActionController::Base.helpers.sanitize(body.gsub("\n", "<br />"), :attributes => 'abbr alt cite class datetime height href name src title width rowspan colspan rel')
  end
end
