class RatingsController < ApplicationController
  # GET /ratings
  # GET /ratings.xml
  before_filter :get_current_user
  before_filter :get_course
  layout "scaffold"
  def index
    @ratings = @course.ratings.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ratings }
    end
  end

  # GET /ratings/1
  # GET /ratings/1.xml
  def show
    @rating = @course.ratings.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rating }
    end
  end

  # GET /ratings/new
  # GET /ratings/new.xml
  def new
    @rating = @course.ratings.build(params[:rating])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rating }
    end
  end

  # GET /ratings/1/edit
  def edit
    @rating = @course.ratings.find(params[:id])
  end

  # POST /ratings
  # POST /ratings.xml
  def create
    @rating = @course.ratings.build(params[:rating])
	@rating.user=@current_user

    respond_to do |format|
      if @rating.save
        format.html { redirect_to([@course,@rating], :notice => 'Rating was successfully created.') }
        format.xml  { render :xml => @rating, :status => :created, :location => @rating }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ratings/1
  # PUT /ratings/1.xml
  def update
    @rating = @course.ratings.find(params[:id])

    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        format.html { redirect_to([@course,@rating], :notice => 'Rating was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.xml
  def destroy
    @rating = @course.ratings.find(params[:id])
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to(course_ratings_path(@course) )}
      format.xml  { head :ok }
    end
  end
  def get_current_user
    @current_user = current_user
    redirect_to root_url if @current_user.nil?
  end
   def get_course
    if params[:course_id]
      dept, number = params[:course_id].split('_')
      department = Department.find_by_abbr(dept)
      #department = Course.unabbr(dept)
      @course = Course.find_by_department_id_and_number(department.id, number)
    end
end
end