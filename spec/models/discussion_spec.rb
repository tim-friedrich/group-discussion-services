require 'spec_helper'
#    t.string   "topic"
#    t.integer  "moderator_id"
#    t.datetime "due_date"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.integer  "current_question_id"
#    t.integer  "company_id"

describe Discussion do
  let(:discussion) { FactoryGirl.create(:discussion, current_question_id: FactoryGirl.create(:question).id) }

  	it { discussion.should respond_to(:topic) }
  	it { discussion.should respond_to(:moderator) }
  	it { discussion.should respond_to(:due_date) }
  	it { discussion.should respond_to(:current_question) }
  	it { discussion.should respond_to(:company) }
  	it { discussion.should respond_to(:questions) }
end
