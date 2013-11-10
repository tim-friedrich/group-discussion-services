require 'test_helper'

class UserTest < ActiveSupport::TestCase
	describe User do 
		before do 
			@user = User.new(firstName: "karl", surname: "Peterson", email: "karl@example.com")
		end
	
		subject { @user }

		it { should respond_to(:surname) }
		it { should respond_to(:firstName) }
		it { should respond_to(:email) }

		it { should be_valid }

		describe "when name is not present" do
			before { @user.name = " " }
			it { should_not be_valid }
	end
end
