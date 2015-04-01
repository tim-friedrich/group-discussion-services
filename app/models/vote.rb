class Vote < ActiveRecord::Base
  belongs_to :argument
  belongs_to :user
  validates :user_id, presence: true
  validates :argument_id, presence: true
  validates :user, uniqueness: { scope: :argument }

  scope :likes, ->{ where(is_like: true) }
  scope :dislikes, ->{ where(is_like: false) }
end
