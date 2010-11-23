class CoursesController < ApplicationController
  before_filter :get_current_user # :get_course doesn't work on Heroku
  
  def histogram
    # Generates a histogram for an assignment, total assignments etc.
  end
  
  def deadline
    # Generates a deadline visualization
  end
  
  def performance
    # Generates average item performance of a student and all students
  end
  
  def subscribe
    @course = Course.find(params[:id])
    if !@current_user.courses.include?(@course)
      @current_user.courses << @course
    end
    
    redirect_to :action => 'show', :id => @course.id
  end
def unsubscribe
	@current_user.courses.delete(Course.find(params[:id]))
	redirect_to :controller=>:main, :action=>:index
	end
	
  layout "scaffold"
  
  # GET /courses
  # GET /courses.xml
  def index
    @courses = Course.all #@current_user.courses
    #@user_session = UserSession.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @courses }
    end
  end

  def deadline
    # For each item, we went due date and radius
    course = Course.find(params[:id])
    items = course.items
    data = []
    items.each do |item|
      data << {:name => item.name, :due_date => item.due_date,
               :points => item.points}
    end
    
    # Return deadline data encoded as JSON
    j = ActiveSupport::JSON
    deadline = j.encode(data)
    respond_to do |format|
        format.json  { render :json => deadline }
    end
    
  end
  
  # GET /courses/1
  # GET /courses/1.xml
  def show
    dept, number = params[:id].split('_')
    department = Course.unabbr(dept)
    @course = Course.find_by_department_and_number(department, number)
    @items = @course.items
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.xml
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/1/edit
  def edit
    dept, number = params[:id].split('_')
    department = Course.unabbr(dept)
    @course = Course.find_by_department_and_number(department, number)
  end

  # POST /courses
  # POST /courses.xml
  def create
    @course = @current_user.courses.build(params[:course])
    
    respond_to do |format|
      if @course.save
        @current_user.courses << @course
        format.html { redirect_to(@course, :notice => 'Course was successfully created.') }
        format.xml  { render :xml => @course, :status => :created, :location => @course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    dept, number = params[:id].split('_')
    department = Course.unabbr(dept)
    @course = Course.find_by_department_and_number(department, number)
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to(@course, :notice => 'Course was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.xml
  def destroy
    dept, number = params[:id].split('_')
    department = Course.unabbr(dept)
    @course = Course.find_by_department_and_number(department, number)
    @course.destroy

    respond_to do |format|
      format.html { redirect_to(courses_url) }
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
    if params[:id]
      dept, number = params[:id].split('_')
      department = Course.unabbr(dept)
      @course = Course.find_by_department_and_number(department, number)
    end
  end