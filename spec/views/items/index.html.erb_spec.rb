require 'spec_helper'

describe "/items/index.html.erb" do
  include ItemsHelper

  before(:each) do
    assigns[:items] = [
      stub_model(Item,
        :type => "value for type",
        :points => 1,
        :weight => 1.5
      ),
      stub_model(Item,
        :type => "value for type",
        :points => 1,
        :weight => 1.5
      )
    ]
  end

  it "renders a list of items" do
    render
    response.should have_tag("tr>td", "value for type".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
  end
end
