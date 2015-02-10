class ResearchInstitute < ActiveRecord::Base
  belongs_to :contact
  belongs_to :deputy, :class_name => "User", :foreign_key => "deputy_id"
  has_many :companies
  has_and_belongs_to_many :users
  has_many :discussions, through: :deputy
  
  accepts_nested_attributes_for :deputy
  accepts_nested_attributes_for :contact
end
