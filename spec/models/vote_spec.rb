require 'spec_helper'
#    t.integer  "argument_id"
#    t.integer  "user_id"
#    t.boolean  "is_like"
#    t.datetime "created_at"
#    t.datetime "updated_at"

describe Vote do
	let(:discussion) { FactoryGirl.create(:discussion, current_question: FactoryGirl.create(:question)) }
  	let(:vote) { FactoryGirl.create(:vote,
                                argument: FactoryGirl.create(:argument, 
                                    question: Question.create(topic: "ASDasd",
                                        discussion: FactoryGirl.create(:discussion, current_question: FactoryGirl.create(:question))), 
                                    discussion: FactoryGirl.create(:discussion, current_question: FactoryGirl.create(:question)),
                                	user: FactoryGirl.create(:user)),
                                user: FactoryGirl.create(:user)) }

  it { vote.should respond_to(:argument) }
  it { vote.should respond_to(:user) }
  it { vote.should respond_to(:is_like) }
end
