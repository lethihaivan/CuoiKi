class ApplicationController < ActionController::Base
  include StaticPagesHelper
  include ApplicationHelper
private
  def logged_in_user
  	unless logged_in?
  		store_location
  		flash[:danger] = "Please log in."
  		redirect_to login_url
  	end
end
  
end
