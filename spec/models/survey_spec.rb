require 'spec_helper'
require 'survey_analyzer'


RSpec.describe Survey, :type => :model do
  let(:survey){ F.build_stubbed(:survey) }


  describe 'attributes' do
    SurveyAnalyzer::SCALES.each{ |scale|
      it { expect(survey).to respond_to(:"#{scale}") }
      it { expect(survey).to respond_to(:"#{scale}_points") }
    }
    it { expect(survey).to respond_to(:school) }
    it { expect(survey).to respond_to(:degree) }
    it { expect(survey).to respond_to(:personal_status) }
    it { expect(survey).to respond_to(:income) }
  end

  describe 'validations' do
    it "validates presence of #user" do
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

  describe '#school_value' do
    it 'returns normalized a string from questions' do
      survey.school = 0
      expect( survey.school_value ).to eq "Hauptschule"
    end
  end

  describe '#degree_value' do
    it 'returns normalized a string from questions' do
      survey.degree = 1
      expect( survey.degree_value ).to eq "Meister"
    end
  end

  describe '#personal_status_value' do
    it 'returns normalized a string from questions' do
      survey.personal_status = 2
      expect( survey.personal_status_value ).to eq "Ich bin Angestellter."
    end
  end

  describe '#income_value' do
    it 'returns normalized a string from questions' do
      survey.income = 3
      expect( survey.income_value ).to eq "5000 - 7000 EURO"
    end
  end


  describe '#gender_and_age' do
    it 'hash of only the gender and age category from user' do
      expect( survey.gender_and_age ).to be_a Hash
      expect( survey.gender_and_age.size ).to eq 2
    end
  end

  describe '#scale_values' do
    it 'returns an array of all scale in the order of SCALES' do
      expect( survey.scale_values ).to be_a Array
      expect( survey.scale_values.size ).to eq 9
      expect( survey.scale_values[0] ).to be_a Integer
    end
  end
end
