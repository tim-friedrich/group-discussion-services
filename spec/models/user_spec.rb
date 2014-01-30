require 'spec_helper'

describe User do 
	before(:each) do 
		@user = FactoryGirl.build(:user)
	end
	
	after(:each) do
		User.delete_all
	end

	subject { @user }

	it { should respond_to(:lastname) }
	it { should respond_to(:firstname) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:remember_token) }
	it { should respond_to(:role) }

	it { should be_valid }

	#Test not optional parameters of Users 
	describe "when firstname is not present" do
		before { @user.firstname = " " }
		it { should_not be_valid }
	end	
	describe "lastname is not present" do
		before { @user.lastname = " " }
		it { should_not be_valid }
	end	
	describe "email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end	

	#Tests max length of parameters
	describe "the firstName is to long" do
		before { @user.firstname = "a"*51 }
		it { should_not be_valid }
	end
	describe "the surname is to long" do
		before { @user.lastname = "a"*51 }
		it { should_not be_valid }
	end
	describe "the email is to long" do
		before { @user.email = "a"*45+"@a.com" }
		it { should_not be_valid }
	end
	
	#Tests the email validation
	describe "email format is valid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com ]
	
			addresses.each do | invalid_address |
			 @user.email = invalid_address
			 @user.should_not be_valid 
			end
		end
	end
	
	describe "email format is invalid" do
		it "should be valid" do
			addresses = %w[ user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn ]
		
			addresses.each do | invalid_address |
				@user.email = invalid_address
				@user.should be_valid 
			end
		end
	end

	describe "email address is already taken" do
		before do 
			user_with_same_email = @user.dup
			user_with_same_email.save
		end
		
		it { should_not be_valid }
	end

	#tests for passwords
	describe "password is not present" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end

	describe "password doesn´t match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "password confirmation is nil" do
		before { @user.password_confirmation = nil } 
		it { should_not be_valid }
	end
		
	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by_email(@user.email) }

		describe "with valid password" do
			it { should == found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }
		
			it { should_not == user_for_invalid_password }
			specify { user_for_invalid_password.should be_false }
		end
	end

	describe "with a password that´s to short" do
		before { @user.password = @user.password_confirmation = "a"*5 }
		it { should be_invalid }
	end

	describe "remember_token" do 
		before { @user.save }
		its(:remember_token) { should_not be_blank }
	end

end
