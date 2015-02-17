class SurveysController < ApplicationController
  layout 'survey'


  before_filter :authenticate_user!
  skip_authorization_check

  def new
    if current_user.has_survey?
      redirect_to root_path, flash: { error: 'Sie haben den Persönlichkeitstest bereits durchgeführt.' }
    end
  end

  def create
    if current_user.has_survey?
      render text: 'forbidden', status: 403
    elsif survey = create_survey_result(survey_params[:results], current_user)
      render json: survey, status: 201, serializer: SurveyForUserSerializer, root: "survey"
    else # TODO applicaton wide error handling/format
      render text: 'bad request', status: 400
    end
  rescue
    render text: 'bad request', status: 400
  end


  private

  def create_survey_result(results, user)
    survey = current_user.build_survey
    analyzed_results = SurveyAnalyzer.new(results).parse!
    if analyzed_results
      survey.update_attributes!(analyzed_results.survey_data)
      survey
    else
      false
    end
  end

  def survey_params
    params.require(:survey).permit! # TODO more detailed
  end
end
