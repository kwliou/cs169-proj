require 'spec_helper'

describe "/items/show.html.erb" do
  include ItemsHelper
  before(:each) do
    assigns[:item] = @item = stub_model(Item,
      :type => "value for type",
      :points => 1,
      :weight => 1.5
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ type/)
    response.should have_text(/1/)
    response.should have_text(/1\.5/)
  end
end
