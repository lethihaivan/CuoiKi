class ReportMailer < ApplicationMailer
  default from: 'haivan17tclc2@gmail.com'


  def submission user
    @report =  params[:report]
    mail(to: user.email , subject: 'Report daily #{@report.user.name }')
  end
end
