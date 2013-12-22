require 'spec_helper'

describe Discussion do
  let(:discussion) { FactoryGirl.create(:discussion) }

  	it { discussion.should respond_to(:topic) }
  	it { discussion.should respond_to(:moderator) }
  	it { discussion.should respond_to(:due_date) }
end
