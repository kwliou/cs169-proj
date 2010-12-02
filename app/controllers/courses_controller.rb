class CoursesController < ApplicationController
  before_filter :get_current_user # :get_course doesn't work on Heroku

  def auto_complete_for_department_name
    @depts = Department.find(:all, :conditions=> ['name LIKE ?', "%#{params[:department][:name]}%"])
    render :partial => 'department'
  end

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
    
    redirect_to :action => 'show', :id => @course.to_param
  end
def unsubscribe
	@current_user.courses.delete(Course.find_by_param(params[:id]))
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
    @course = Course.find_by_param(params[:id])
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
    @departments = Department.find(:all, :order => 'name').map { |c| [c.name, c.id] }
    @years = Course.year_limits
    #win.getContent().update("<h1>Hello world !!</h1>");
    #win.showCenter();
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end

#  def update_abbr
#    dept = Department.find_by_name(params[:department])
#    dept || dept.abbr
#  end
  # GET /courses/1/edit
  def edit
    @course = Course.find_by_param(params[:id])
    @departments = Department.find(:all, :order => 'name').map { |c| [c.name, c.id] }
    @years = Course.year_limits
    @days = @course.days.each_char.map { |c| c == c.upcase }
  end

  # POST /courses
  # POST /courses.xml
  def create
    params[:course][:days] = ''
    'mtwrfsu'.each_char do |day|
      params[:course][:days] += params[day] || day
    end
#    if params[:department] # params[:course][:department_id].nil?
#      params[:course][:department_id] = params[:department][:name]
#    end
    @course = Course.new(params[:course])
    
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
    params[:course][:days] = ''
    'mtwrfsu'.each_char do |day|
      params[:course][:days] += params[day] || day
    end
    @course = Course.find_by_param(params[:id])
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
    @course = Course.find_by_param(params[:id])
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
    @course = Course.find_by_param(params[:id]) if params[:id]
  end
