require 'spec_helper'

describe IratingsController do

  def mock_irating(stubs={})
    @mock_irating ||= mock_model(Irating, stubs)
  end

  describe "GET index" do
    it "assigns all iratings as @iratings" do
      Irating.stub(:find).with(:all).and_return([mock_irating])
      get :index
      assigns[:iratings].should == [mock_irating]
    end
  end

  describe "GET show" do
    it "assigns the requested irating as @irating" do
      Irating.stub(:find).with("37").and_return(mock_irating)
      get :show, :id => "37"
      assigns[:irating].should equal(mock_irating)
    end
  end

  describe "GET new" do
    it "assigns a new irating as @irating" do
      Irating.stub(:new).and_return(mock_irating)
      get :new
      assigns[:irating].should equal(mock_irating)
    end
  end

  describe "GET edit" do
    it "assigns the requested irating as @irating" do
      Irating.stub(:find).with("37").and_return(mock_irating)
      get :edit, :id => "37"
      assigns[:irating].should equal(mock_irating)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created irating as @irating" do
        Irating.stub(:new).with({'these' => 'params'}).and_return(mock_irating(:save => true))
        post :create, :irating => {:these => 'params'}
        assigns[:irating].should equal(mock_irating)
      end

      it "redirects to the created irating" do
        Irating.stub(:new).and_return(mock_irating(:save => true))
        post :create, :irating => {}
        response.should redirect_to(irating_url(mock_irating))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved irating as @irating" do
        Irating.stub(:new).with({'these' => 'params'}).and_return(mock_irating(:save => false))
        post :create, :irating => {:these => 'params'}
        assigns[:irating].should equal(mock_irating)
      end

      it "re-renders the 'new' template" do
        Irating.stub(:new).and_return(mock_irating(:save => false))
        post :create, :irating => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested irating" do
        Irating.should_receive(:find).with("37").and_return(mock_irating)
        mock_irating.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :irating => {:these => 'params'}
      end

      it "assigns the requested irating as @irating" do
        Irating.stub(:find).and_return(mock_irating(:update_attributes => true))
        put :update, :id => "1"
        assigns[:irating].should equal(mock_irating)
      end

      it "redirects to the irating" do
        Irating.stub(:find).and_return(mock_irating(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(irating_url(mock_irating))
      end
    end

    describe "with invalid params" do
      it "updates the requested irating" do
        Irating.should_receive(:find).with("37").and_return(mock_irating)
        mock_irating.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :irating => {:these => 'params'}
      end

      it "assigns the irating as @irating" do
        Irating.stub(:find).and_return(mock_irating(:update_attributes => false))
        put :update, :id => "1"
        assigns[:irating].should equal(mock_irating)
      end

      it "re-renders the 'edit' template" do
        Irating.stub(:find).and_return(mock_irating(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested irating" do
      Irating.should_receive(:find).with("37").and_return(mock_irating)
      mock_irating.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the iratings list" do
      Irating.stub(:find).and_return(mock_irating(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(iratings_url)
    end
  end

end
