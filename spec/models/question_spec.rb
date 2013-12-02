require 'spec_helper'

describe Question do
	before do
		@group_discussion = GroupDiscussion.create(name:"test", description:"test", appointment: DateTime.new(2013, 10, 10))
  		@question = Question.create(topic: "a big question", discription: "thing about it", group_discussion_id: @group_discussion.id)
  	end

  	subject { @question }

  	it { should respond_to(:topic) }
  	it { should respond_to(:discription) }
  	it { should respond_to(:group_discussion) }
end
