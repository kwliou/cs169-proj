require 'spec_helper'

describe "/ratings/show.html.erb" do
  include RatingsHelper
  before(:each) do
    assigns[:rating] = @rating = stub_model(Rating,
      :easiness => 1,
      :interest => 1,
      :work_load => 1,
      :user_id => 1,
      :course_id => 
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(//)
  end
end
