require 'spec_helper'

describe RatingsController do
before :each do
    @current_user = mock_model(User)
    controller.stub!(:current_user).and_return(@current_user)
  end
  def mock_rating(stubs={})
    @mock_rating ||= mock_model(Rating, stubs)
  end
 def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end
  def mock_course(stubs={})
    @mock_course ||= mock_model(Course, stubs)
  end
  
  describe "GET index" do
    it "assigns all ratings as @ratings" do
	Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
	Rating.should_receive(:all).and_return([mock_rating])
     get :index, :course_id=>1
      assigns[:ratings].should == [mock_rating]
    end
  end

  describe "GET show" do
    it "assigns the requested rating as @rating" do
	Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
	Rating.should_receive(:find).with("37").and_return(mock_rating)
      get :show, :id => "37", :course_id=>1
      assigns[:rating].should equal(mock_rating)
    end
  end

  describe "GET new" do
    it "assigns a new rating as @rating" do
	Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
      Rating.stub(:build).and_return(mock_rating)
      get :new, :course_id=>1
      assigns[:rating].should equal(mock_rating)
    end
  end

  describe "GET edit" do
    it "assigns the requested rating as @rating" do
      Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
	Rating.stub(:find).with("37").and_return(mock_rating)
      get :edit, :id => "37", :course_id=>1
      assigns[:rating].should equal(mock_rating)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created rating as @rating" do
	  Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
	Rating.stub(:build).and_return(mock_rating)
		mock_rating.should_receive(:user=).and_return(mock_rating)
		mock_rating.should_receive(:save).and_return(mock_rating(:save=>true))
        post :create, :course_id => 1
        assigns[:rating].should equal(mock_rating)
      end

      it "redirects to the created rating" do
        Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
	Rating.stub(:build).and_return(mock_rating)
	mock_rating.should_receive(:user=).and_return("user")
	mock_rating.should_receive(:save).and_return(mock_rating(:save=>true))
		
        post :create, :course_id => 1
        response.should redirect_to(course_rating_url(mock_course,mock_rating))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved rating as @rating" do
        Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
	Rating.stub(:build).and_return(mock_rating(:save=>false))
	mock_rating.should_receive(:user=).and_return(mock_rating(:save=>false))
        post :create, :course_id => 1
        assigns[:rating].should equal(mock_rating)
      end

      it "re-renders the 'new' template" do
        Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
	Rating.stub(:build).and_return(mock_rating(:save=>false))
		mock_rating.should_receive(:user=).and_return(mock_rating(:save=>false))
        post :create, :course_id => 1
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested rating" do
        Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
	Rating.stub(:find).with("37").and_return(mock_rating)
	mock_rating.should_receive(:update_attributes)
        put :update, :course_id => 1,  :id => "37", :rating => {:these => 'params'}
      end

      it "assigns the requested rating as @rating" do
	  Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
        Rating.stub(:find).and_return(mock_rating(:update_attributes => true))
        put :update, :id => "1", :course_id=>1
        assigns[:rating].should equal(mock_rating)
      end

      it "redirects to the rating" do
	   Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
        Rating.stub(:find).and_return(mock_rating(:update_attributes => true))
        put :update, :id => "1", :course_id=>1
        response.should redirect_to(course_rating_url(mock_course, mock_rating))
      end
    end

    describe "with invalid params" do
      it "updates the requested rating" do
	  Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
        Rating.should_receive(:find).with("37").and_return(mock_rating)
        mock_rating.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :course_id=>1,:rating => {:these => 'params'}
      end

      it "assigns the rating as @rating" do
	  Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
        Rating.stub(:find).and_return(mock_rating(:update_attributes => false))
        put :update, :id => "1", :course_id=>1
        assigns[:rating].should equal(mock_rating)
      end

      it "re-renders the 'edit' template" do
	  Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
        Rating.stub(:find).and_return(mock_rating(:update_attributes => false))
        put :update, :id => "1", :course_id=>1
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested rating" do
	Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
      Rating.should_receive(:find).with("37").and_return(mock_rating)
      mock_rating.should_receive(:destroy)
      delete :destroy, :id => "37", :course_id=>1
    end

    it "redirects to the ratings list" do
	Course.should_receive(:find_by_param).and_return(mock_course)
	mock_course.should_receive(:ratings).and_return(Rating)
      Rating.stub(:find).and_return(mock_rating(:destroy => true))
      delete :destroy, :id => "1", :course_id=>1
      response.should redirect_to(course_ratings_url(mock_course))
    end
  end

end
