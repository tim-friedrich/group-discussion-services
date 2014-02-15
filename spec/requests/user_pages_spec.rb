require 'spec_helper'

describe "User pages" do
	subject { page }

	describe "signup" do
		before { visit signup_path }
		let(:submit) { "Create User" }
	
		describe "with valid information" do
			before do
				fill_in "user_firstname", 		with: "Example"
				fill_in "user_lastname", 			with: "User"
				fill_in "user_email",				with:	"user@example.com"
				fill_in "user_password",			with: "foobar"
				fill_in "user_password_confirmation",	with:	"foobar"
			end
	
			it "should create a user" do
				expect { click_button 'Create User' }.to change(User, :count).by(1)
			end

		
		 let(:submit) { "Create User" }
		 
		describe "after saving the user" do
			before { click_button submit }
			let(:user) { User.find_by(email: 'user@example.com') }

			it { should have_link('Abmelden') }
		end
	end


	end
end
