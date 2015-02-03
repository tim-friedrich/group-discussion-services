class SurveysController < ApplicationController
  layout 'survey'


  before_filter :authenticate_user!


  def new
    if current_user.has_survey?
      redirect_to root_path, flash: { error: 'Sie haben den Persönlichkeitstest bereits durchgeführt.' }
    end
  end

  def create
    render text: 'forbidden', status: 403 if current_user.has_survey?

    if survey = create_survey_result(survey_params[:results], current_user)
      render json: survey.to_json, status: 201
    else
      render text: 'bad request', status: 400
    end
  end


  private

  def create_survey_result(results, user)
    survey = current_user.build_survey
    analyzed_results = Big5Analyzer.new(results).parse!
    if analyzed_results
      survey.update_attributes!(analyzed_results.survey_data)
      survey
    else
      false
    end
  rescue
    false # TODO applicaton wide error handling
  end

  def survey_params
    params.require(:survey).permit! # TODO more detailed
  end
end
