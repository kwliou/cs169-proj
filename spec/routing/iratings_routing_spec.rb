require 'spec_helper'

describe IratingsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/iratings" }.should route_to(:controller => "iratings", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/iratings/new" }.should route_to(:controller => "iratings", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/iratings/1" }.should route_to(:controller => "iratings", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/iratings/1/edit" }.should route_to(:controller => "iratings", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/iratings" }.should route_to(:controller => "iratings", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/iratings/1" }.should route_to(:controller => "iratings", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/iratings/1" }.should route_to(:controller => "iratings", :action => "destroy", :id => "1") 
    end
  end
end
