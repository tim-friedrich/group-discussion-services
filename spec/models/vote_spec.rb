require 'spec_helper'
#    t.integer  "argument_id"
#    t.integer  "user_id"
#    t.boolean  "is_like"
#    t.datetime "created_at"
#    t.datetime "updated_at"

describe Vote do
  before do 
    @vote = FactoryGirl.build(:vote)
  end

  subject { @vote }
  it { should respond_to(:argument) }
  it { should respond_to(:user) }
  it { should respond_to(:is_like) }

  it { should be_valid }

  describe "when argument is not present" do
    before { @vote.argument = nil }
    it { should_not be_valid }
  end 
end