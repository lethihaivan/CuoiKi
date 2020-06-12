class RequestsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :load_request , only: %i( show edit update destroy)
	def new
		@request = Request.new
	end
	def show
		@request = Request.find_by id: params[:id]
		@user = @request.user
		#@user = User.find_by id: params[:id]
		#@requests =  @user.requests.paginate(page: params[:page],per_page: 8)
	end
	def update
        #load_user
       if  @request.update(request_params) 
        flash[:success]="Request updated"
        redirect_to @request
      else
    	render'edit'
    end
end
def destroy
	if @request.destroy
		flash[:success] = "Deleted Request successfull"
	else
		flash.now[:danger] = "Deleted Request fail!"
	end
	redirect_to root_path
end
def edit

end
def create
	@user = current_user
	@request =  current_user.requests.build(request_params)
	if @request.save
		RequestMailer.with(request: @request).new_request_email(@user).deliver_now
		flash.now[:error] = nil
      redirect_to root_path , notice: 'Message sent successfully' #@report
  else
  	flash.now[:error] = 'Cannot send message'
  	render :new
  end
end
def load_request
	@request = Request.find_by id: params[:id]
	unless @request
		redirect_to root_path
	end
end
def approve_agree
	
	@request = Request.find_by id: params[:id]
	@user = @request.user
    if @request.update_attribute :status , 1
    RequestMailer.with(request: @request).sent_member(@user).deliver_now
    @request.save
    redirect_to request_path(request), :flash => { :success => "agree successfull!" }
    end
end


def approve_disagree
    @request = Request.find_by id: params[:id]
    @user = @request.user
    if @request.update_attribute :status , 2
    @request.save
    RequestMailer.with(request: @request).disagree_email(@user).deliver_now
    redirect_to request_path(@request) ,:flash => { :error => "Disagree !" }
    end
end
def request_params
	params.require(:request).permit(:type_request, :time_late_to, :time_late_from,
		:time_back_early_to, :time_back_early_from , :time_add_to, :time_add_from,
		:time_out_to, :time_out_from , :reason ,:status , :user_id) 
end
end
