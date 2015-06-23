class AdditionalUserField < ActiveRecord::Base
  has_many :user_additional_user_fields
  has_many :user_field_options

  def self.new_fields_for(user)
    new_fields = []
    AdditionalUserField.all.each do | field |
      puts field.to_yaml
      puts UsersAdditionalUserField.where(user_id: user.id, additional_user_field_id: field.id).empty?
      if UsersAdditionalUserField.where(user_id: user.id, additional_user_field_id: field.id).empty?
        new_fields << (field)
      end
    end
    return new_fields
  end

  def type_class
    return 'radio' if field_type == "single_select"
    return 'checkbox' if field_type == "multiple_select"
  end
end
