class SurveysController < ApplicationController
  layout 'survey'


  before_filter :authenticate_user!
  skip_authorization_check

  # /survey
  def new
    if current_user.has_survey?
      redirect_to survey_result_path
    end
  end

  # /survey/result
  def show
    if !current_user.has_survey?
      redirect_to survey_path
    else
      @result_data = render_to_string json: current_user.survey, serializer: SurveyForUserSerializer, root: "survey"
      response.headers['Content-Type'] = 'text/html' # ensure normal rendering
    end
  end

  def create
    if current_user.has_survey?
      forbidden
    elsif survey = create_survey_result(survey_params[:results], current_user)
      UserMailer.survey(current_user).deliver_now
      current_user.generate_chart_image!
      render json: survey, status: 201, serializer: SurveyForUserSerializer, root: "survey"
    else
      bad_request
    end
  rescue
    bad_request
  end


  private

  def create_survey_result(results, user)
    survey = current_user.build_survey
    if gender_to_use_answer = results.values.find{ |r| r["id"] == "gender_to_use"}
      gender_to_use = gender_to_use_answer["value"] == "0" ? "male" : "female"
    else
      gender_to_user = current_user.gender
    end

    analyzed_results = SurveyAnalyzer.new(results, gender_to_use, current_user.age_category).parse!
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
