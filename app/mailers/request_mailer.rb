class RequestMailer < ApplicationMailer
	  default from: 'haivan17tclc2@gmail.com'


  def new_request_email user
    @request =  params[:request]
    mail(to: user.email , subject: 'Request of #{@request.user.name }')
  end
end
