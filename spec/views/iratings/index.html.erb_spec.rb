require 'spec_helper'

describe "/iratings/index.html.erb" do
  include IratingsHelper

  before(:each) do
    assigns[:iratings] = [
      stub_model(Irating,
        :easiness => 1,
        :interest => 1,
        :work_load => 1,
        :item_id => 1
      ),
      stub_model(Irating,
        :easiness => 1,
        :interest => 1,
        :work_load => 1,
        :item_id => 1
      )
    ]
  end

  it "renders a list of iratings" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
