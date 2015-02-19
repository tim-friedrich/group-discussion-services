require 'survey_analyzer'


class Survey < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true

  SurveyAnalyzer::SCALES.each{ |scale|
    validates :"#{scale}", presence: true
    validates :"#{scale}_points", presence: true
  }

  SurveyAnalyzer::STATISTICS.each{ |stat|
    define_method :"#{stat}_value" do
      SurveyAnalyzer::QUESTIONS.find{ |q| q["id"] == stat.to_s }["options"][public_send(stat.to_sym)]
    end
  }

  def gender_and_age
    {
      "gender" => user.gender,
      "age" => user.age_category,
    }
  end
end
