class UsersController < ApplicationController

	before_action :login? , only: %i(show edit update)
  before_action :load_user , only: %i(show edit update destroy)
   #before_action :correct_user? , only: %i(edit update)
   def show
     #@report = current_user.reports.build
     @reports =  @user.reports.paginate(page: params[:page],per_page: 8)
     @requests =  @user.requests.paginate(page: params[:page],per_page: 8)
   end
 
   def new
   	@user = User.new
   end
   def ban 
      @department = Department.new
      @user = User.find(params[:id])
      @user.update_attribute(:department_id,:null)
      redirect_to @department, :notice => "User removed my department!"
    end
    def adduser
      @department = Department.new
      @user = User.find(params[:id])
      depar_id = current_user.department_id
    if @user.update_attribute(:department_id, depar_id)
      @user.save
     redirect_to @department, :flash => { :success => "Add successfull! #{@user.department_id}" }
    else
     redirect_to @department , :flash => { :error => "Failed to add! #{depar_id}" }
    end
      
    end
  def index
    @users = User.paginate(page: params[:page])
  end
  def create
   	   @user = User.new(user_params)
   	   if @user.save
           @user.send_activation_email
           flash[:success] = "Create acount successfull!"
           redirect_to @user
       else
       	    flash.now[:danger] = "Create acount Fails!"
            render 'new'
       end
   end

   def edit
     # load_user
     
   end

   def update
         #@user = User.all
        if @user.update(user_params)
        # Handle a successful update.
        flash[:success]="Profile updated"
        redirect_to @user
        else
          render'edit'
        end
    end
    def search  
      @results = User.all
      if params[:search]
        @results = User.search(params[:search]).order("created_at DESC").paginate(page: params[:page],per_page: 5)
      else
        @results = User.all.order("created_at DESC").paginate(page: params[:page],per_page: 5)
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
      @user = User.find_by id: params[:id]
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