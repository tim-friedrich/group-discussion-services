require 'spec_helper'

describe "User pages" do
	subject { page }

	describe "signup" do
		before { visit new_user_registration_path }
		let(:submit) { "Create User" }

		describe "with valid information" do
			before do
        fill_in "user_username", 		with: "Example"
				fill_in "user_firstname", 		with: "Example"
				fill_in "user_lastname", 			with: "User"
				fill_in "user_email",				with:	"user@example.com"
				fill_in "user_password",			with: "123456789"
				fill_in "user_password_confirmation",	with:	"123456789"
			end

			it "should create a user" do
				expect { click_button 'Benutzer erstellen' }.to change(User, :count).by(1)
			end
	  end
	end
end
