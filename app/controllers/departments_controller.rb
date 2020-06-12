class DepartmentsController < ApplicationController
  before_action :load_department , only: %i(ban edit show destroy update)
  def index
    @users = User.all
    @departments = Department.paginate(page: params[:page])
  end
     def show
   	  #load_user
     @department = Department.find_by id: params[:id]
     @users = @department.users.paginate(page: params[:page],per_page: 3)
   end

      def destroy
         if @department.destroy
          flash[:success] = "Deleted account successfull"
           else
            flash.now[:danger] = "Deleted acount fail!"
          end
     redirect_to departments_url
      #load_user
   end
      def edit
     # load_user
     
   end

    def update
        #load_user
        if @department.update(department_params)
        # Handle a successful update.
        flash[:success]="Profile updated"
        redirect_to @department
        else
          render'edit'
        end
    end
     def load_department
      @department = Department.find(params[:id])
     unless @department
      flash[:danger] = " Departmnet not found : #{params[:id]}!!!"
       redirect_to root_path
      end
    end

       private
      def department_params
          params.require(:department).permit(:department_name)
      end

end
