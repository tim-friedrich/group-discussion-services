class ResearchInstitute < ActiveRecord::Base
  belongs_to :contact
  belongs_to :deputy, :class_name => "User", :foreign_key => "deputy_id"
  has_many :companies
  has_many :user_relations
  has_many :users, through: :user_relations

  accepts_nested_attributes_for :deputy
  accepts_nested_attributes_for :contact


  def discussions
    user_relations.where(role: Role.moderator).user.moderated_discussions
  end
end
