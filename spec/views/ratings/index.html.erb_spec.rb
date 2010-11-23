require 'spec_helper'

describe "/ratings/index.html.erb" do
  include RatingsHelper

  before(:each) do
    assigns[:ratings] = [
      stub_model(Rating,
        :easiness => 1,
        :interest => 1,
        :work_load => 1,
        :user_id => 1,
        :course_id => 1
      ),
      stub_model(Rating,
        :easiness => 1,
        :interest => 1,
        :work_load => 1,
        :user_id => 1,
        :course_id => 1
      )
    ]
  end

  it "renders a list of ratings" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
