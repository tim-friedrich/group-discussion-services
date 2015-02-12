require 'survey_analyzer'

class Survey < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true

  SurveyAnalyzer::SCALES.each{ |scale|
    validates :"#{scale}", presence: true
    validates :"#{scale}_points", presence: true
  }

  serialize :statistics

  def gender_and_age
    {
      "gender" => statistics["gender"],
      "age" => statistics["age"]
    }
  end
end
