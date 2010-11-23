require 'spec_helper'

describe "/ratings/new.html.erb" do
  include RatingsHelper

  before(:each) do
    assigns[:rating] = stub_model(Rating,
      :new_record? => true,
      :easiness => 1,
      :interest => 1,
      :work_load => 1,
      :user_id => 1,
      :course_id => 1
    )
  end

  it "renders new rating form" do
#    render
#
#    response.should have_tag("form[action=?][method=post]", ratings_path) do
#      with_tag("input#rating_easiness[name=?]", "rating[easiness]")
#      with_tag("input#rating_interest[name=?]", "rating[interest]")
#      with_tag("input#rating_work_load[name=?]", "rating[work_load]")
#      with_tag("input#rating_user_id[name=?]", "rating[user_id]")
#      with_tag("input#rating_course_id[name=?]", "rating[course_id]")
#   end
  end
end
