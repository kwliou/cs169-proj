require 'spec_helper'

describe "/items/new.html.erb" do
  include ItemsHelper

  before(:each) do
    assigns[:item] = stub_model(Item,
      :new_record? => true,
      :type => "value for type",
      :points => 1,
      :weight => 1.5
    )
  end

  it "renders new item form" do
#    render
#
#    response.should have_tag("form[action=?][method=post]", items_path) do
#      with_tag("input#item_type[name=?]", "item[type]")
#      with_tag("input#item_points[name=?]", "item[points]")
#      with_tag("input#item_weight[name=?]", "item[weight]")
#    end
  end
end
