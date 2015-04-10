class Company < ActiveRecord::Base
  belongs_to :contact
  has_many :discussions
  belongs_to :research_institute
  has_many :user_relations
  has_many :users, through: :user_relations

  accepts_nested_attributes_for :contact
end
