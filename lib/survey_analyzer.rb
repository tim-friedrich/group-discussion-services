class SurveyAnalyzer
  SCALES = %w[n e c a o lm mm sm h]
  SCALE_NAMES = [
    "Neurotizismus",
    "Extraversion",
    "Gewissenhaftigkeit",
    "Verträglichkeit",
    "Offenheit für Neues",
    "Bedürfnis nach Anerkennung und Leistung",
    "Bedürfnis nach Macht und Einfluss",
    "Bedürfnis nach Sicherheit und Ruhe",
    "Ehrlichkeit",
  ]
  STATISTICS = %w[school degree personal_status income]
  NORM_TABLES = JSON.load File.read Rails.root.join('db', 'survey_norm_tables.json')
  QUESTIONS = JSON.load File.read Rails.root.join('db', 'survey_questions.json')


  attr_reader :points, :stamines, :statistics


  def initialize(raw_results, gender, age_category)
    @results    = raw_results ? raw_results.values : []
    @points     = Hash.new{ |h,k| h[k] = 0 }
    @gender     = gender
    @age_category = age_category
    @stamines   = {}
    @statistics = {}
  end

  def parse!
    parse
  rescue
    return
  end

  def parse
    return if @results.empty?
    build_points_and_statistics!
    build_stamines!

    self
  end

  def survey_data
    @stamines.merge(Hash[@points.map{ |h,k| ["#{h}_points", k]}]).merge(@statistics)
  end


  private

  def build_points_and_statistics!
    @results.each{ |result|
      case result["type"]
      when 'statistic'
        raise ArgumentError, "invalid results, missing a value for <#{result["id"]}>" unless result["value"]
        if STATISTICS.member? result["id"]
          @statistics[result["id"]] = result["value"].to_i
        end
      when 'big5'
        @points[result["scale"]] += normalize_value(result["value"], result["invert"])
      end
    }
  end

  def build_stamines!
    SCALES.each{ |scale|
      @stamines[scale] = 1 + NORM_TABLES[@gender][@age_category][scale].count{ |stamine_reached|
        stamine_reached + 1 < @points[scale]
      }
    }
  end

  def normalize_value(value, invert = nil)
    if value
      invert && invert == "true" ? 4 - value.to_i : 1 + value.to_i
    else
      raise ArgumentError, 'missing a big5 value'
    end
  end
end