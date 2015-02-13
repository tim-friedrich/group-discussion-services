class StaticPagesController < ApplicationController
  def send_contact_mail
    ContactMailer.contact_us(params[:sender_name], params[:sender_email][0], params[:content]).deliver
  end

  def home
    if current_user
      redirect_to '/profile'
    end
  end

  def contact_us

  end

  def impress

  end

  def contact_us_params
    params.require(:contact_us).permit(:sender_name, :sender_email, :content)
  end
end
