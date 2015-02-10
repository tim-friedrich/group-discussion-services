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
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:role) }

  it { should be_valid }

  it "should respond the full name of the user" do
    @user.full_name.should eq "%{firstname} %{lastname}" \
        % { firstname: @user.firstname, lastname: @user.lastname }
  end

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
  describe "the firstname is to long" do
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
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. ]

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

  describe "with a password that´s to short" do
    before { @user.password = @user.password_confirmation = "a"*5 }
    it { should be_invalid }
  end

  #tests for discussion functionalities
  describe "user was added to discussion" do
    before do
      @discussion = FactoryGirl.create(:discussion)
      @discussion.users << @user
    end

    it "should respond that it is part of discussion" do
      @user.is_part_of_discussion?(@discussion).should be_truthy
    end

    it "should respond that it is not part of discussion when it is no longer part of the discussion" do
      @discussion.users.find_by_email(@user.email).delete
      @user.is_part_of_discussion?(@discussion).should be_falsey
    end

    describe "when user enters discussion" do
      before { @user.enter_discussion(@discussion) }

      it "should create a new Discussion Presence for the user" do
        DiscussionPresence.last.user.should eq @user
      end
      it "should register the User as present" do
        DiscussionPresence.last.present.should be_truthy
      end
      it "should respond that he/she is present" do
        @user.is_present_in(@discussion).should be_truthy
      end
    end

    describe "when user enters discussion" do
      before { @user.leave_discussion(@discussion) }

      it "should create a new Discussion Presence for the user" do
        DiscussionPresence.last.user.should eq @user
      end
      it "should register the User not as present" do
        DiscussionPresence.last.present.should be_falsey
      end
      it "should respond that he/she is not present" do
        @user.is_present_in(@discussion).should be_falsey
      end
    end
  end

  describe "should respond the right role" do
    it "moderator should respond that it is staff" do
      @user.role = Role.where(name: 'moderator').first
      @user.is_staff?.should be_truthy
    end

    it "user should not respond that it is staff" do
      @user.role = Role.where(name: 'user').first
      @user.is_staff?.should be_falsey
    end
  end
end
