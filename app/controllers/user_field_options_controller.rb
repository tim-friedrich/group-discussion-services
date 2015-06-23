class UserFieldOptionsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :discussion

  def create
    @additional_user_field_id = params[:additional_user_field_id]
    values = params[:values].split("\r\n")
    puts values.to_s
    values.each do |value|
      puts value
      if value != ""
        user_field_option = UserFieldOption.new(value: value, additional_user_field_id: @additional_user_field_id)
        if !user_field_option.save
          bad_request()
        end
      end
    end 
    respond_to do |format|
      format.html do 
        redirect_to edit_additional_user_field_path @additional_user_field_id
      end
    end
  end

  def destroy

    @user_field = UserFieldOption.find(params[:id])
    @additional_user_field = @user_field.additional_user_field
    @user_field.destroy
    redirect_to edit_additional_user_field_path @additional_user_field
  end

  private

  def user_field_option_params
    params.require(:user_field_option).permit(:values, :additional_user_field_id)
  end
end
