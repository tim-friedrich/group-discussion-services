# require 'rails_helper'
require 'spec_helper'
require 'survey_analyzer'

RSpec.describe Survey, :type => :model do
  let(:survey){ build(:survey) }


  describe 'attributes' do
    SurveyAnalyzer::SCALES.each{ |scale|
      it { expect(survey).to respond_to(:"#{scale}") }
      it { expect(survey).to respond_to(:"#{scale}_points") }
    }
  end

  describe 'validations' do
    it "validates presence of user" do
      survey.user = nil
      expect(survey).to be_invalid
    end

    SurveyAnalyzer::SCALES.each{ |scale|
      it "validates presence of ##{scale}" do
        survey.public_send :"#{scale}=", nil
        expect(survey).to be_invalid
      end

      it "validates presence of ##{scale}_points" do
        survey.public_send :"#{scale}_points=", nil
        expect(survey).to be_invalid
      end
    }
  end
end
