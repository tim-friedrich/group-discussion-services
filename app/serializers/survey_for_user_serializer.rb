class SurveyForUserSerializer < ActiveModel::Serializer
  attributes *(SurveyAnalyzer::SCALES - ["h"]).map(&:to_sym)
  # look up :subject on the model, but use +title+ in the JSON
  # attribute :subject, :key => :title
end