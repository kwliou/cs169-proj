class Item < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :course
  belongs_to :grade
  has_many :blurbs
  has_many :grades
  has_many :posts

  validates_presence_of :category

  before_create { |item| item.category = item.category.cap }

  def to_param
    name.gsub(' ', '_')
  end

  def histogram
    # Median is easy
    grades = self.grades.sort { |a, b| a.points_received <=> b.points_received }
    median = grades[grades.length / 2].points_received
    scores = []
    
    # Calculate the mean
    total = 0.0
    grades.each do |g|
      total += g.points_received
      scores << g.points_received
    end
    mean = total / grades.length
    
    # Calculate the std. dev
    sd_sum = 0
    scores.each do |s|
      sd_sum += (s - mean)**2
    end
    
    std_dev = (sd_sum / scores.length)**0.5
    if self.points <= 15
      segment_size = 1
    else
      segment_size = self.points / 15
    end
    
    # Segment the scores into frequency buckets
    segments = []
    data = {:mean => format("%.2f", mean), 
            :std_dev => format("%.2f", std_dev), 
            :title => self.name, :points => []}
              
    low = scores.min
    high = low + segment_size
    while high <= scores.max and segment_size > 0 do
      range = [low.floor, high.ceil] 
      puts range
      freq = 0
      scores.each do |score|
        if score >= low && score <= high
          freq += 1
        end
      end
      data[:points] << {:range => range, :freq => freq}
      low = high
      high = high + segment_size
    end
    
    return data
  end

  def category_s
    category.pluralize.titleizev2;
  end

  def Item.categories_s(categories)
    (categories.split.map { |c| c.pluralize.titleizev2 }).join(', ')
  end

  def due_date_s
    date = due_date.getlocal
    time = date.strftime("%I:%M %p")
    "#{date.to_date.to_formatted_s(:long)} #{time.first == '0' ? time[1..-1] : time}"
  end
  
  def cal_date  # calendar date
    due_date.getlocal.strftime('%b %d')
  end
end