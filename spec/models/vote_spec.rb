require 'spec_helper'
#    t.integer  "argument_id"
#    t.integer  "user_id"
#    t.boolean  "is_like"
#    t.datetime "created_at"
#    t.datetime "updated_at"

describe Vote do
  let(:vote) { FactoryGirl.create(:vote) }

  it { vote.should respond_to(:argument) }
  it { vote.should respond_to(:user) }
  it { vote.should respond_to(:is_like) }
end
