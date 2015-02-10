class Company < ActiveRecord::Base
  belongs_to :contact
  has_many :discussions
  belongs_to :research_institute

  accepts_nested_attributes_for :contact
end
