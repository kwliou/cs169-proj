class ItemsController < ApplicationController
  before_filter :get_current_user, :get_course # :get_item doesn't work on Heroku

  layout "scaffold"
  # GET /courses/:id/items
  # GET /items.xml
  def index
    @category = params[:category]
    if @category
      @categories = @category.split(' ')
      @category_s = (@categories.map { |c| c.pluralize.titleizev2 }).join(', ')
      @items = @course.items.find(:all, :conditions => ["lower(category) IN (?)", @category.downcase.split(' ')])
    else
      @category_s = 'Items'
      @items = @course.items
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET/items/1.xml
  def show
    @item = @course.items.find(:first, :conditions => ['lower(name) = ?', params[:id].downcase.gsub('_', ' ')])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = @course.items.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = @course.items.find(:first, :conditions => ['lower(name) = ?', params[:id].downcase.gsub('_', ' ')])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = @course.items.build(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to([@course, @item], :notice => 'Item was successfully created.') }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = @course.items.find(:first, :conditions => ['lower(name) = ?', params[:id].downcase.gsub('_', ' ')])
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to([@course, @item], :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = @course.items.find(:first, :conditions => ['lower(name) = ?', params[:id].downcase.gsub('_', ' ')])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(course_items_url(@course)) }
      format.xml  { head :ok }
    end
  end
end

private
  def get_current_user
    @current_user = current_user
  end
  def get_course
    if params[:course_id]
      dept, number = params[:course_id].split('_')
      department = Course.unabbr(dept)
      @course = Course.find_by_department_and_number(department, number)
    end
  end
  def get_item
    @item = @course.items.find(:first, :conditions => ['lower(name) = ?', params[:id].downcase.gsub('_', ' ')]) if params[:id]
  end
