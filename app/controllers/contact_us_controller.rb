class ContactUsController < ApplicationController

  def show

  end

  def send_mail
    ContactMailer.contact_us(params[:sender_name], params[:sender_email][0], params[:content]).deliver
  end

  def contact_us_params
    params.require(:contact_us).permit(:sender_name, :sender_email, :content)
  end
end
