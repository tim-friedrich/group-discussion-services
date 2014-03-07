require 'spec_helper'

describe Question do
	before(:each) do
		User.delete_all
		@question = FactoryGirl.create(:question) 
  	end

  	after(:each) do
  		@question.delete
  	end

  	subject { @question }

  	it { should respond_to(:topic) }
  	it { should respond_to(:discussion) }

  	describe "when topic is not present" do
  		before { @question.topic = nil }
  		it { should_not be_valid }
  	end
end
