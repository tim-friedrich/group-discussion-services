class Argument < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  belongs_to :argument_type
  belongs_to :discussion
  has_many :votes

  validates :content, presence:true
  validates :user_id, presence:true
  validates :question_id, presence:true
  validates :argument_type, presence:true


  def is_voted_from?(user)
    !!self.votes.find_by(user_id: user.id)
  end
end
