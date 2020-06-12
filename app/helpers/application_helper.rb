module ApplicationHelper
      def time_ago_in_words(from_time, options = {})
        distance_of_time_in_words(from_time, Time.now, options)
      end
	def login_user user
		session[:user_id] = user.id
	end
	def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
        end
        end
      end
    
      def login?
      	return if current_user
      		flash.now[:danger] = "You need login!"
            redirect_to login_path
        end
     def remember user
     	user.remember
       cookies.permanent[:remember_token] = user.remember_token
       cookies.permanent.signed[:user_id] = user.id
     	
     end
     def forget user
     	   user.forget
         cookies.delete(:remember_token)
         cookies.delete(:user_id)
     	
     end
     # Redirects to stored location (or to the default).
     def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end
# Stores the URL trying to be accessed.
    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end
end
