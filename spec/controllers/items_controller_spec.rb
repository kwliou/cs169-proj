require 'spec_helper'

describe ItemsController do
  before :each do
    @current_user = mock_model(User)
    controller.stub!(:current_user).and_return(@current_user)

    Course.stub(:find_by_param).and_return(mock_course)
    mock_course.stub(:items).and_return(Item)  
  end

  def mock_course(stubs={})
    @mock_course ||= mock_model(Course, stubs)
  end

  def mock_item(stubs={})
    @mock_item ||= mock_model(Item, stubs)
  end

  describe "GET index" do
    it "assigns all course items as @items" do
      #Course.stub(:find_by_param).and_return(mock_course)
      mock_course.stub(:items).and_return([mock_item])
      get :index, :course_id => 1
      assigns[:items].should == [mock_item]
    end
  end

  describe "GET show" do
    it "assigns the requested item as @item" do
      #Course.stub(:find_by_param).and_return(mock_course)
      #mock_course.stub(:items).and_return(Item)
      Item.stub(:find).and_return(mock_item)
      get :show, :course_id => 1, :id => "37"
      assigns[:item].should equal(mock_item)
    end
  end

  describe "GET new" do
    it "assigns a new item as @item" do
      #Course.stub(:find_by_param).and_return(mock_course)
      #mock_course.stub(:items).and_return(Item)
      Item.stub(:build).and_return(mock_item)
      get :new, :course_id => 1
      assigns[:item].should equal(mock_item)
    end
  end

  describe "GET edit" do
    it "assigns the requested item as @item" do
      #Course.stub(:find_by_param).and_return(mock_course)
      #mock_course.stub(:items).and_return(Item)
      Item.stub(:find).and_return(mock_item)
      get :edit, :course_id => 1, :id => "37"
      assigns[:item].should equal(mock_item)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created item as @item" do
        Item.stub(:build).with({'these' => 'params'}).and_return(mock_item(:save => true))
        post :create, :course_id => 1, :item => {:these => 'params'}
        assigns[:item].should equal(mock_item)
      end

      it "redirects to the created item" do
        Item.stub(:build).and_return(mock_item(:save => true))
        post :create, :course_id => 1, :item => {}
        response.should redirect_to(course_item_url(mock_course, mock_item))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved item as @item" do
        Item.stub(:build).with({'these' => 'params'}).and_return(mock_item(:save => false))
        post :create, :course_id => 1, :item => {:these => 'params'}
        assigns[:item].should equal(mock_item)
      end

      it "re-renders the 'new' template" do
        Item.stub(:build).and_return(mock_item(:save => false))
        post :create, :course_id => 1, :item => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested item" do
        Item.should_receive(:find).and_return(mock_item)
        mock_item.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :course_id => 1, :id => "37", :item => {:these => 'params'}
      end

      it "assigns the requested item as @item" do
        Item.stub(:find).and_return(mock_item(:update_attributes => true))
        put :update, :course_id => 1, :id => "1"
        assigns[:item].should equal(mock_item)
      end

      it "redirects to the item" do
        Item.stub(:find).and_return(mock_item(:update_attributes => true))
        put :update, :course_id => 1, :id => "1"
        response.should redirect_to(course_item_url(mock_course, mock_item))
      end
    end

    describe "with invalid params" do
      it "updates the requested item" do
        Item.should_receive(:find).and_return(mock_item)
        mock_item.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :course_id => 1, :id => "37", :item => {:these => 'params'}
      end

      it "assigns the item as @item" do
        Item.stub(:find).and_return(mock_item(:update_attributes => false))
        put :update, :course_id => 1, :id => "1"
        assigns[:item].should equal(mock_item)
      end

      it "re-renders the 'edit' template" do
        Item.stub(:find).and_return(mock_item(:update_attributes => false))
        put :update, :course_id => 1, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested item" do
      Course.stub(:find_by_param).and_return(mock_course)
      mock_course.stub(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:destroy)
      delete :destroy, :course_id => 1, :id => "37"
    end

    it "redirects to the items list" do
      Course.stub(:find_by_param).and_return(mock_course)
      mock_course.stub(:items).and_return(Item)
      Item.stub(:find).and_return(mock_item(:destroy => true))
      delete :destroy, :course_id => 1, :id => "1"
      response.should redirect_to(course_items_url(mock_course))
    end
  end

end
