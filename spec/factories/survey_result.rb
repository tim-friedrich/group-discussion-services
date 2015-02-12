class SurveyResult
  QUESTIONS = JSON.load(Rails.root.join "db", "survey_questions.json")

  def initialize
    @results = {}
    generate_random_results!
  end

  def generate_random_results!
    QUESTIONS.each{ |question|
      case question["type"]
      when 'statistic'
        @results[@results.size.to_s] = {"type" => "statistic", "id" => question["id"], "value" => rand(question["options"].size)}
      when 'big5'
        @results[@results.size.to_s] = {"type" => "big5", "scale" => question["scale"], "invert" => (!!question["invert"]).to_s, "value" => rand(4)}
      end
    }
  end

  def results
    @results
  end
end

