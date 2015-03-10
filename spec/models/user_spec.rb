require 'spec_helper'

describe User do
  let(:user){ build(:user) }
  let(:user_with_survey){ build(:user_with_survey) }

  subject { user }


  # # #
  # Fields

  it { should respond_to(:lastname) }
  it { should respond_to(:firstname) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:role) }
  it { should respond_to(:gender) }
  it { should respond_to(:birthday) }
  it { should respond_to(:zipcode) }
  it { should respond_to(:country) }
  it { should respond_to(:city) }
  it { should respond_to(:phone) }
  it { should respond_to(:industry) }
  it { should respond_to(:pseudonym_policy) }
  it { should respond_to(:can_be_called) }


  # # #
  # Validations

  it { should be_valid }


  # Optional fields

  describe "when firstname is not present" do
    before { user.firstname = " " }
    it { should_not be_valid }
  end

  describe "lastname is not present" do
    before { user.lastname = " " }
    it { should_not be_valid }
  end

  describe "email is not present" do
    before { user.email = " " }
    it { should_not be_valid }
  end

  describe "gender is not present" do
    before { user.gender = " " }
    it { should_not be_valid }
  end

  describe "birthday is not present" do
    before { user.birthday = nil }
    it { should_not be_valid }
  end

  describe "zipcode is not present" do
    before { user.zipcode = nil }
    it { should_not be_valid }
  end

  describe "country is not present" do
    before { user.country = nil }
    it { should_not be_valid }
  end

  describe "city is not present" do
    before { user.city = nil }
    it { should_not be_valid }
  end

  describe "pseudonym_policy is not present" do
    before { user.pseudonym_policy = false }
    it { should_not be_valid }
  end


  # Format / length

  describe "firstname is too long" do
    before { user.firstname = "a"*101 }
    it { should_not be_valid }
  end

  describe "surname is too long" do
    before { user.lastname = "a"*101 }
    it { should_not be_valid }
  end

  describe "email is too long" do
    before { user.email = "a"*101+"@a.com" }
    it { should_not be_valid }
  end

  describe "gender is too long" do
    before { user.gender = "a"*11 }
    it { should_not be_valid }
  end

  describe "zipcode is too long" do
    it 'has not more than 10 chars' do
      user.zipcode = "34534534534534534543532454"
      expect( user ).to be_invalid
    end
  end

  describe "country is too long" do
    it 'has not more than 100 chars' do
      user.country = "a"*101
      expect( user ).to be_invalid
    end
  end

  describe "city is too long" do
    it 'has not more than 100 chars' do
      user.city = "a"*101
      expect( user ).to be_invalid
    end
  end

  describe "phone is too long" do
    it 'has not more than 100 chars' do
      user.phone = "a"*101
      expect( user ).to be_invalid
    end
  end

  describe "industry is too long" do
    it 'has not more than 100 chars' do
      user.industry = "a"*101
      expect( user ).to be_invalid
    end
  end

  describe "email format is valid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. ]

      addresses.each do | invalid_address |
       user.email = invalid_address
       user.should_not be_valid
      end
    end
  end

  describe "email format is invalid" do
    it "should be valid" do
      addresses = %w[ user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn ]

      addresses.each do | invalid_address |
        user.email = invalid_address
        user.should be_valid
      end
    end
  end

  describe "email address is already taken" do
    before do
      user_with_same_email = user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "password is not present" do
    before { user.password = user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "password doesn't match confirmation" do
    before { user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { user.password = user.password_confirmation = "a"*5 }
    it { should be_invalid }
  end


  # # #
  # Misc

  it "should respond the full name of the user" do
    user.full_name.should eq "%{firstname} %{lastname}" \
        % { firstname: user.firstname, lastname: user.lastname }
  end

  it "should respond the username from the referenced discussion" do
    user_with_survey.save
    discussion = create(:discussion)
    discussion.users << user_with_survey
    discussions_user = discussion.discussions_users.where(user_id: user_with_survey.id).first
    discussions_user.save
    expect(discussions_user.name).to eq user_with_survey.username discussion
  end

  describe "#has_survey?" do
    it 'returns false if user has no related survey' do
      expect( user.has_survey? ).to be false
    end

    it 'returns true if user has a related survey' do
      expect( user_with_survey.has_survey? ).to be true
    end
  end

  describe '#age' do
    it 'returns an integer' do
      expect( user.age ).to be_a Integer
    end

    it 'returns the age, calculated from birthday' do
      user.birthday = Date.today - 23.years
      expect( user.age ).to eq 23
    end
  end

  describe '#age_category' do
    it 'is "child" for users < 20' do
      user.birthday = Date.parse "2014-12-31"
      expect( user.age_category ).to eq "child"
    end

    it 'is "young" for users >= 20 and < 50' do
      user.birthday = Date.parse "1990-12-31"
      expect( user.age_category ).to eq "young"
    end

    it 'is "old" for users > 50' do
      user.birthday = Date.parse "1950-12-31"
      expect( user.age_category ).to eq "old"
    end
  end


  # # #
  # Discussion functionality

  describe "user was added to discussion" do
    let(:discussion){ FactoryGirl.create(:discussion) }

    before do
      discussion.users << user
    end


    it "should respond that it is part of discussion" do
      user.is_part_of_discussion?(discussion).should be_truthy
    end

    it "should respond that it is not part of discussion when it is no longer part of the discussion" do
      discussion.users.find_by_email(user.email).delete
      user.is_part_of_discussion?(discussion).should be_falsey
    end

    describe "when user enters discussion" do
      before { user.enter_discussion(discussion) }

      it "should create a new Discussion Presence for the user" do
        DiscussionPresence.last.user.should eq user
      end
      it "should register the User as present" do
        DiscussionPresence.last.present.should be_truthy
      end
      it "should respond that he/she is present" do
        user.is_present_in(discussion).should be_truthy
      end
    end

    describe "when user enters discussion" do
      before { user.leave_discussion(discussion) }

      it "should create a new Discussion Presence for the user" do
        DiscussionPresence.last.user.should eq user
      end
      it "should register the User not as present" do
        DiscussionPresence.last.present.should be_falsey
      end
      it "should respond that he/she is not present" do
        user.is_present_in(discussion).should be_falsey
      end
    end
  end

  describe "should respond the right role" do
    it "moderator should respond that it is staff" do
      user.role = Role.where(name: 'moderator').first
      user.is_staff?.should be_truthy
    end

    it "user should not respond that it is staff" do
      user.role = Role.where(name: 'user').first
      user.is_staff?.should be_falsey
    end
  end


  # # #
  # charts

  describe "charts methods" do
    before do
      FileUtils.rm_rf Rails.root.join('data', 'test', 'charts', 'user')
      FileUtils.mkdir_p Rails.root.join('data', 'test', 'charts', 'user')
    end

    after :all do
      FileUtils.rm_rf Rails.root.join('data', 'test', 'charts', 'user')
    end


    describe '#has_chart_image?' do
      it 'checks if chart image exists by calling ChartImage with the user' do
        expect( ChartImage ).to receive(:exists?).with(user_with_survey, "test")
        user_with_survey.has_chart_image?
      end
    end

    describe '#chart_image_path' do
      it 'returns the file system path to the image by calling ChartImage with the user' do
        expect( ChartImage ).to receive(:path_for).with(user_with_survey, "test")
        user_with_survey.chart_image_path
      end
    end

    describe '#generate_chart_image!' do
      it 'generates a new chart image png by creating a ChartImage instance with the user and calling #generate! on it' do
        expect( ChartImage ).to receive(:new).with(user_with_survey, "test").and_call_original
        expect_any_instance_of( ChartImage ).to receive(:generate!)
        user_with_survey.generate_chart_image!
      end
    end

    describe '#ensure_chart_image!' do
      before do
        user_with_survey.save!
      end

      it 'does nothing if chart image is present' do
        user_with_survey.generate_chart_image!
        expect( user_with_survey ).not_to receive(:generate_chart_image!)
        user_with_survey.ensure_chart_image!
      end

      it 'does nothing if user has no survey' do
        expect( user ).not_to receive(:generate_chart_image!)
        user.ensure_chart_image!
      end

      it 'calls #generate_chart_image! in all other cases' do
        expect( user_with_survey ).to receive(:generate_chart_image!)
        user_with_survey.ensure_chart_image!
      end
    end
  end
end
