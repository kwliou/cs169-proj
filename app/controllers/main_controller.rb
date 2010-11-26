class MainController < ApplicationController

  def index
    @current_user = current_user
    @courses = @current_user.courses if @current_user
    @user_session = UserSession.new
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def about
    @current_user = current_user
    @user_session = UserSession.new
    respond_to do |format|
      format.html # about.html.erb
    end
  end

  def feedback
    @current_user = current_user
    @user_session = UserSession.new
    respond_to do |format|
      format.html # feedback.html.erb
    end
  end
  
  def send_feedback
    UserMailer.deliver_feedback(params[:body])
    #UserMailer.deliver_welcome(@current_user)
    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end

  def help
    @current_user = current_user
    @user_session = UserSession.new
    respond_to do |format|
      format.html # help.html.erb
    end
  end
  
  def mobile
    @current_user = current_user
    @courses = Course.all
    @user_session = UserSession.new
    respond_to do |format|
      format.html # index.html.erb
      # format.xml  { render :xml => @courses }
    end
  end
end