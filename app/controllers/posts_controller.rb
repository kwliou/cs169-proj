class PostsController < ApplicationController
  layout "scaffold"

  before_filter :get_data
  
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
    @post = @user ? @user.posts.find(params[:id]) : @item.posts.find(params[:id])
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
  def get_data
    if params[:course_id]
      @course = Course.find(params[:course_id])
      @item = Item.find(params[:item_id]) # @course.items.find(params[:item_id])
    end
    @user = User.find_by_username(params[:user_id]) if params[:user_id]
    @current_user = current_user
  end