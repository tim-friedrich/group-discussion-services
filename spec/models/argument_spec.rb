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

	let(:argument) { FactoryGirl.create(:argument, user: FactoryGirl.create(:user, email:'a@a.de')) }

  	it { argument.should respond_to(:content) }
  	it { argument.should respond_to(:user) }
  	it { argument.should respond_to(:likes) }
  	it { argument.should respond_to(:dislikes) }
  	it { argument.should respond_to(:question) }
  	it { argument.should respond_to(:argument_type) }
end
