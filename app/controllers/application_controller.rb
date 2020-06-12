class ApplicationController < ActionController::Base
  include StaticPagesHelper
  include ApplicationHelper
private
  def logged_in_user
  	unless log_in?
  		store_location
  		flash[:danger] = "Please log in."
  		redirect_to login_url
  	end
end
  
end
