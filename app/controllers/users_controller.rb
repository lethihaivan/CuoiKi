class UsersController < ApplicationController

	before_action :login? , only: %i(show edit update)
  before_action :load_user , only: %i(show edit update destroy)
   before_action :correct_user? , only: %i(edit update)
 
   def show
   	  #load_user
      @reports = @user.reports.paginate(page: params[:page])
   end
 
   def new
   	@user = User.new
   end

  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end

  def create
   	   @user = User.new(user_params)
   	   if @user.save
           @user.send_activation_email
           flash[:success] = "Create acount successfull!"
           redirect_to @user
       else
       	    flash.now[:danger] = "Create acount fail!"
            render 'new'
       end
   end

   def edit
     # load_user
     
   end

   def update
        #load_user
        if@user.update(user_params)
        # Handle a successful update.
        flash[:success]="Profile updated"
        redirect_to @user
        else
          render'edit'
        end
    end
 def destroy
   if @user.destroy
    flash[:success] = "Deleted account successfull"
  else
    flash.now[:danger] = "Deleted acount fail!"
  end
     redirect_to users_url
  end


    def correct_user?
      if @user != current_user
      flash.now[:danger] = "Access denied"
      redirect_to root_path
      end
    end

    def load_user
      @user = User.find(params[:id])
     unless @user
      flash[:danger] = " USer not found : #{params[:id]}!!!"
       redirect_to root_path
      end
    end

   private
      def user_params
          params.require(:user).permit(:name, :email, :password,
          :password_confirmation, :role , :department_name)
      end
end