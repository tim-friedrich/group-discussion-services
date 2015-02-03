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

    if create_survey_result(survey_params[:results], current_user)
      render text: '\o/', status: 201
    end
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
