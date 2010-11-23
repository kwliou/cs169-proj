require 'spec_helper'

describe "/ratings/edit.html.erb" do
  include RatingsHelper

  before(:each) do
    assigns[:rating] = @rating = stub_model(Rating,
      :new_record? => false,
      :easiness => 1,
      :interest => 1,
      :work_load => 1,
      :user_id => 1,
      :course_id => 1
    )
  end

  it "renders the edit rating form" do
    render

    response.should have_tag("form[action=#{rating_path(@rating)}][method=post]") do
      with_tag('input#rating_easiness[name=?]', "rating[easiness]")
      with_tag('input#rating_interest[name=?]', "rating[interest]")
      with_tag('input#rating_work_load[name=?]', "rating[work_load]")
      with_tag('input#rating_user_id[name=?]', "rating[user_id]")
      with_tag('input#rating_course_id[name=?]', "rating[course_id]")
    end
  end
end
