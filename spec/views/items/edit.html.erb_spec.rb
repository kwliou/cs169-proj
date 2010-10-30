require 'spec_helper'

describe "/items/edit.html.erb" do
  include ItemsHelper

  before(:each) do
    assigns[:item] = @item = stub_model(Item,
      :new_record? => false,
      :type => "value for type",
      :points => 1,
      :weight => 1.5
    )
  end

  it "renders the edit item form" do
    render

    response.should have_tag("form[action=#{item_path(@item)}][method=post]") do
      with_tag('input#item_type[name=?]', "item[type]")
      with_tag('input#item_points[name=?]', "item[points]")
      with_tag('input#item_weight[name=?]', "item[weight]")
    end
  end
end
