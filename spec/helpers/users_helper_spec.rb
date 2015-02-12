require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the QuestionsHelper. For example:
#
# describe QuestionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end

describe UsersHelper do
  include UsersHelper

    let(:user) { create(:user) }
    describe "Role helpers with valid params" do
      describe "Role is user" do
        it "should respond that it is an user" do
          user.role = Role.where(name:'user').first
          user.save
          is_user?(user).should be_truthy
        end
    end

    describe "Role is staff" do
        it "should respond that it is staff" do
          user.role = Role.where(name:'staff').first
          user.save
          is_staff?(user).should be_truthy
        end
    end

    describe "Role is admin" do
        it "should respond that it is an admin" do

          user.role = Role.where(name:'admin').first
          user.save
          is_admin?(user).should be_truthy
        end
    end
  end

  describe "Role helpers with invalid params" do
    it "should not answer that it is an admin" do
      is_admin?(user).should be_falsey
    end

    it "should not answer that it is an staff" do
      is_staff?(user).should be_falsey
    end

    it "staff should not answer that it is an user" do
      user.role = Role.where(name:'staff').first
      user.save
      is_user?(user).should be_falsey
    end
  end
end
