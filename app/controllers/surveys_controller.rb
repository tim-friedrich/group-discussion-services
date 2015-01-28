class SurveysController < ApplicationController
  layout 'survey'


  before_filter :authenticate_user!


  def new
    # TODO don't allow if test result is already present for user
  end

  def create
    create_survey_result(survey_params[:results], current_user)
    render text: '\o/', status: 201
  end


  private

  def create_survey_result(results, user)
    # code
    puts "---------------------------------CREATING-SURVEY-----------------"
    puts "-----------------------------------USER: #{user.username}"
    p results
  end

  def survey_params
    params.require(:survey).permit! # TODO more detailed
  end
end
