require 'spec_helper'

describe "/iratings/edit.html.erb" do
  include IratingsHelper

  before(:each) do
    assigns[:irating] = @irating = stub_model(Irating,
      :new_record? => false,
      :easiness => 1,
      :interest => 1,
      :work_load => 1,
      :item_id => 1
    )
  end

  it "renders the edit irating form" do
    render

    response.should have_tag("form[action=#{irating_path(@irating)}][method=post]") do
      with_tag('input#irating_easiness[name=?]', "irating[easiness]")
      with_tag('input#irating_interest[name=?]', "irating[interest]")
      with_tag('input#irating_work_load[name=?]', "irating[work_load]")
      with_tag('input#irating_item_id[name=?]', "irating[item_id]")
    end
  end
end
