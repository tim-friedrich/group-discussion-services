class AdditionalUserFieldsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_additional_user_field, only: [:destroy, :edit]
  load_and_authorize_resource :discussion

  def new
    @additional_user_field = AdditionalUserField.new
  end

  def create
    @additional_user_field = AdditionalUserField.new(additional_user_field_params)

    respond_to do |format|
      if @additional_user_field.save
        format.html do 
          redirect_to edit_additional_user_field_path @additional_user_field
        end
      else
        format.html { render action: 'new' }
      end
    end
  end

  def index
    @additional_user_fields = AdditionalUserField.all.paginate(page: params[:additional_user_fields_page], per_page: 10)
  end

  def edit

  end

  def destroy
    @additional_user_field.user_field_options.each do | field |
      field.destroy
    end
    @additional_user_field.destroy
    redirect_to additional_user_fields_path
  end

  private

  def set_additional_user_field
    @additional_user_field = AdditionalUserField.find(params[:id])
  end

  def additional_user_field_params
    params.require(:additional_user_field).permit(:name, :field_type)
  end
end
