require 'spec_helper'

describe Question do
	before(:each) do
		@question = FactoryGirl.create(:question) 
  	end

  	after(:each) do
  		@question.delete
  	end

  	subject { @question }

  	it { should respond_to(:topic) }
  	it { should respond_to(:discussion) }
end
