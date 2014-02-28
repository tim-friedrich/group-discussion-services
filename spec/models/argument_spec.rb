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
  before(:each) do
    @argument = FactoryGirl.build(:argument, 
                                      content: "ASD",
                                      question: FactoryGirl.create(:question, 
                                        discussion: @discussion), 
                                      discussion: @discussion)
  end

  subject{ @argument }
 
  it { should respond_to(:content) }
  it { should respond_to(:user) }
  it { should respond_to(:likes) }
  it { should respond_to(:dislikes) }
  it { should respond_to(:question) }
  it { should respond_to(:argument_type) }

  it { should be_valid }

  describe "when content not present" do
    #@argument = Argument.create()
    puts "A"*50
    puts @argument.content
    it {  }
  end
end
