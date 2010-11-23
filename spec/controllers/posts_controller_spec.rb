require 'spec_helper'

describe PostsController do
  before :each do
    @current_user = mock_model(User)
    controller.stub!(:current_user).and_return(@current_user)
  end

#  def current_user(stubs = {})
#    @current_user ||= mock_model(User, stubs)
#  end

  def user_session(stubs = {}, user_stubs = {})
    @current_user_session ||= mock_model(UserSession, {:user => current_user(user_stubs)}.merge(stubs))
  end

  def mock_course(stubs={})
    @mock_course ||= mock_model(Course, stubs)
  end

  def mock_item(stubs={})
    @mock_item ||= mock_model(Item, stubs)
  end

  def mock_post(stubs={})
    @mock_post ||= mock_model(Post, stubs)
  end

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end

  describe "GET index" do
    it "assigns requested course item's posts as @posts" do
      #controller.get_course
      #controller.get_item
      Course.should_receive(:find_by_param).and_return(mock_course)
      mock_course.should_receive(:items).and_return(Item)
      Item.should_receive(:find).and_return(mock_item)
      mock_item.should_receive(:posts).and_return(Post)
      Post.should_receive(:find_all_by_parent_id).and_return([mock_post])
      get :index, :user_id => 1, :course_id => 1, :item_id => 1
      assigns[:posts].should == [mock_post]
    end
  end
  
  @wip
  describe "GET index_user" do
    it "assigns the requested user's posts as @posts" do
      #current_user = mock_user
      User.should_receive(:find_by_username).and_return(mock_user)
      mock_user.stub(:posts).and_return([mock_post]) #Post.stub(:find).with(:all).and_return([mock_post])
      get :index_user, :user_id => 1
      assigns[:posts].should == [mock_post]
    end
  end

  describe "GET show" do
    it "assigns the requested post as @post" do
      current_user = mock_user
      Course.stub(:find_by_department_and_number).and_return(mock_course)
      mock_course.stub(:items).and_return(Item)
      Item.stub(:find).and_return(mock_item)
      mock_item.should_receive(:posts).and_return(Post)
      Post.should_receive(:find).with("37").and_return(mock_post)
      get :show, :user_id => 1, :course_id => 1, :item_id => 1, :id => "37"
      assigns[:post].should equal(mock_post)
    end
  end

  describe "GET new" do
    it "assigns a new post as @post" do
      #current_user = mock_user
      current_user.stub(:posts).and_return(Post)
      Post.stub(:build).and_return(mock_post)
      get :new, :user_id => 1
      assigns[:post].should equal(mock_post)
    end
  end

  describe "GET new_post_reply" do
    it "assigns a new reply as @post" do
      current_user = mock_user
      mock_user.stub(:posts).and_return(Post)
      Post.stub(:build).and_return(mock_post)
      get :new, :user_id => 1
      assigns[:post].should equal(mock_post)
    end
  end

  describe "GET edit" do
    it "assigns the requested post as @post" do
      current_user = mock_user
      mock_user.stub(:posts).and_return(Post)
      Post.stub(:find).with("37").and_return(mock_post)
      get :edit, :id => "37"
      assigns[:post].should equal(mock_post)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created post as @post" do
        User.should_receive(:find).and_return(mock_user)
        mock_user.stub(:posts).and_return(Post)
        Post.stub(:build).with({'these' => 'params'}).and_return(mock_post(:save => true))
        post :create, :user_id => 1, :post => {:these => 'params'}
        assigns[:post].should equal(mock_post)
      end

      it "redirects to the created post" do
        User.should_receive(:find).and_return(mock_user)
        mock_user.stub(:posts).and_return(Post)
        Post.stub(:build).and_return(mock_post(:save => true))
        post :create, :user_id => 1, :post => {}
        response.should redirect_to(user_post_url(mock_user, mock_post))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        User.should_receive(:find).and_return(mock_user)
        mock_user.stub(:posts).and_return(Post)
        Post.stub(:build).with({'these' => 'params'}).and_return(mock_post(:save => false))
        post :create, :user_id => 1, :post => {:these => 'params'}
        assigns[:post].should equal(mock_post)
      end

      it "re-renders the 'new' template" do
        User.should_receive(:find).and_return(mock_user)
        mock_user.stub(:posts).and_return(Post)
        Post.stub(:build).and_return(mock_post(:save => false))
        post :create, :user_id => 1, :post => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested post" do
        User.should_receive(:find).and_return(mock_user)
        mock_user.stub(:posts).and_return(Post)
        Post.should_receive(:find).with("37").and_return(mock_post)
        mock_post.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :user_id => 1, :id => "37", :post => {:these => 'params'}
      end

      it "assigns the requested post as @post" do
        User.should_receive(:find).and_return(mock_user)
        mock_user.stub(:posts).and_return(Post)
        Post.stub(:find).and_return(mock_post(:update_attributes => true))
        put :update, :user_id => 1, :id => "1"
        assigns[:post].should equal(mock_post)
      end

      it "redirects to the post" do
        User.should_receive(:find).and_return(mock_user)
        mock_user.stub(:posts).and_return(Post)
        Post.stub(:find).and_return(mock_post(:update_attributes => true))
        put :update, :user_id => 1, :id => "1"
        response.should redirect_to(user_post_url(mock_user, mock_post))
      end
    end

    describe "with invalid params" do
      it "updates the requested post" do
        User.should_receive(:find).and_return(mock_user)
        mock_user.stub(:posts).and_return(Post)
        Post.should_receive(:find).with("37").and_return(mock_post)
        mock_post.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :user_id => 1, :id => "37", :post => {:these => 'params'}
      end

      it "assigns the post as @post" do
        User.should_receive(:find).and_return(mock_user)
        mock_user.stub(:posts).and_return(Post)
        Post.stub(:find).and_return(mock_post(:update_attributes => false))
        put :update, :user_id => 1, :id => "1"
        assigns[:post].should equal(mock_post)
      end

      it "re-renders the 'edit' template" do
        User.should_receive(:find).and_return(mock_user)
        mock_user.stub(:posts).and_return(Post)
        Post.stub(:find).and_return(mock_post(:update_attributes => false))
        put :update, :user_id => 1, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested post" do
      User.should_receive(:find).and_return(mock_user)
      mock_user.stub(:posts).and_return(Post)
      Post.should_receive(:find).with("37").and_return(mock_post)
      mock_post.should_receive(:destroy)
      delete :destroy, :user_id => 1, :id => "37"
    end

    it "redirects to the posts list" do
      User.should_receive(:find).and_return(mock_user)
      mock_user.stub(:posts).and_return(Post)
      Post.stub(:find).and_return(mock_post(:destroy => true))
      delete :destroy, :user_id => 1, :id => "1"
      response.should redirect_to(user_posts_url(mock_user))
    end
  end

end
