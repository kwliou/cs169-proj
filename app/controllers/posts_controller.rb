class PostsController < ApplicationController
  layout "scaffold"

  before_filter :get_current_user, :get_course, :get_item, :get_user
  
  # GET /posts
  # GET /posts.xml
  def index
    @posts = @user ? @user.posts : @item.posts
    respond_to do |format|
      if @user
        format.html # index.html.erb
      else
        format.html { render :action => "forum" }
      end
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = @item.posts.find(params[:id]) # @user.posts.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = @current_user.posts.build #Post.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = @user.posts.find(params[:id])#Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    #params[:post][:item_id] = @item
    @post = @current_user.posts.build(params[:post]) #Post.new(params[:post])
    @post.item = @item
    respond_to do |format|
      if @post.save
        format.html { redirect_to([@course, @item, @post], :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = @current_user.posts.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to([@user, @post], :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = @current_user.posts.find(params[:id]) #Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(user_posts_url(@user)) }
      format.xml  { head :ok }
    end
  end
end

private
  def get_course
    if params[:course_id]
      dept, number = params[:course_id].split('_')
      department = Course.unabbr(dept)
      @course = Course.find_by_department_and_number(department, number)
    end
  end
  def get_item
    @item = @course.items.find(:first, :conditions => ["lower(name) = ?", params[:item_id].downcase.gsub('_', ' ')])
  end
  def get_user
    @user = User.find_by_username(params[:user_id]) if params[:user_id]
  end
  def get_current_user
    @current_user = current_user
  end