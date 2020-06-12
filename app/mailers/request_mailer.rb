class RequestMailer < ApplicationMailer
	  default from: 'haivan17tclc2@gmail.com'


  def new_request_email user
    @request =  params[:request]
    mail( from: user.email,
    	to: 'haivan17tclc2@gmail.com' , subject: "Request of member Yourdepartment" )
  end

  def sent_member user
  	@request =  params[:request]
  	mail( to: user.email , subject: 'Reply Request of Your manage')
  end

    def disagree_email user
    @request =  params[:request]
    mail( to: user.email , subject: 'Reply Request of Your manage')
  end

end
