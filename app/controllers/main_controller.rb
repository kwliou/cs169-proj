class MainController < ApplicationController
  def index
    @current_user = current_user
    @courses = Course.all
    @user_session = UserSession.new
    respond_to do |format|
      format.html # index.html.erb
      # format.xml  { render :xml => @courses }
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

