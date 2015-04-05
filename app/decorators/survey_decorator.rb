module SurveyDecorator
  ANALYSIS_TEXTS = JSON.load Rails.root.join("db", "survey_analysis_texts.json")

  def scales
    SurveyAnalyzer::SCALES
  end

  def scales_without_honesty
    scales - ["h"]
  end

  def all_scales_with_names
    scales.map{ |scale_name|
      scale_with_name(scale_name)
    }.join "\n"
  end

  def scale_with_name(scale_name)
    "#{public_send scale_name.to_sym} - #{ANALYSIS_TEXTS[scale_name.to_s]["title"]}"
  end

  def scale_analysises
    scales_without_honesty.map{ |scale_name|
      ANALYSIS_TEXTS[scale_name.to_s].merge("short" => scale_name)
    }
  end
end