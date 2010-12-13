require 'spec_helper'

describe Irating do
  before(:each) do
    @valid_attributes = {
      :easiness => 1,
      :interest => 1,
      :work_load => 1,
      :item_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Irating.create!(@valid_attributes)
  end
end
