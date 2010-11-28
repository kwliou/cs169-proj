include ActionView::Helpers::PrototypeHelper

class PostsController < ApplicationController
  # :get_post also probably doesn't work on Heroku
  before_filter :get_current_user, :get_course, :get_item
  
  layout "scaffold", :except => [:update_results]


  def update_results
    #@tags = @item.posts.map {|i| i.tags}
    @posts = @item.posts.find_all_by_tags(params[:tags])
    #render do |page|
    #  page.replace_html 'forum_posts', :partial => 'stuff', :posts => @posts
    #end
    render 'filter'#, :posts => @posts
  end
  # GET /posts
  # GET /posts.xml
  def index
    if params[:tags]
      @posts = @item.posts.find_all_by_tags(params[:tags])
    else
      @posts = @item.posts.find_all_by_parent_id(nil)
    end
    @tags = (@item.posts.map {|i| i.tags }).uniq
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /user/:user_id/posts
  def index_user
    @user = User.find_by_username(params[:user_id])
    @posts = @user.posts
    respond_to do |format|
      format.html # index_user.html.erb
      format.xml  { render :xml => @posts }
    end
  end
  
  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = @item.posts.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = @current_user.posts.build # Post.new
    @parent = @item.posts.find(params[:post_id]) if params[:post_id]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end
  
  def new_post_reply
    @post = @current_user.posts.build # Post.new
    @post.parent = @parent = @item.posts.find(params[:post_id])
    respond_to do |format|
      format.html  { render :reply } # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = @current_user.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    # maybe should separated into def create_post_reply
    # maybe parent_id should be added after save instead of before ...
    params[:post][:item_id] = @item.id
    @post = @current_user.posts.build(params[:post])
    #@post.item = @item
    respond_to do |format|
      if @post.save
        format.html { redirect_to([@course, @item, @post], :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => 'new' }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = @current_user.posts.find(params[:id])
    append = ActionController::Base.helpers.sanitize(params[:append], :attributes => 'abbr alt cite datetime height href name src title width rowspan colspan')
    if !append.blank?
      params[:post][:body] = "#{@post.body}<br /><br /><span class='post_edit'>Edit (#{DateTime.now.strftime("%x")}, #{DateTime.now.strftime("%l:%M %p")}): </span><br />#{append}"
    end
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to([@course, @item, @post], :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => 'edit' }
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
      format.html { redirect_to(course_item_posts_url(@course, @item)) }
      format.xml  { head :ok }
    end
  end
end

private
  def get_current_user
    @current_user = current_user
    redirect_to root_url if @current_user.nil?
  end
  def get_course
    @course = Course.find_by_param(params[:course_id]) if params[:course_id]
  end
  def get_item
    @item = @course.items.find(:first, :conditions => ["lower(name) = ?", params[:item_id].downcase.gsub('_', ' ')]) if params[:item_id]
  end
