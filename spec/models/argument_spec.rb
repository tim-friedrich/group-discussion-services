require 'spec_helper'
'
    t.string   "content"
    t.integer  "user_id"
    t.integer  "likes"
    t.integer  "dislikes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
    t.integer  "argument_type_id"'

describe Argument do
  before(:each) do
      User.delete_all
      @argument = FactoryGirl.create(:argument)
  end



  subject{ @argument }
 
  it { should respond_to(:content) }
  it { should respond_to(:user) }
  it { should respond_to(:likes) }
  it { should respond_to(:dislikes) }
  it { should respond_to(:question) }
  it { should respond_to(:argument_type) }

  it { should be_valid }


  describe "when content not present" do
    before { @argument.content = " " }
    it { should_not be_valid }
  end

  describe "when user is not present" do
    before { @argument.user = nil }
    it { should_not be_valid }
  end

  describe "when question is not present" do
    before { @argument.question = nil }
    it { should_not be_valid }
  end

  describe "when argument type is not present" do
    before { @argument.argument_type = nil }
    it { should_not be_valid }
  end 
end
