require 'spec_helper'

describe CoursesController do

  before :each do 
    @current_user = mock_model(User) 
    controller.stub!(:current_user).and_return(@current_user) 
  end 
  
  def mock_course(stubs={})
    @mock_course ||= mock_model(Course, stubs)
  end

  def mock_item(stubs={})
    @mock_item ||= mock_model(Item, stubs)
  end
  
  describe "subscribe" do
    it "adds a course to a user's courses and redirects to that course's page" do
      Course.stub(:find).with("37").and_return(mock_course)
      @current_user.stub(:courses).and_return(Course)
      Course.stub(:include?).with(mock_course).and_return(true)
      Course.stub(:<<)
      put :subscribe, :id => "37"
      assigns[:course].should equal(mock_course)
      response.should redirect_to(course_url(mock_course))
    end
  end
  
  describe "unsubscribe" do
    it "removes the course from a user's courses and redirects to the home page" do
      Course.stub(:find).with("37").and_return(mock_course)
      @current_user.stub(:courses).and_return(Course)
      Course.should_receive(:delete).with(mock_course)
      delete :unsubscribe, :id => "37"
      response.should redirect_to(root_url)
    end
  end

  describe "GET index" do
    it "assigns all courses as @courses" do
      Course.stub(:find).with(:all).and_return([mock_course])
      get :index
      assigns[:courses].should == [mock_course]
    end
  end

  describe "GET show" do
    it "assigns the requested course as @course" do
      Course.stub(:find_by_param).with("COMPSCI_169").and_return(mock_course)
      mock_course.stub(:items).and_return([mock_item])
      get :show, :id => "COMPSCI_169"
      assigns[:course].should equal(mock_course)
    end
  end

  describe "GET new" do
    it "assigns a new course as @course" do
      Course.stub(:new).and_return(mock_course)
      get :new
      assigns[:course].should equal(mock_course)
    end
  end

  describe "GET edit" do
    it "assigns the requested course as @course" do
      Course.stub(:find_by_param).with("COMPSCI_169").and_return(mock_course)
      get :edit, :id => "COMPSCI_169"
      assigns[:course].should equal(mock_course)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created course as @course" do
        @current_user.stub(:courses).and_return(Course)
        Course.stub(:<<)
        Course.stub(:build).with({'these' => 'params'}).and_return(mock_course(:save => true))
        post :create, :course => {:these => 'params'}
        assigns[:course].should equal(mock_course)
      end

      it "redirects to the created course" do
        @current_user.stub(:courses).and_return(Course)
        Course.stub(:<<)
        Course.stub(:build).and_return(mock_course(:save => true))
        post :create, :course => {}
        response.should redirect_to(course_url(mock_course))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved course as @course" do
        @current_user.stub(:courses).and_return(Course)
        Course.stub(:build).with({'these' => 'params'}).and_return(mock_course(:save => false))
        post :create, :course => {:these => 'params'}
        assigns[:course].should equal(mock_course)
      end

      it "re-renders the 'new' template" do
        @current_user.stub(:courses).and_return(Course)
        Course.stub(:build).and_return(mock_course(:save => false))
        post :create, :course => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested course" do
        Course.should_receive(:find_by_param).with("COMPSCI_169").and_return(mock_course)
        mock_course.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "COMPSCI_169", :course => {:these => 'params'}
      end

      it "assigns the requested course as @course" do
        Course.stub(:find_by_param).and_return(mock_course(:update_attributes => true))
        put :update, :id => "COMPSCI_169"
        assigns[:course].should equal(mock_course)
      end

      it "redirects to the course" do
        Course.stub(:find_by_param).and_return(mock_course(:update_attributes => true))
        put :update, :id => "COMPSCI_169"
        response.should redirect_to(course_url(mock_course))
      end
    end

    describe "with invalid params" do
      it "updates the requested course" do
        Course.should_receive(:find_by_param).with("COMPSCI_169").and_return(mock_course)
        mock_course.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "COMPSCI_169", :course => {:these => 'params'}
      end

      it "assigns the course as @course" do
        Course.stub(:find_by_param).and_return(mock_course(:update_attributes => false))
        put :update, :id => "COMPSCI_169"
        assigns[:course].should equal(mock_course)
      end

      it "re-renders the 'edit' template" do
        Course.stub(:find_by_param).and_return(mock_course(:update_attributes => false))
        put :update, :id => "COMPSCI_169"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested course" do
      Course.should_receive(:find_by_param).with("COMPSCI_169").and_return(mock_course)
      mock_course.should_receive(:destroy)
      delete :destroy, :id => "COMPSCI_169"
    end

    it "redirects to the courses list" do
      Course.stub(:find_by_param).and_return(mock_course(:destroy => true))
      delete :destroy, :id => "COMPSCI_169"
      response.should redirect_to(courses_url)
    end
  end

end
