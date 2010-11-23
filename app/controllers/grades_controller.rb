class GradesController < ApplicationController
  layout "scaffold"
  # GET /grades
  # GET /grades.xml
  def index
    @course = Course.find(params[:id])
    @current_user = current_user
    @grades = @current_user.grades
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grades }
    end
  end

  def histogram
    item = Item.find(params[:id])
    # Median is easy
    grades = item.grades.sort { |a, b| a.points_received <=> b.points_received }
    median = grades[grades.length / 2].points_received
    scores = []
    
    # Calculate the mean
    total = 0.0
    grades.each do |g|
      total += g.points_received
      scores << g.points_received
    end
    mean = total / grades.length
    
    # Calculate the std. dev
    sd_sum = 0
    scores.each do |s|
      sd_sum += (s - mean)**2
    end
    
    std_dev = (sd_sum / scores.length)**0.5
    segment_size = item.points / 15
    
    # Segment the scores into frequency buckets
    segments = []
    data = {:mean => format("%.2f", mean), 
            :std_dev => format("%.2f", std_dev), 
            :title => item.name, :points => []}
              
    low = scores.min
    high = low + segment_size
    while high < scores.max and segment_size > 0 do
      range = [low.floor, high.ceil]  
      freq = 0
      scores.each do |score|
        if score >= low && score <= high
          freq += 1
        end
      end
      data[:points] << {:range => range, :freq => freq}
      low = high
      high = high + segment_size
    end
    
    # Return the histogram encoded as JSON
    j = ActiveSupport::JSON
    histogram = j.encode(data)
    respond_to do |format|
        format.json  { render :json => histogram }
    end
  
  end
  
  def performance
    user = User.find(params[:id])
    grades = user.grades.sort { |a, b| a.item.due_date <=> b.item.due_date }
    
    # For each grade, calculate the average grade % up to 
    # the corresponding due date
    j = ActiveSupport::JSON
    i = 1
    data = []
    grades.each do |grade|
      total_pct = 0.0
      grades[0, i].each do |g|
        total_pct += (g.points_received / g.item.points) * 100
      end
      pct = total_pct / i
      data << {:date => grade.item.due_date, :average => pct}
      i += 1
    end
    
    # Return performance encoded as JSON
    performance = j.encode(data)
    respond_to do |format|
        format.json  { render :json => performance }
    end
  end
  
  # GET /grades/1
  # GET /grades/1.xml
  def show
    @grade = Grade.find(params[:id])
    
    # Get histogram for THIS assignment
      
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grade }
    end
  end

  # GET /grades/new
  # GET /grades/new.xml
  def new
    @grade = Grade.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grade }
    end
  end

  # GET /grades/1/edit
  def edit
    @grade = Grade.find(params[:id])
  end

  # POST /grades
  # POST /grades.xml
  def create
    @grade = Grade.new(params[:grade])

    respond_to do |format|
      if @grade.save
        format.html { redirect_to(@grade, :notice => 'Grade was successfully created.') }
        format.xml  { render :xml => @grade, :status => :created, :location => @grade }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @grade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /grades/1
  # PUT /grades/1.xml
  def update
    @grade = Grade.find(params[:id])

    respond_to do |format|
      if @grade.update_attributes(params[:grade])
        format.html { redirect_to(@grade, :notice => 'Grade was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /grades/1
  # DELETE /grades/1.xml
  def destroy
    @grade = Grade.find(params[:id])
    @grade.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => 'grades', :action => 'index', :notice => 'Grade was successfully destroyed.') }
      format.xml  { head :ok }
    end
  end
end
