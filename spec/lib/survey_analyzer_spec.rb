require 'spec_helper'
require 'survey_analyzer'

describe SurveyAnalyzer do
  let(:results){ SurveyResult.new.results }

  describe '#initialize' do
    it 'can be initialized with raw results' do
      expect{ SurveyAnalyzer.new(results) }.not_to raise_error
    end
  end

  describe '#parse!' do
    it 'usually returns self' do
      sa = SurveyAnalyzer.new(results)
      expect( sa.parse! ).to eq sa
    end

    it 'returns nil if input format is not sane' do
      sa = SurveyAnalyzer.new({"0" => {"type" => "big5", "bla"  => "blubb"}})
      expect( sa.parse! ).to be_nil
    end

    it 'sets #points' do
      points = SurveyAnalyzer.new(results).parse!.points
      expect( points ).to be_a Hash
      expect( points ).not_to be_empty
    end

    it 'sets reasonable #points for all scales' do
      points = SurveyAnalyzer.new(results).parse!.points
      SurveyAnalyzer::SCALES.each{ |scale|
        expect( points[scale] ).to be_a Integer
        expect( points[scale] ).to be >= 4
      }
    end

    it 'sets #statistics' do
      statistics = SurveyAnalyzer.new(results).parse!.statistics
      expect( statistics ).to be_a Hash
      expect( statistics ).not_to be_empty
    end

    it 'sets reasonable #statistics for gender' do
      statistics = SurveyAnalyzer.new(results).parse!.statistics
      expect( statistics["gender"] ).to be_a Integer
      expect( statistics["gender"] ).to be <= 1
    end

    it 'sets reasonable #statistics for age' do
      statistics = SurveyAnalyzer.new(results).parse!.statistics
      expect( statistics["age"] ).to be_a Integer
      expect( statistics["age"] ).to be <= 4
    end

    it 'sets #stamines' do
      stamines = SurveyAnalyzer.new(results).parse!.stamines
      expect( stamines ).to be_a Hash
      expect( stamines ).not_to be_empty
    end

    it 'sets reasonable #stamines for all scales' do
      stamines = SurveyAnalyzer.new(results).parse!.stamines
      SurveyAnalyzer::SCALES.each{ |scale|
        expect( stamines[scale] ).to be_a Integer
        expect( stamines[scale] ).to be >= 1
        expect( stamines[scale] ).to be <= 9
      }
    end
  end

  describe '#survey_data' do
    it 'returns a hash of all big 5 stamines and points, prefix _points is used for points' do
      survey_data = SurveyAnalyzer.new(results).parse!.survey_data

      expect( survey_data.size ).to eq 19
      expect( survey_data ).to have_key "statistics"
      expect( survey_data["statistics"] ).to be_a Hash
      SurveyAnalyzer::SCALES.each{ |scale|
        expect( survey_data ).to have_key scale
        expect( survey_data ).to have_key "#{scale}_points"
      }
    end
  end
end