include ActionView::Helpers::PrototypeHelper

class PostsController < ApplicationController
  # :get_post also probably doesn't work on Heroku
  before_filter :get_current_user, :get_course, :get_item
  
  layout "scaffold", :except => [:update_results]


  def update_results
    #all_tags = (@item.posts.map {|i| i.tags }).uniq
    sel_tags = params[:tags]
    @include_all = params[:include_all]
    if sel_tags.nil?
      @posts = @item.posts.find_all_by_parent_id(nil)
    elsif @include_all
      @posts = @item.posts.find(:all, :conditions => ['posts.tags LIKE ?', "%#{sel_tags.join(', ')}%"], :include => :replies)
    else
      #@posts = @item.posts.find(:all, :conditions => ['posts.tags IN (?)', sel_tags], :include => :replies)
      @posts = (sel_tags.map {|t| @item.posts.find(:all, :conditions => ['posts.tags LIKE ?', "%#{t}%"], :include => :replies) }).flatten.uniq
    end
    #@query = params[:tags]#(@item.posts.map { |i| i.tags }).uniq
    render 'filter' #, :posts => @posts
  end
  # GET /posts
  # GET /posts.xml
  def index
    @all_tags = (@item.posts.map {|i| i.tags_array}).flatten.uniq.sort
    #@sel_tags = @all_tags.select { |t| params["tag_#{t}"] }
    @sel_tags = params[:tags] || [params[:tag]]
    @include_all = params[:include_all]
    if params[:tags]
      #@sel_tags = params[:tags]
      @posts = @include_all ?
        @item.posts.find(:all, :conditions => ['posts.tags LIKE ?', "%#{@sel_tags.join(', ')}%"], :include => :replies) :
        (@sel_tags.map {|t| @item.posts.find(:all, :conditions => ['posts.tags LIKE ?', "%#{t}%"], :include => :replies) }).flatten.uniq
    elsif params[:tag]
      #@sel_tags = [params[:tag]]
      @posts = @item.posts.find_all_by_tag(params[:tag])
    else
      #@sel_tags = []
      @posts = @item.posts.find_all_by_parent_id(nil)
    end
#    update_page do |page|
#      page.replace_html 'forum_posts', :partial => 'posts', :posts => @posts
#    end
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
    params[:post][:body] = ActionController::Base.helpers.sanitize(params[:post][:body], :attributes => 'abbr alt cite datetime height href name src title width rowspan colspan rel')
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
    append = ActionController::Base.helpers.sanitize(params[:append], :attributes => 'abbr alt cite datetime height href name src title width rowspan colspan rel')
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
