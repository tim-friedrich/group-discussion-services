class Big5Analyzer
  SCALES = %w[n e c a o lm mm sm h]
  NORM_TABLES = JSON.load File.read Rails.root.join('config', 'norm_tables.json')


  attr_reader :points, :stamines, :statistics


  def initialize(raw_results)
    @results    = raw_results.values
    @points     = Hash.new{ |h,k| h[k] = 0 }
    @stamines   = {}
    @statistics = {}
  end

  def parse!
    build_points_and_statistics!
    build_stamines!

    self
  rescue
    return
  end

  def build_points_and_statistics!
    @results.each{ |result|
      case result["type"]
      when 'statistic'
        @statistics[result["id"]] = result["value"].to_i
      when 'big5'
        @points[result["scale"]] += normalize_value(result["value"], result["invert"])
      end
    }
  end

  def build_stamines!
    gender = @statistics["gender"] == 0 ? "female" : "male"
    age =
      case @statistics["age"]
      when 0
        "child"
      when 4
        "old"
      else
        "young"
      end

    SCALES.each{ |scale|
      @stamines[scale] = 1 + NORM_TABLES[gender][age][scale].count{ |stamine_reached|
        stamine_reached + 1 < @points[scale]
      }
    }
  end

  def survey_data
    @stamines.merge Hash[@points.map{ |h,k| ["#{h}_points", k]}]
  end

  def normalize_value(value, invert = nil)
    if value
      invert && invert == "true" ? 4 - value.to_i : 1 + value.to_i
    end
  end
end