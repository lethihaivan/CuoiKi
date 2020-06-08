class ReportsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :logged_in_user, only: [:create, :destroy]
  def create
     @report =  current_user.reports.build(report_params)
  #  @report.request = request
    if @report.save
    #if @report.deliver
      flash.now[:error] = nil
      #redirect_to root_path
      redirect_to "/reports/#{report.id}" , notice: 'Message sent successfully'
    else
      flash.now[:error] = 'Cannot send message'
      render :new
    end
 # end
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
