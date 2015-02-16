# require 'rails_helper'
require 'spec_helper'

RSpec.describe SurveysController, :type => :controller do
  let(:user){ create(:user) }
  let(:user_with_survey){ create(:user_with_survey) }


  describe '#create' do
    context '[failing]' do
      it 'returns forbidden if survey already exists' do
        sign_in user_with_survey
        post :create, survey: { results: SurveyResult.new.results }
        expect( response ).to have_http_status(403)
      end

      it 'returns 400 status code if survey could not be created for some reason' do
        sign_in user
        post :create, survey: { results: {} }
        expect( response ).to have_http_status(400)
      end
    end

    context '[valid]' do
      before do
        sign_in user
      end

      it 'creates a new survey record' do
        expect{
          post :create, survey: { results: SurveyResult.new.results }
        }.to change(Survey, :count).by(1)
      end

      it 'returns 201 status code' do
        post :create, survey: { results: SurveyResult.new.results }
        expect( response ).to have_http_status(201)
      end

      it 'returns a json response of survey' do
        post :create, survey: { results: SurveyResult.new.results }
        expect{ JSON.parse(response.body) }.not_to raise_error
      end

      it 'contains all scales but "h"' do
        post :create, survey: { results: SurveyResult.new.results }
        json = JSON.parse(response.body)
        SurveyAnalyzer::SCALES.each{ |scale|
          if scale == "h"
            expect( json['survey'] ).not_to have_key scale
          else
            expect( json['survey'] ).to have_key scale
          end
        }
      end

      it 'contains gender and age' do
        post :create, survey: { results: SurveyResult.new.results }
        json = JSON.parse(response.body)
        expect( json['survey']['statistics'].size ).to eq 2
        expect( json['survey']['statistics'] ).to have_key 'gender'
        expect( json['survey']['statistics'] ).to have_key 'age'
      end
    end
  end
end
