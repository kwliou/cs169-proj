class PostsController < ApplicationController
  layout "scaffold"

  before_filter :get_user
  
  # GET /posts
  # GET /posts.xml
  def index
    @posts = @user.posts #Post.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = @user.posts.find(params[:id]) #Post.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = @user.posts.build #Post.new
    
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
    @post = @user.posts.build(params[:post]) #Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to([@user, @post], :notice => 'Post was successfully created.') }
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
    @post = @user.posts.find(params[:id])

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
    @post = @user.posts.find(params[:id]) #Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(user_posts_url(@user)) }
      format.xml  { head :ok }
    end
  end
end

private
  def get_user
    @user = @current_user = User.find(params[:user_id])
  end