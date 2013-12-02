require 'spec_helper'

describe GroupDiscussion do
  before do
  	@group_discussion = GroupDiscussion.create(name:"test", description:"test", appointment: DateTime.new(2013, 10, 10))
  end

  subject { @group_discussion }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:appointment) }
end
