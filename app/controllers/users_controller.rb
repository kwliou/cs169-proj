class UsersController < ApplicationController
  before_filter :get_user # :get_user works on Heroku BUT WHY???
  before_filter :get_current_user, :except => [:new, :create]
  # GET /users
  # GET /users.xml
  def index
    #@current_user = User.find(params[:id])
    @users = User.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @current_user }
    end
  end
  
  def performance
    user = User.find(params[:id])
    data = user.performance()
    
    # Return performance encoded as JSON
    performance = ActiveSupport::JSON.encode(data)
    respond_to do |format|
        format.json  { render :json => performance }
    end
  end
  
  # GET /users/1
  # GET /users/1.xml
  def show
    #@user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    #@user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
#        ActionMailer::Base.smtp_settings = {
#          :address        => "smtp.sendgrid.net",
#          :port           => "25",
#          :authentication => :plain,
#          :user_name      => ENV['SENDGRID_USERNAME'],
#          :password       => ENV['SENDGRID_PASSWORD'],
#          :domain         => ENV['SENDGRID_DOMAIN']
#        }
        UserMailer.deliver_welcome(@user)
        format.html { redirect_to root_url }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    #@user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    #@user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
private
  def get_current_user
    @current_user = current_user
    redirect_to root_url if @current_user.nil?
  end

  def get_user
    @user = User.find_by_username(params[:id]) if params[:id]
  end