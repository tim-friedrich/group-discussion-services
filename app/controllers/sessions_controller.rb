class SessionsController < ApplicationController

	def new
	end
	
	def create
		flash[:error] = 'Richtige Email-Adresse oder Passwort'
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to	user
			#Sign the user in and redirect to the user´s show page
		else 
			flash.now[:error] = 'Falsche Email-Adresse oder Passwort'
			render 'new'
		end
	end

	def destroy
		sign_out
    	redirect_to root_url
	end
end
