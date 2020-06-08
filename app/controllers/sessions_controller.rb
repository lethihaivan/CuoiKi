class SessionsController < ApplicationController
  #layout 'sessions', only: [:home]
  def new
  end
  def create
  	# tim user theo email
  	#neu user ton tai thi xu li check pass
  	#neu user k ton tai thif tra ve lo
  	@user = User.find_by(email: params[:session][:email].downcase)
    if @user  && @user.authenticate(params[:session][:password])
       if @user.activated?
        login_user @user
        params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
        redirect_to @user
        else
          message = "Account not activated. Check your email for the activation link."
          flash[:warning] = message
          redirect_to root_url
        end
         
       # ma hoa token 

       # luu vao use tai cot token

      # kiem tra user co remenber k
      # neu co remenber
        # luu phien dang nhap
      # neu k
       # xoa remneber

       
  	else
       flash.now[:danger] = 'Invalid email/password combination'
       render :new
  	end
  end

   def destroy
    forget (current_user)
   # log_out if logged_in?
    #redirect_to root_url
    session.delete(:user_id)
    current_user = nil
    flash[:success] = "Logout  successfull!"
    redirect_to root_path
  end
end
