require 'spec_helper'
require 'survey_analyzer'

describe SurveyAnalyzer do
  let(:results){ SurveyResult.new.results }

  def create_analyzer(results, gender="male", age_category="child")
    SurveyAnalyzer.new(results, gender, age_category)
  end

  describe '#initialize' do
    it 'can be initialized with raw results' do
      expect{ create_analyzer(results) }.not_to raise_error
    end
  end

  describe '#parse' do
    it 'usually returns self' do
      sa = create_analyzer(results)
      expect( sa.parse ).to eq sa
    end

    it 'returns nil if input format is not sane' do
      sa = create_analyzer({"0" => {"type" => "big5", "bla"  => "blubb"}})
      expect( sa.parse! ).to be_nil
    end

    it 'sets #points' do
      points = create_analyzer(results).parse.points
      expect( points ).to be_a Hash
      expect( points ).not_to be_empty
    end

    it 'sets reasonable #points for all scales' do
      points = create_analyzer(results).parse.points
      SurveyAnalyzer::SCALES.each{ |scale|
        expect( points[scale] ).to be_a Integer
        expect( points[scale] ).to be >= 4
      }
    end

    it 'sets #statistics' do
      statistics = create_analyzer(results).parse.statistics
      expect( statistics ).to be_a Hash
      expect( statistics ).not_to be_empty
    end

    it 'sets #stamines' do
      stamines = create_analyzer(results).parse.stamines
      expect( stamines ).to be_a Hash
      expect( stamines ).not_to be_empty
    end

    it 'sets reasonable #stamines for all scales' do
      stamines = create_analyzer(results).parse.stamines
      SurveyAnalyzer::SCALES.each{ |scale|
        expect( stamines[scale] ).to be_a Integer
        expect( stamines[scale] ).to be >= 1
        expect( stamines[scale] ).to be <= 9
      }
    end

    it 'creates different stamines for different gender' do
      res = results
      stamines_male = create_analyzer(results, "male").parse.stamines
      stamines_female = create_analyzer(results, "female").parse.stamines
      expect( stamines_male ).not_to eq stamines_female
    end

    it 'creates different stamines for different age category' do
      res = results
      stamines_child = create_analyzer(results, "female", "child").parse.stamines
      stamines_old= create_analyzer(results, "female", "old").parse.stamines
      expect( stamines_child ).not_to eq stamines_old
    end
  end

  describe '#survey_data' do
    it 'returns a hash of all big 5 stamines and points, prefix _points is used for points' do
      survey_data = create_analyzer(results).parse.survey_data

      expect( survey_data.size ).to eq 22
      SurveyAnalyzer::SCALES.each{ |scale|
        expect( survey_data ).to have_key scale
        expect( survey_data ).to have_key "#{scale}_points"
      }
      SurveyAnalyzer::STATISTICS.each{ |stat|
        expect( survey_data ).to have_key stat
      }
    end
  end
end