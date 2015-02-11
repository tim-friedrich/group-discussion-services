class SurveyForUserSerializer < ActiveModel::Serializer
  attributes *(SurveyAnalyzer::SCALES - ["h"]).map(&:to_sym)
  attribute :gender_and_age, key: :statistics
end