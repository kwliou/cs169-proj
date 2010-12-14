class IratingsController < ApplicationController
  # GET /iratings
  # GET /iratings.xml
  before_filter :get_current_user
  before_filter :get_course
  layout "scaffold"
  def index
    @item = @course.items.find(:first, :conditions => ['lower(name) = ?', params[:item_id].downcase.gsub('_', ' ')])
    @iratings = @item.iratings.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @iratings }
    end
  end

  # GET /iratings/1
  # GET /iratings/1.xml
  def show
  @item = @course.items.find(:first, :conditions => ['lower(name) = ?', params[:item_id].downcase.gsub('_', ' ')])
    @irating = @item.iratings.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @irating }
    end
  end

  # GET /iratings/new
  # GET /iratings/new.xml
  def new
  @item = @course.items.find(:first, :conditions => ['lower(name) = ?', params[:item_id].downcase.gsub('_', ' ')])
    @irating = @item.iratings.build(params[:irating])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @irating }
    end
  end

  # GET /iratings/1/edit
  def edit
  @item = @course.items.find(:first, :conditions => ['lower(name) = ?', params[:item_id].downcase.gsub('_', ' ')])
    @irating = @item.iratings.find(params[:id])
  end

  # POST /iratings
  # POST /iratings.xml
  def create
  @item = @course.items.find(:first, :conditions => ['lower(name) = ?', params[:item_id].downcase.gsub('_', ' ')])
    @irating = @item.iratings.build(params[:irating])
	@irating.user=@current_user
    respond_to do |format|
      if @irating.save
	  
        format.html { redirect_to([@course,@item,@irating], :notice => 'ItemRating was successfully created.') }
        format.xml  { render :xml => @irating, :status => :created, :location => @irating }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @irating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /iratings/1
  # PUT /iratings/1.xml
  def update
  @item = @course.items.find(:first, :conditions => ['lower(name) = ?', params[:item_id].downcase.gsub('_', ' ')])
    @irating = @item.iratings.find(params[:id])

    respond_to do |format|
      if @irating.update_attributes(params[:irating])
        format.html { redirect_to([@course, @item, @irating], :notice => 'ItemRating was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @irating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /iratings/1
  # DELETE /iratings/1.xml
  def destroy
  @item = @course.items.find(:first, :conditions => ['lower(name) = ?', params[:item_id].downcase.gsub('_', ' ')])
    @irating = @item.iratings.find(params[:id])
    @irating.destroy

    respond_to do |format|
      format.html { redirect_to(course_item_iratings_path(@course, @item)) }
      format.xml  { head :ok }
    end
  end
  def get_current_user
    @current_user = current_user
    redirect_to root_url if @current_user.nil?
  end
  def get_course
    @course = Course.find_by_param(params[:course_id]) if params[:course_id]
  end
end
