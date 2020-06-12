class ReportsController < ApplicationController
  skip_before_action :verify_authenticity_token
 # before_action :logged_in_user, only: [:create, :destroy]
  def create
    @user = current_user
     @report =  current_user.reports.build(report_params)
    if @report.save
      ReportMailer.with(report: @report).submission(@user).deliver_now
      flash.now[:error] = nil
      redirect_to root_path , notice: 'Message sent successfully' #@report
    else
      flash.now[:error] = 'Cannot send message'
      render :new
    end
  end
  def new
      @report = Report.new
  end

   private
      def report_params
          params.require(:report).permit(:plan_daily, :actual_work, :next_plan,
          :issue, :time_submit , :user_id) 
     end
   
end