class  CompensationRequestMailer < ApplicationMailer
  def send_email
    @user = params[:user]
    @compensation_request = params[:compensation_request]
    mail(to: 'admin@example.com', subject: "New compensation request from #{@user.email}")
  end
end