require 'spec_helper'
#    t.string   "topic"
#    t.integer  "moderator_id"
#    t.datetime "due_date"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.integer  "current_question_id"
#    t.integer  "company_id"

describe Discussion do
  before do
  	User.delete_all
  	@discussion = FactoryGirl.build(:discussion)
  end

  subject { @discussion }
  it { should respond_to(:topic) }
  it { should respond_to(:moderator) }
  it { should respond_to(:due_date) }
  it { should respond_to(:current_question) }
  it { should respond_to(:company) }
  it { should respond_to(:questions) }
  it { should be_valid }

  describe "when due_date is not present" do
  	before { @discussion.due_date = nil }
  	it { should_not be_valid }
  end

  it "should return the new current question if a new question is created" do
    question = FactoryGirl.create(:question, discussion: @discussion)
    @discussion.current_question.should eq question
  end

  it "should return the research institute that the discussion belongs to" do
  	@research_institute = FactoryGirl.create(:research_institute)
  	@moderator = FactoryGirl.create(:user, role: Role.where(name: 'moderator').first)
    @discussion.save
  	@moderator.research_institutes << @research_institute
  	@discussion.moderator = @moderator
  	@discussion.research_institute.should eq @research_institute
  end

end
