require 'spec_helper'

describe IratingsController do
before :each do
    @current_user = mock_model(User)
    controller.stub!(:current_user).and_return(@current_user)
  end

 def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end
  def mock_course(stubs={})
    @mock_course ||= mock_model(Course, stubs)
  end
  def mock_item(stubs={})
    @mock_item ||= mock_model(Item, stubs)
  end
  def mock_irating(stubs={})
    @mock_irating ||= mock_model(Irating, stubs)
  end

  describe "GET index" do
    it "assigns all iratings as @iratings" do
	Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
	  Irating.should_receive(:all).and_return([mock_irating])
      Irating.stub(:find).with(:all).and_return([mock_irating])
      get :index, :course_id => 1, :item_id => 1
      assigns[:iratings].should == [mock_irating]
    end
  end

  describe "GET show" do
    it "assigns the requested irating as @irating" do
	  Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
	  Irating.should_receive(:find).with("37").and_return(mock_irating)
      Irating.stub(:find).with("37").and_return(mock_irating)
      get :show, :id => "37", :course_id => 1, :item_id => 1
      assigns[:irating].should equal(mock_irating)
    end
  end

  describe "GET new" do
    it "assigns a new irating as @irating" do
	Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
      Irating.stub(:build).and_return(mock_irating)
      get :new, :course_id => 1, :item_id => 1
      assigns[:irating].should equal(mock_irating)
    end
  end

  describe "GET edit" do
    it "assigns the requested irating as @irating" do
      Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
	  Irating.should_receive(:find).with("37").and_return(mock_irating)
      Irating.stub(:find).with("37").and_return(mock_irating)
      get :edit, :id => "37", :course_id => 1, :item_id => 1
      assigns[:irating].should equal(mock_irating)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created irating as @irating" do
	  Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
      Irating.stub(:build).and_return(mock_irating)
	  mock_irating.should_receive(:user=).and_return(mock_irating)
	  mock_irating.should_receive(:save).and_return(mock_irating(:save=>true))
	  post :create, :course_id => 1, :item_id => 1
      assigns[:irating].should equal(mock_irating)
      end

      it "redirects to the created irating" do
        Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
      Irating.stub(:build).and_return(mock_irating)
	  mock_irating.should_receive(:user=).and_return(mock_irating)
	  mock_irating.should_receive(:save).and_return(mock_irating(:save=>true))
	  post :create, :course_id => 1, :item_id => 1
      response.should redirect_to(course_item_irating_url(mock_course, mock_item, mock_irating))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved irating as @irating" do
        Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
      Irating.stub(:build).and_return(mock_irating(:save=>false))
	  mock_irating.should_receive(:user=).and_return(mock_irating(:save=>false))
	  post :create, :course_id => 1, :item_id => 1
        assigns[:irating].should equal(mock_irating)
      end

      it "re-renders the 'new' template" do
	  Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
      Irating.stub(:build).and_return(mock_irating(:save=>false))
	  mock_irating.should_receive(:user=).and_return(mock_irating(:save=>false))
        post :create, :course_id => 1, :item_id => 1
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested irating" do
	  Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
	  Irating.should_receive(:find).with("37").and_return(mock_irating)
      Irating.stub(:find).with("37").and_return(mock_irating)
        mock_irating.should_receive(:update_attributes)
        put :update, :id => "37", :course_id => 1, :item_id => 1, :irating => {:these => 'params'}
      end

      it "assigns the requested irating as @irating" do
        Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
      Irating.stub(:find).and_return(mock_irating(:update_attributes => true))
        put :update, :id => "1", :course_id => 1, :item_id => 1
        assigns[:irating].should equal(mock_irating)
      end

      it "redirects to the irating" do
        Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
      Irating.stub(:find).and_return(mock_irating(:update_attributes => true))
        put :update, :id => "1", :course_id => 1, :item_id => 1
        response.should redirect_to(course_item_irating_url(mock_course, mock_item, mock_irating))
      end
    end

    describe "with invalid params" do
      it "updates the requested irating" do
        Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
	  Irating.should_receive(:find).with("37").and_return(mock_irating)
      Irating.stub(:find).with("37").and_return(mock_irating)
        mock_irating.should_receive(:update_attributes)
        put :update, :id => "37", :course_id => 1, :item_id => 1, :irating => {:these => 'params'}
      end

      it "assigns the irating as @irating" do
        Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
      Irating.stub(:find).and_return(mock_irating(:update_attributes => false))
        put :update, :id => "1", :course_id => 1, :item_id => 1
        assigns[:irating].should equal(mock_irating)
      end

      it "re-renders the 'edit' template" do
        Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
      Irating.stub(:find).and_return(mock_irating(:update_attributes => false))
        put :update, :id => "1", :course_id => 1, :item_id => 1
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested irating" do
      Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
	  Irating.should_receive(:find).with("37").and_return(mock_irating)
      Irating.stub(:find).with("37").and_return(mock_irating)
      mock_irating.should_receive(:destroy)
      delete :destroy, :id => "37", :course_id => 1, :item_id => 1
    end

    it "redirects to the iratings list" do
	Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:iratings).and_return(Irating)
      Irating.stub(:find).and_return(mock_irating(:destroy => true))
      delete :destroy, :id => "1", :course_id => 1, :item_id => 1
      response.should redirect_to(course_item_iratings_url(mock_course,mock_item))
    end
  end

end
